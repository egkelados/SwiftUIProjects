//
//  ViewsWithEnumbs.swift
//  BucketList
//
//  Created by Xristos Mantsos on 2/12/24.
//

import SwiftUI

private struct LoadingView: View {
    var body: some View {
        ProgressView()
    }
}

private struct SuccessView: View {
    var body: some View {
        Text("Success")
    }
}

private struct FailedView: View {
    var body: some View {
        Text("Failed")
    }
}

struct ViewsWithEnumbs: View {
    enum LoadingState {
        case loading, success, failed
    }

    @State private var loadingState = LoadingState.loading

    var body: some View {
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            FailedView()
        case .failed:
            SuccessView()
        }
    }
}

#Preview {
    ViewsWithEnumbs()
}
