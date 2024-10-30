//
//  CrewMember.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 30/10/24.
//

import Foundation

struct CrewMember: Identifiable {
    var id = UUID()
    let role: String
    let astronaut: Astronaut
}
