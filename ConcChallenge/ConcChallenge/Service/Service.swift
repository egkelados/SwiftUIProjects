//
//  Service.swift
//  ConcChallenge
//
//  Created by Xristos Mantsos on 9/12/24.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badResponse(Int)
    case decodingData
}

class Service {
    func fetchData() async throws -> [User] {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { throw NetworkError.badURL }

        let (data, _) = try await URLSession.shared.data(from: url)
        print(String(data: data, encoding: .utf8))

        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            return users
        } catch {
            print("Failed to decede the data...")
            throw NetworkError.decodingData
        }
    }
}
