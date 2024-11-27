//
//  CoreImageView.swift
//  Instafilter
//
//  Created by Xristos Mantsos on 27/11/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

/// 3 types of images : CGImage / UIImage / CIImage

struct CoreImageView: View {
    @State private var image: Image?
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear {
            loadImage()
        }
    }

    func loadImage() {
        let inputImage = UIImage(resource: .character)
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        let currentFilter = CIFilter.pixellate()

        currentFilter.inputImage = beginImage
        let amount = 1.1
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }

        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }

        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }

        

        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        let uiImage = UIImage(cgImage: cgImage)
        image = Image(uiImage: uiImage)
    }

    ///    this is with the modern api
//    func loadImage() {
//        let inputImage = UIImage(resource: .character)
//        let beginImage = CIImage(image: inputImage)
//
//        let context = CIContext()
    ////        let currentFilter = CIFilter.crystallize()
    ////        currentFilter.radius = 120
//        let currentFilter = CIFilter.twirlDistortion()
//        currentFilter.radius = 500
//        currentFilter.center = CGPoint(x: inputImage.size.width / 1.6, y: inputImage.size.height / 1.2)
//
    ////        let currentFilter = CIFilter.pixellate()
    ////        currentFilter.scale = 5
//
    ////        let currentFilter = CIFilter.comicEffect()
//
//        currentFilter.inputImage = beginImage
    ////        let currentFilter = CIFilter.sepiaTone()
    ////        currentFilter.intensity = 2
//
//        guard let outputImage = currentFilter.outputImage else { return }
//        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
//        let uiImage = UIImage(cgImage: cgImage)
//        image = Image(uiImage: uiImage)
//    }
}

#Preview {
    CoreImageView()
}
