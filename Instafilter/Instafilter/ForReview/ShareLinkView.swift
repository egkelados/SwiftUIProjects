//
//  ShareLinkView.swift
//  Instafilter
//
//  Created by Xristos Mantsos on 29/11/24.
//

import SwiftUI

struct ShareLinkView: View {
    var body: some View {
        
        ///option 1
//        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift here"), message: Text("Check this stuff!"))
        ///option 2
//        ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
//            Label("Spread the word about Swift", systemImage: "swift")
//        }
        ///option 3
        let example = Image(.character)
        ShareLink(item: example, preview: SharePreview("Character", image: example)){
            Label("Click to share", systemImage: "airplane")
        }
    }
}

#Preview {
    ShareLinkView()
}
