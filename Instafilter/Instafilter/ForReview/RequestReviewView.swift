//
//  RequestReviewView.swift
//  Instafilter
//
//  Created by Xristos Mantsos on 29/11/24.
//
import StoreKit
import SwiftUI

struct RequestReviewView: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Button("Leave a review"){
            requestReview()
            /// ask for review after,  the user has utilize the app several times
        }
    }
}

#Preview {
    RequestReviewView()
}
