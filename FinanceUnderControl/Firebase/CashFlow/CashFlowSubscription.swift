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

struct QueryConfiguration<Document: FirestoreDocument> {
    let lastDocument: Document?
    let filters: [Document.Filter]
}

final class CashFlowSubscription: CollectionService, CombineHelper {
    typealias Document = CashFlow

    struct Input {
        let start: Driver<Void>
        let fetchMore: Driver<Void>
        let queryConfiguration: Driver<QueryConfiguration<Document>>?
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
    private let errorTracker = DriverSubject<Error>()
    private let documents = DriverSubject<[QueryDocumentSnapshot]>()

    private lazy var query = firestore.getQuery(for: .cashFlows, orderedBy: Order.date(.reverse), limit: limit) {
        didSet { updateListener() }
    }
    private var listener: ListenerRegistration?
    private var limit = 10

    func transform(input: Input) -> Output {
        let loadingIndicator = DriverState(false)

        input.start.sinkAndStore(on: self) { vm, _ in
            loadingIndicator.send(true)
            vm.updateListener()
        }

        CombineLatest(input.start, input.fetchMore).map { $1 }
            .sinkAndStore(on: self) { vm, _ in
                vm.limit += 25
                vm.query = vm.query.limit(to: vm.limit)
                loadingIndicator.send(true)
            }

        if let queryConfiguration = input.queryConfiguration {
            CombineLatest(input.start, queryConfiguration).map { $1 }
                .sinkAndStore(on: self, action: { vm, configuration in
                    let filters = configuration.filters.map { $0.predicate }
                    var fieldValues: [Any] = []
                    if let lastCashFlow = configuration.lastDocument {
                        fieldValues.append(lastCashFlow.id)
                        fieldValues.append(lastCashFlow.nameLowercase)
                    }
                    vm.query = vm.firestore.getQuery(for: .cashFlows, orderedBy: Order.date(.reverse), filteredBy: filters, startAfter: fieldValues, limit: vm.limit)
                })
        }

        let cashFlows = CombineLatest(documents, storage.$categories)
            .map { result in
                result.0.map { doc -> CashFlow in
                    let categoryId = doc.getString(for: Field.categoryId)
                    let category = result.1.first(where: { $0.id == categoryId })!
                    return CashFlow(from: doc, category: category)
                }
            }
            .onNext { _ in loadingIndicator.send(false) }

        let canFetchMore = cashFlows
            .map(with: self, transform: { vm, cashFlows in
                !(vm.limit > cashFlows.count)
            })

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
