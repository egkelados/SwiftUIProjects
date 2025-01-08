//
//  HitTestingView.swift
//  FlashZilla
//
//  Created by Xristos Mantsos on 8/1/25.
//

import SwiftUI

struct HitTestingView: View {
    var body: some View {
        VStack {
            Text("Hello")
            
            Spacer()
                .frame(height: 100)
           
            Text("World")
        }
        .contentShape(.rect)
        .onTapGesture {
            print("VStack tapped")
        }
    }
}
struct HitTestingView1: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped")
                }
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(.rect)
                .onTapGesture {
                    print("Circle tapped")
                }
                .allowsHitTesting(false)
                
        }
    }
}

#Preview {
    HitTestingView()
}
