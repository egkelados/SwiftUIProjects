//
//  UsersViewModel.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import Foundation
import Observation

extension UsersListView {
    @Observable
    class ViewModel {
        let service = Service()
        var users = [User]()

        func populateUsers() async {
            do {
                let users = try await service.fetchData()
                self.users = users

            } catch {
                print("Error populating user infos.....")
            }
        }
    }
}
