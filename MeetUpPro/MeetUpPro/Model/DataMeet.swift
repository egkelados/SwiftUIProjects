//
//  Data.swift
//  MeetUpPro
//
//  Created by Xristos Mantsos on 27/12/24.
//

import Foundation
import SwiftUI

struct DataMeet: Codable, Hashable, Identifiable {
    var id: UUID = UUID() 
    var image: Data
    var name: String
}
