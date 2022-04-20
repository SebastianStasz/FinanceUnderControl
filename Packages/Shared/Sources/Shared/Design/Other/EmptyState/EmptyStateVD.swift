//
//  EmptyStateVD.swift
//  Shared
//
//  Created by sebastianstaszczyk on 17/04/2022.
//

import Foundation

public struct EmptyStateVD {
    private let title: String
    private let description: String
    private let search: Search

    /// Allows to specify empty state view data to be used if the given data is empty and another data if the search result is empty.
    /// - Parameters:
    ///   - title: Title on the empty state view if there is no data.
    ///   - description: Description on the empty state view if there is no data.
    ///   - search: Empty state view data to be used if the search result is empty.
    public init(title: String, description: String, onSearch search: Search) {
        self.title = title
        self.description = description
        self.search = search
    }

    /// Allows to specify empty state view data to be used if the given data is empty.
    ///
    /// If the "isSearching" argument is true, the default empty view data will be used to indicate that the search result is empty.
    /// - Parameters:
    ///   - title: Title on the empty state view if there is no data.
    ///   - description: Description on the empty state view if there is no data.
    ///   - isSearching: Indicates whether an empty data is the result of the search createria.
    public init(title: String, description: String, isSearching: Bool = false) {
        self.title = title
        self.description = description
        self.search = .init(isSearching: isSearching)
    }

    var imageToDisplay: ImageDesign {
        search.isSearching ? .empty_state_search : .empty_state_1
    }

    var titleToDisplay: String {
        search.isSearching ? search.title : title
    }

    var descriptionToDisplay: String {
        search.isSearching ? search.description : description
    }

    public struct Search {
        let title: String
        let description: String
        let isSearching: Bool

        init(title: String = .empty_state_search_title, desc: String = .empty_state_search_description, isSearching: Bool = false) {
            self.title = title
            self.description = desc
            self.isSearching = isSearching
        }

        public init(title: String, description: String, isSearching: Bool) {
            self.init(title: title, desc: description, isSearching: isSearching)
        }
    }
}
