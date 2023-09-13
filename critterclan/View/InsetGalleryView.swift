//
//  InsetGalleryView.swift
//  critterclan
//
//  Created by Shameem Reza on 25/5/21.
//

import SwiftUI
struct InsetGalleryView: View {
    // MARK: - PROPERTIES
    
    let animal: Animal
    @State private var scrollValue: Int = 0
    let maxScrollValue = 4
    let scrollInterval: TimeInterval = 3.0 // Change to 3 seconds
    @State private var scrollOffset: CGFloat = 0
    
    // MARK: - BODY
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 15) {
                    ForEach(animal.gallery.indices, id: \.self) { index in
                        Image(animal.gallery[index])
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(30)
                            .id(index)
                    }
                }
                .onAppear {
                    startAutoScroll(proxy: proxy)
                }
                .frame(width: UIScreen.main.bounds.width * CGFloat(animal.gallery.count), alignment: .leading)
            }
        }
    }
    
    func startAutoScroll(proxy: ScrollViewProxy) {
        Timer.scheduledTimer(withTimeInterval: scrollInterval, repeats: true) { timer in
            DispatchQueue.main.async { // Ensure UI updates are performed on the main thread
                withAnimation {
                    scrollValue += 1
                    if scrollValue >= animal.gallery.count {
                        scrollValue = 0
                    }
                    proxy.scrollTo(scrollValue, anchor: .leading) // Use .leading anchor to scroll to the start of the next image
                }
            }
        }
    }

}

    





// MARK: - PREVIEW
struct InsetGalleryView_Previews: PreviewProvider {
    static let animals: [Animal] = Bundle.main.decode("animals.json")
    static var previews: some View {
        InsetGalleryView(animal: animals[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}


