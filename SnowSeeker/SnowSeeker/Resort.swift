//
//  Resort.swift
//  SnowSeeker
//
//  Created by Xristos Mantsos on 15/1/25.
//

import Foundation

struct Resort: Codable, Hashable, Identifiable {
    var id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example: Resort = allResorts[0]
    /// one line example
    // static let example = (Bundle.main.decode("resorts.json") as [Resort])[0]
}
