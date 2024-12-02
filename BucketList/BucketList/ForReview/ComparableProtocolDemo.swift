//
//  ContentView.swift
//  BucketList
//
//  Created by Xristos Mantsos on 2/12/24.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    var fName: String
    var lName: String
    
    // Operator Overloaded..
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lName > rhs.lName
    }
}

struct ComparableProtocolDemo: View {
    let users = [
        User(fName: "Maria", lName: "Kati"),
        User(fName: "Kostas", lName: "Kati12412"),
        User(fName: "Nick", lName: "Kati12")
    ].sorted()
        
    

    var body: some View {
        List(users, id: \.id) {
            Text($0.fName)
        }
    }
}

#Preview {
    ComparableProtocolDemo()
}
