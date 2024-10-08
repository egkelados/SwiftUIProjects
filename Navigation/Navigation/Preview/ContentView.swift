//
//  ContentView.swift
//  Navigation
//
//  Created by Xristos Mantsos on 19/9/24.
//

//TODO: Make a View and populate the details from the "students.json"
import SwiftUI

struct Student: Hashable{
    var id = UUID()
    var name: String
    var age: Int
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0 ..< 100) { i in
                NavigationLink("Select \(i)", value: i)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .navigationDestination(for: Student.self) { student in
                Text("You selected \(student.name)")
            }
        }
    }
}

#Preview {
    ContentView()
}
