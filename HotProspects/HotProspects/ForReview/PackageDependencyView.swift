//
//  PackageDependencyView.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 2/1/25.
//

import SamplePackage
import SwiftUI

struct PackageDependencyView: View {
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.formatted()
    }
    
    var body: some View {
        print(results)
        return Text(results)
        
    }
}

#Preview {
    PackageDependencyView()
}
