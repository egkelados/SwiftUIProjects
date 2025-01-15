//
//  GroupsTransparentLayoutContainersView.swift
//  SnowSeeker
//
//  Created by Xristos Mantsos on 15/1/25.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct GroupsTransparentLayoutContainersView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
    }
}


struct ViewThatFitsDemo: View {
    var body: some View {
        ViewThatFits {
            Rectangle()
                .frame(width: 600, height: 200)

            Circle()
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    ViewThatFitsDemo()
}
