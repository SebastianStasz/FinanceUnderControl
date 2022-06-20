//
//  LoadingIndicator.swift
//  Shared
//
//  Created by sebastianstaszczyk on 20/06/2022.
//

import SwiftUI

public struct LoadingIndicator: View {

    private let isLoading: Bool

    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }

    public var body: some View {
        if isLoading { ProgressView() }
    }
}

// MARK: - Preview

struct SLoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator(isLoading: true)
        LoadingIndicator(isLoading: true).darkScheme()
    }
}
