//
//  ContentView.swift
//  Instafilter
//
//  Created by Xristos Mantsos on 27/11/24.
//

import SwiftUI
/// More infos about the State : A state itself is a struct, The setter which prints the value of the blur amount(observer) does not print the new value when the slider set the value because: the binding is changing the internally stored value and the property observer never gets triggered... Insted when the button when been tapped, is changing the property of State struct directly thats why we get the didSet observer printint the new value...!
/// The binding bypass the setter and adjust the stored value of the property
struct ContentView: View {
    @State private var blurAmount = 0.0 {
        didSet {
//            print("New value is \(blurAmount)")
        }
    }
    
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)

            Slider(value: $blurAmount, in: 1 ... 20)
                .onChange(of: blurAmount) {
                    print("New value ")
                }
                .onChange(of: blurAmount) { old, new in
                    print("New value is \(new)")
                }

            Button("Random blur") {
                blurAmount = Double.random(in: 1 ... 20)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
