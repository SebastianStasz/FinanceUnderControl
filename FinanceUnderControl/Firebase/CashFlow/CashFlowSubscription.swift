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
        let fetchMore: Driver<Void>
    }

    struct Output {
        let cashFlows: Driver<[CashFlow]>
        let canFetchMore: Driver<Bool>
        let errors: Driver<Error>
    }

    private let documents = DriverSubject<[QueryDocumentSnapshot]>()
    private let errorTracker = DriverSubject<Error>()

    var cancellables: Set<AnyCancellable> = []
    private var limit = 10
    private let firestore = FirestoreService.shared
    private let storage = CashFlowGroupingService.shared
    private lazy var query = firestore.getQuery(for: .cashFlows, orderedBy: Order.date(.reverse), limit: limit)

    func transform(input: Input) -> Output {
        updateListener()

        input.fetchMore.sinkAndStore(on: self) { vm, _ in
            vm.limit += 10
            vm.query = vm.query.limit(to: vm.limit)
            vm.updateListener()
        }

        let cashFlows = CombineLatest(documents, storage.$categories)
            .map { result in
                result.0.map { doc -> CashFlow in
                    let categoryId = doc.getString(for: Field.categoryId)
                    let category = result.1.first(where: { $0.id == categoryId })!
                    return CashFlow(from: doc, category: category)
                }
            }

        let canFetchMore = cashFlows.map { $0.isNotEmpty }

        return Output(cashFlows: cashFlows.asDriver,
                      canFetchMore: canFetchMore.asDriver,
                      errors: errorTracker.asDriver)
    }

    private func updateListener() {
        query.addSnapshotListener { [weak self] querySnapshot, error in
            if let querySnapshot = querySnapshot {
                self?.documents.send(querySnapshot.documents)
            } else if let error = error {
                self?.errorTracker.send(error)
            }
        }
    }
}
