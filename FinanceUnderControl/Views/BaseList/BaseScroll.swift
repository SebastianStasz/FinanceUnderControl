//
//  BaseScroll.swift
//  FinanceUnderControl
//
//  Created by sebastianstaszczyk on 21/06/2022.
//

import Shared
import SwiftUI

struct BaseScroll<Item: Identifiable & Equatable, Content: View>: View {
    typealias ViewData = BaseListVD<Item>

    private let viewData: ViewData
    private let emptyTitle: String
    private let emptyDescription: String
    private let isSearching: Bool
    private var topPadding: CGFloat = .xlarge
    private let content: () -> Content

    var body: some View {
        ScrollView {
            content()
                .padding(.bottom, .xlarge)
                .padding(.top, topPadding)
        }
        .emptyState(listVD: viewData, title: emptyTitle, description: emptyDescription, isSearching: isSearching)
        .background(Color.backgroundPrimary)
    }

    init(viewData: ViewData, emptyTitle: String, emptyDescription: String, isSearching: Bool = false, @ViewBuilder content: @escaping  () -> Content) {
        self.viewData = viewData
        self.emptyTitle = emptyTitle
        self.emptyDescription = emptyDescription
        self.isSearching = isSearching
        self.content = content
    }

    init(viewData: ViewData, isSearching: Bool = false, @ViewBuilder content: @escaping  () -> Content) {
        self.viewData = viewData
        self.content = content
        self.isSearching = isSearching
        emptyTitle = "No elements"
        emptyDescription = "Desc"
    }

    func topPadding(_ padding: CGFloat) -> BaseScroll {
        var baseScroll = self
        baseScroll.topPadding = padding
        return baseScroll
    }
}

// MARK: - Preview

//struct BaseScroll_Previews: PreviewProvider {
//    static var previews: some View {
//        BaseScroll()
//        BaseScroll().darkScheme()
//    }
//}
