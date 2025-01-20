//
//  ActualAppView.swift
//  FlashZilla
//
//  Created by Xristos Mantsos on 8/1/25.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ActualAppView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    @State private var showingEditScreen = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var vm = CardViewModel()

    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()

            GameView(vm: vm)
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.capsule)
                    }
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()

            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                AccessibilityView(vm: vm)
            }
        }
        .onReceive(timer) { _ in
            guard vm.isActive else { return }

            if vm.timeRemaining > 0 {
                vm.timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { _, phaseNew in
            if phaseNew == .active {
                if !vm.cards.isEmpty {
                    vm.isActive = true
                }
            } else {
                vm.isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: vm.resetCards, content: EditCardsView.init)
        .onAppear(perform: vm.resetCards)
    }
}

#Preview {
    ActualAppView()
}

struct AccessibilityView: View {
    let vm: CardViewModel
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    withAnimation {
                        vm.removeCard(at: vm.cards.count - 1)
                    }
                } label: {
                    Image(systemName: "xmark.circle")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(.circle)
                }
                .accessibilityLabel("Wrong")
                .accessibilityHint("Mark your answer as being incorrect.")

                Spacer()

                Button {
                    withAnimation {
                        vm.removeCard(at: vm.cards.count - 1)
                    }
                } label: {
                    Image(systemName: "checkmark.circle")
                        .padding()
                        .background(.black.opacity(0.7))
                        .clipShape(.circle)
                }
                .accessibilityLabel("Correct")
                .accessibilityHint("Mark your answer as being correct.")
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
        }
    }
}

struct GameView: View {
    let vm: CardViewModel
    var body: some View {
        VStack {
            Text("Time is : \(vm.timeRemaining)")
                .font(.title)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(.black.opacity(0.77))
                .clipShape(.capsule)
            ZStack {
                ForEach(0 ..< vm.cards.count, id: \.self) { index in

                    CardView(card: vm.cards[index]) {
                        withAnimation {
                            vm.removeCard(at: index)
                        }
                    }
                    .stacked(at: index, in: vm.cards.count)
                    .accessibilityHidden(index < vm.cards.count - 1)
                    .allowsHitTesting(index == vm.cards.count - 1)
                }
            }
            .allowsHitTesting(vm.timeRemaining > 0)

            if vm.cards.isEmpty {
                Button("Start Again", action: vm.resetCards)
                    .padding()
                    .background(.white)
                    .foregroundStyle(.black)
                    .clipShape(.capsule)
            }
        }
    }
}
