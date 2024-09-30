//
//  Order.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 27/9/24.
//

import Foundation

@Observable
class Order {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

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

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var isValid: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
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
}
