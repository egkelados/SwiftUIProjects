//
//  Dragable.swift
//  FlashZilla
//
//  Created by Xristos Mantsos on 10/1/25.
//

import SwiftUI

struct Dragable: View {
    let symbols = [
        "figure.badminton", "figure.cricket", "figure.fencing",
        "plus", "figure.golf", "figure.hockey",
        "figure.rugby", "figure.soccer", "figure.tennis",
        "star", "moon", "cloud", "sun.max", "wind", "drop",
        "leaf.arrow.triangle.circlepath", "flame", "bolt", "snowflake",
        "battery.100", "bolt.circle", "mic", "headphones", "tv", "camera",
        "airplane", "car", "bicycle", "bus", "tram", "checkmark", "person",
        "magnifyingglass", "house", "building", "desktopcomputer", "laptopcomputer",
        "phone", "square.and.arrow.up", "paperclip", "folder", "doc", "pencil", "scissors",
        "paintbrush", "person.crop.circle.badge.questionmark.ar", "gamecontroller", "thermometer.sun.circle", "play.circle",
        "music.note", "music.note.list", "guitars", "speaker.wave.3",
        "heart", "star.fill", "bell", "alarm", "calendar", "clock",
        "arrow.down.square.fill", "gift", "cart.fill", "umbrella", "candybarphone"
    ]
    @State private var dropImage = Image(systemName: "photo")
    @State private var counter = 0
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(symbols, id: \.self) { img in
                        Image(systemName: img)
                            .frame(minWidth: 50, minHeight: 50)
                            .background(.red)
                            .foregroundStyle(.white)
                            .draggable(Image(systemName: img))
                    }
                }
            }

            .frame(minWidth: 300, minHeight: 70)
            .background(.gray)

            Spacer()
            Text("Drop Here")
                .padding()
                .background(.gray)
                .clipShape(.buttonBorder)
                .dropDestination(for: Image.self) { items, _ in
                    if let firstImage = items.first {
                        dropImage = firstImage
                        counter += 1
                        return true
                    }
                    return false
                }
            HStack {
                dropImage
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding()
                Spacer()

                Text("Images ")
                    .padding()
                    .font(.title3)
                    .background(.green)
                    .clipShape(.capsule)
                    .customBadge(counter)
            }
        }
    }
}

#Preview {
    Dragable()
}

struct CustomBadge: ViewModifier {
    let count: Int
    let maxCountAmount: Int

    func body(content: Content) -> some View {
        // if the count is larger than zero, we want to add a badge
        if count > 0 {
            ZStack(alignment: .topTrailing) {
                content
                HStack(spacing: 0) {
                    // min returns the smallest value of either count, or the maxCountAmount
                    Text(min(count, maxCountAmount), format: .number)

                    // optionally adding a plus sign if our badge count gets too large to let the user know
                    // there are more badges than we want to display
                    if count > maxCountAmount {
                        Text("+")
                    }
                }
                .font(.system(size: 14))
                .foregroundStyle(.white)
                .padding(.horizontal, 5)
                // when the badge is a single digit, I like the badge to be close to a circle shape
                .padding(.vertical, count > 9 ? 7 : 5)
                .background(Color.red)
                // when the badge is more than one digit, I like the badge to look like a capsule
                .frame(height: count > 9 ? 17 : 19)
                .clipShape(Capsule())
            }
        } else {
            // if the count is less than or equal to zero, we don't want to add a badge
            content
        }
    }
}

extension View {
    // we want to give the developer the option for a max badge amount
    // so that the design won't overflow the content
    func customBadge(_ count: Int = 0, maxCountAmount: Int = 99) -> some View {
        modifier(CustomBadge(count: count, maxCountAmount: maxCountAmount))
    }
}
