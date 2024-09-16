//
//  UserDefaultsView.swift
//  iExpense
//
//  Created by Xristos Mantsos on 13/9/24.
//

import SwiftUI

struct UserInfos: Codable {
    let firstName: String
    let lastName: String
}

struct UserDefaultsView: View {
    @State private var user = UserInfos(firstName: "Mike", lastName: "Jason")
    var body: some View {
        
        Button("Save User"){
        let encoder = JSONEncoder()
        
            if let data = try? encoder.encode(user){ // convert into JSON
                UserDefaults.standard.set(data, forKey: "UserData")
            }
                
                }
    }
}

#Preview {
    UserDefaultsView()
}
