//
//  DetailsView.swift
//  HabbitApp
//
//  Created by Xristos Mantsos on 21/11/24.
//

import SwiftUI

struct DetailsView: View {
    let habbit: HabbitViewModel
    @State var vm: HabbitListViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) {
                        phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFit()
                        } else if phase.error != nil {
                            Text("There was an error uploading the photo!")
                        } else {
                            ProgressView()
                        }
                        
                        DividerView()

                        Text(habbit.description)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical)

                        DividerView()

                        Button("Increment Completion") {
                            vm.incrementCount(for: habbit)
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        
                        Button("Reset Counting") {
                            vm.resetCounting(for: habbit)
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .padding()
                    }
                }
                .navigationTitle("Habbit")
            }
        }
    }
}

#Preview {
    DetailsView(habbit: HabbitViewModel(habbit: Habbits(title: "dasda", category: .finance, description: "dasdadasdsadasda")), vm: HabbitListViewModel())
}
