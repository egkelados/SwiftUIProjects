//
//  ContentView.swift
//  FlashZilla
//
//  Created by Xristos Mantsos on 8/1/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAmmount = 0.0
    @State private var finalAmount = 1.0
    @State private var currentAmmountR = Angle.zero
    @State private var finalAmountR = Angle.zero
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    var body: some View {
        VStack(spacing: 20) {
            let dragGesture = DragGesture()
                .onChanged { value in
                    offset = value.translation
                }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                }
            
            let pressGesture = LongPressGesture()
                .onEnded { _ in
                    withAnimation {
                        isDragging = true
                    }
                }
            
            let combined = pressGesture.sequenced(before: dragGesture)
                
            Circle()
                .fill(.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .rotationEffect(currentAmmountR + finalAmountR)
                .gesture(
                    RotateGesture()
                        .onChanged { value in
                            currentAmmountR = value.rotation
                        }
                        .onEnded { _ in
                            finalAmountR += currentAmmountR
                            currentAmmount = .zero
                        }
                )
            Text("Hello, world!")
                .onLongPressGesture(minimumDuration: 2) {
                    print("Long tapped")
                } onPressingChanged: { inProgress in
                    print("In progress: \(inProgress)")
                }

            Text("Gesture Modifiers : Magnify me")
                .scaleEffect(finalAmount + currentAmmount)
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            currentAmmount = value.magnification - 1
                        }
                        .onEnded { _ in
                            finalAmount += currentAmmount
                            currentAmmount = 0
                        }
                )
            VStack {
                Text("Gesture Modifiers : High priority")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .simultaneousGesture(TapGesture()
                .onEnded {
                    print("VStack Tapped")
                })
//            .highPriorityGesture(TapGesture()
//                .onEnded {
//                    print("VStack Tapped")
//                })
        }
        .padding()
    }
}

struct ContenntView: View {
    @State private var offset = CGSize.zero
    
    var body: some View {
        Text("Drag Me Demo")
            .padding()
            .background(Color.blue)
            .offset(x: offset.width, y: offset.height)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        offset = .zero
                    }
            )
            .border(Color.red, width: 2) // here the border indicates the original position of the Text Viuew
    }
}

#Preview {
    ContenntView()
}
