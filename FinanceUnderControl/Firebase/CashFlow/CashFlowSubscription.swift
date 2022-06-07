//
//  CashFlowSubscription.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 19/05/2022.
//

import Combine
import FirebaseFirestore
import Foundation
import SSUtils

final class CashFlowSubscription: CollectionService, CombineHelper {
    typealias Document = CashFlow

    struct Input {
        let queryConfiguration: Driver<QueryConfiguration<Document>>
    }

    struct Output {
        let cashFlows: Driver<[CashFlow]>
        let canFetchMore: Driver<Bool>
        let isLoading: Driver<Bool>
        let errors: Driver<Error>
    }

    var cancellables: Set<AnyCancellable> = []
    private let firestore = FirestoreService.shared
    private let storage = CashFlowGroupingService.shared
    private var listener: ListenerRegistration?

    private let errorTracker = DriverSubject<Error>()
    private let documents = DriverSubject<[QueryDocumentSnapshot]>()

    private lazy var query = firestore.getQuery(for: .cashFlows, configuration: QueryConfiguration<Document>(sorters: [Order.date(.reverse)], limit: 0)) {
        didSet { updateListener() }
    }

    func transform(input: Input) -> Output {
        let loadingIndicator = DriverState(false)

        let configuration = input.queryConfiguration
            .onNext(on: self, perform: { vm, configuration in
                vm.query = vm.firestore.getQuery(for: .cashFlows, configuration: configuration)
                loadingIndicator.send(true)
            })

        let cashFlows = CombineLatest(documents, storage.$categories)
            .map { result in
                result.0.map { doc -> CashFlow in
                    let categoryId = doc.getString(for: Field.categoryId)
                    // TODO: Sometimes it fails
                    let category = result.1.first(where: { $0.id == categoryId })!
                    return CashFlow(from: doc, category: category)
                }
            }

        let canFetchMore = cashFlows
            .withLatestFrom(configuration) { cashFlows, config -> Bool in
                guard let limit = config.limit else { return false }
                return !(cashFlows.count < limit)
            }
            .onNext { _ in loadingIndicator.send(false) }

        return Output(cashFlows: cashFlows.asDriver,
                      canFetchMore: canFetchMore.asDriver,
                      isLoading: loadingIndicator.asDriver,
                      errors: errorTracker.asDriver)
    }

    private func updateListener() {
        listener = query.addSnapshotListener { [weak self] querySnapshot, error in
            if let querySnapshot = querySnapshot {
                self?.documents.send(querySnapshot.documents)
            } else if let error = error {
                self?.errorTracker.send(error)
            }
        }
    }
}
