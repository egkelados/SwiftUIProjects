//
//  ActualAppView.swift
//  Instafilter
//
//  Created by Xristos Mantsos on 29/11/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ActualAppView: View {
    @State private var proccessedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = .sepiaTone()
    @State private var showingFilters = false
    @State private var showButtons = true
    
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if let proccessedImage {
                        proccessedImage
                            .resizable()
                            .scaledToFit()
                        
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem) {
                    loadImage()
                }
                
                Spacer()
                VStack {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProccessing)
                            .disabled(showButtons)
                    }
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius)
                            .onChange(of: filterRadius, applyProccessing)
                            .disabled(showButtons)
                    }
                }
                HStack {
                    Button("Change Filter") {
                        let filterNames = CIFilter.filterNames(inCategory: nil)
                        filterNames.forEach { print($0) }
                        if let filter = CIFilter(name: "CIScreenBlendMode") {
                            print("Filter Name: \(filter.name)")
                            print("Attributes: \(filter.attributes)")
                        }

                        changeFilter()
                    }
//                    .disabled(showButtons)
                    
                    Spacer()
                    
                    if let proccessedImage {
                        ShareLink(item: proccessedImage, preview: SharePreview("Instafilter Image", image: proccessedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Selected Filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Commic Effect") { setFilter(CIFilter.comicEffect()) }
                Button("Zoom Blur") { setFilter(CIFilter.zoomBlur()) }
                Button("Bump Distortion") { setFilter(CIFilter.bumpDistortion()) }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            showButtons = false
            applyProccessing()
        }
    }
    
    func applyProccessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }

        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey) }

        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius * 300, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 2, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: 350, y: 250), forKey: kCIInputCenterKey) }
        
        if inputKeys.contains(kCIInputAmountKey) { currentFilter.setValue(filterIntensity * 40, forKey: kCIInputAmountKey) }

        guard let outputImage = currentFilter.outputImage else { return }
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        proccessedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        filterCount += 1
        
        if filterCount >= 3 {
            requestReview()
        }
    }
}

#Preview {
    ActualAppView()
}
