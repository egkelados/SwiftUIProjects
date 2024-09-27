//
//  HapticEffectsView.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 27/9/24.
//

import CoreHaptics
import SwiftUI

struct HapticEffectsView: View {
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("Tap count:", action: complexSuccess)
            .onAppear(perform: prepareHaptics)
        
//        Button("Tap count:"){
//
//        }
//        .sensoryFeedback(.impact(weight: .heavy, intensity: 0.5), trigger: counter)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics
        else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            fatalError("\(error.localizedDescription)")
        }
    }
}

#Preview {
    HapticEffectsView()
}
