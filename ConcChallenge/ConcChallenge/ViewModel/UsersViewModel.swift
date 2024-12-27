//
//  UsersViewModel.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import Foundation
import Observation
import SwiftData
import SwiftUI

extension UsersListView {
    @Observable
    class ViewModel {
        let service = Service()

        @MainActor
        func populateUsers(context: ModelContext) async {
            do {
                let fetchedUsers = try await service.fetchData()
                // Map network users to SwiftData models and save to context
                for apiUser in fetchedUsers {
                    _ = mapToUser(apiUser: apiUser, context: context)
                }

            } catch {
                print("Error populating user infos.....: \(error.localizedDescription)")
            }
        }

        private func mapToUser(apiUser: APIUser, context: ModelContext) -> User {
            let user = User(
                id: apiUser.id,
                name: apiUser.name,
                company: apiUser.company,
                email: apiUser.email,
                about: apiUser.about,
                isActive: apiUser.isActive,
                registered: ISO8601DateFormatter().date(from: apiUser.registered) ?? Date.now
            )

            user.friends = apiUser.friends.map { apiFriend in
                let friend = Friend(id: apiFriend.id, name: apiFriend.name)
                context.insert(friend)
                return friend
            }

            context.insert(user)
            return user
        }
    }
}
