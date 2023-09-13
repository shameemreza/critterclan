//
//  AnimalDetailView.swift
//  critterclan
//
//  Created by Shameem Reza on 25/5/21.
//

import SwiftUI


struct AnimalDetailView: View {
    //MARK: - PROPERTIES
    @State private var isAnimating = false
    @EnvironmentObject var favorites: Favorites
    let animal: Animal
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                // HERO IMAGE
                Image(animal.image)
                    .resizable()
                    .scaledToFit()
                    
                
                // TITLE
                Text(animal.name.uppercased())
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)
                    .foregroundColor(.primary)
                    .background(
                        Color.accentColor
                            .frame(height: 6)
                            .offset(y: 24)
                    )
                
                // HEADLINE
                Text(animal.headline)
                    .font(.headline)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.accentColor)
                    .padding(.horizontal)
                
                // GALLERY
                Group {
                    HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Wilderness in Pictures")
                } //: GALLERY GROUP
                .padding(.horizontal)
                
                InsetGalleryView(animal: animal)
                
                // FACTS
                Group {
                    HeadingView(headingImage: "questionmark.circle", headingText: "Did You Know?")
                    
                    InsetFactView(animal: animal)
                } //: FACTS GROUP
                .padding(.horizontal)
                
                // DESCRIPTION
                Group {
                    HeadingView(headingImage: "info.circle", headingText: "All about \(animal.name)")
                    
                    Text(animal.description)
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        .layoutPriority(1)
                } //: DESCRIPTION GROUP
                .padding(.horizontal)
                
                // MAP
                Group {
                    HeadingView(headingImage: "map", headingText: "National Parks")
                    
                    InsetMapView()
                } //: MAPGROUP
                    .padding(.horizontal)
                
                // LINK
                
                Group {
                    HeadingView(headingImage: "books.vertical", headingText: "Learn More")
                    ExternalWeblinkView(animal: animal)
                } //: LINK GROUP
                .padding(.horizontal)
                
                Button {
                           withAnimation {
                               isAnimating.toggle()
                               if favorites.contains(animal) {
                                   favorites.remove(animal)
                               } else {
                                   favorites.add(animal)
                               }
                           }
                       } label: {
                           HStack {
                               Image(systemName: favorites.contains(animal) ? "heart.fill" : "heart")
                               Text(favorites.contains(animal) ? "Remove from Favorites" : "Add to Favorites")
                           }
                           .scaleEffect(isAnimating ? 1.2 : 1.0) // Adjust the scale factor as desired
                       }
                       .buttonStyle(.borderless)
                       .padding()

                
            } //: VSTACK
            .navigationBarTitle("Learn about \(animal.name)", displayMode: .inline)
            
          
            
        } //:SCROLL
        
        
        
    }
    
 
    
}

   //MARK: - PreView
struct AnimalDetailView_Previews: PreviewProvider {
    static let animals: [Animal] = Bundle.main.decode("animals.json")
    static var previews: some View {
        NavigationView {
            AnimalDetailView(animal: animals[1])
        }
        .previewDevice("iPhone 11 Pro")

    }
}
