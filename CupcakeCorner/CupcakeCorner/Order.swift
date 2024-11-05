//
//  Order.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 27/9/24.
//

import Foundation
import Observation

struct UserInfos: Codable, Identifiable {
    var id = UUID()
    let name: String
    let streetAddress: String
    let city: String
    let zip: String
}

@Observable
class Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    private let dataKey = "userData"

    var users: [UserInfos] {
        get {
            loadUserInfos()
        }
        set {
            if let users = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.setValue(users, forKey: dataKey)
            }
        }
    }

    func saveUserInfos() {
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.setValue(encoded, forKey: dataKey)
        }
    }

    func loadUserInfos() -> [UserInfos] {
        if let savedUsers = UserDefaults.standard.data(forKey: "userData") {
            if let decodedUsers = try? JSONDecoder().decode([UserInfos].self, from: savedUsers) {
                return decodedUsers
            }
        }
        return []
    }

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false

    var addSprinkles = false

    var name = "qwe"
    var streetAddress = "qwe"
    var city = "qwe"
    var zip = "qwe"

    var isValid: Bool {
        if name.isEmptyOrWhitespace() || streetAddress.isEmptyOrWhitespace() || city.isEmptyOrWhitespace() || zip.isEmptyOrWhitespace() {
            return false
        }
        return true
    }

    var cost: Decimal {
        var cost = Decimal(quantity) * 2.0

        cost += Decimal(type) / 2

        if addSprinkles {
            cost += 0.5
        }
        if extraFrosting {
            cost += 1
        }

        return cost
    }

    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
}
