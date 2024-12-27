//
//  Data.swift
//  MeetUpPro
//
//  Created by Xristos Mantsos on 27/12/24.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class DataMeet {
    @Attribute(.externalStorage) var image: Data
    var name: String
    
    init(image: Data, name: String) {
        self.image = image
        self.name = name
    }
}
