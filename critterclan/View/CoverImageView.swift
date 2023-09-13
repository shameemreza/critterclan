//
//  CoverImageView.swift
//  critterclan
//
//  Created by Shameem Reza on 25/5/21.
//

import SwiftUI

struct CoverImageView: View {
    // MARK: - PROPERTIES
    
    let coverImages: [CoverImage] = Bundle.main.decode("covers.json")
    @State private var scrollValue: Int = 0
    @State private var isAutoScrollEnabled = true
    let scrollInterval: TimeInterval = 3.0 // Change to 3 seconds
    
    // MARK: - BODY
    var body: some View {
        TabView(selection: $scrollValue) {
            ForEach(coverImages.indices, id: \.self) { index in
                Image(coverImages[index].name)
                    .resizable()
                    .scaledToFill()
                    .tag(index)
                    .onTapGesture {
                        // Stop auto-scrolling when the user taps an image
                        isAutoScrollEnabled = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            // Resume auto-scrolling after 4 seconds
                            isAutoScrollEnabled = true
                        }
                    }
            } //: LOOP
        } //: TAB
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            startAutoScroll()
        }
    }
    // autoscroll function 
    func startAutoScroll() {
        Timer.scheduledTimer(withTimeInterval: scrollInterval, repeats: true) { timer in
            withAnimation {
                if isAutoScrollEnabled {
                    scrollValue = (scrollValue + 1) % coverImages.count
                }
            }
        }
    }
}

// MARK: - PREVIEW
struct CoverImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageView()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
