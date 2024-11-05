//
//  ObservableView.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 26/9/24.
//

import Observation
import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }

    var name: String = "Taylor"
}

struct ObservableView: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }

    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let string = String(decoding: data, as: UTF8.self)
        print(string)
    }
}

#Preview {
    ObservableView()
}
