//
//  HabbitViewModel.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 20/11/24.
//

import Foundation
import Observation

@Observable
class HabbitViewModel {
    var habbits = [Habbits]()
    private let habbitService = HabbitService()
    
    func loadHabbits() {
        self.habbits = habbitService.fetchHabbits()
    }
    
    func deleteHabbit(at index: IndexSet) {
        habbits.remove(atOffsets: index)
    }
}
