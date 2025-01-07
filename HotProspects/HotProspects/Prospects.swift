//
//  Prospects.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 3/1/25.
//

import Foundation
import SwiftData

@Model
class Prospects {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var joinDate: Date
    
    init(name: String, emailAddress: String, isContacted: Bool, joinDate: Date) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.joinDate = joinDate
    }
}
