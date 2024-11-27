//
//  SwiftDataView.swift
//  Bookworm
//
//  Created by Xristos Mantsos on 30/9/24.
//
import SwiftData
import SwiftUI

struct SwiftDataView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Student.name) var students: [Student]
    
    
    var body: some View {
        NavigationStack {
            List(students){student in
                Text(student.name)
            }
            .navigationTitle("ClassRoom")
            .toolbar{
                Button("Add"){
                    let firstName = ["Nick", "Ann", "Mary", "Bob", "Ronaldo"]
                    let lastName = ["Pedro", "Varry", "Cortney", "Marley", "Triger"]
                    
                    let chosenFirstName = firstName.randomElement()!
                    let chosenLastName = lastName.randomElement()!
                    
                    let student = Student(id: UUID(), name: "\(chosenFirstName) \(chosenLastName)")
                    
                    modelContext.insert(student)
                }
                
            }
        }
    }
}

#Preview {
    SwiftDataView()
        .modelContainer(for: Student.self)
}
