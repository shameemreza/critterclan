//
//  ContentView.swift
//  critterclan
//
//  Created by Shameem Reza on 25/5/21.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @StateObject var favorites = Favorites()
    let animal: Animal
    let animals: [Animal] = Bundle.main.decode("animals.json")
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    
    @State private var isGridViewActive: Bool = false
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Int = 1
    @State private var toolbarIcon: String = "square.grid.2x2"
    
    // MARK: - FUNCTION
    
    func gridSwitch() {
        gridLayout = Array(repeating: .init(.flexible()), count: gridLayout.count % 3 + 1)
        gridColumn = gridLayout.count
        print("grid Number: \(gridColumn)")
        
        // MARK: - TOOLBAR IMAGE
        switch gridColumn {
        case 1: toolbarIcon = "square.grid.2x2"
        case 2: toolbarIcon = "square.grid.3x2"
        case 3: toolbarIcon = "rectangle.grid.1x2"
        default: toolbarIcon = "square.grid.2x2"
        }
    }
    
    // MARK: - BODY
    var body: some View {
    
        NavigationView {
            Group {
                if !isGridViewActive {
                    List {
                        // Cover image view
                        CoverImageView()
                            .frame(height: 300)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))

                        // Iterate through animals and create navigation links
                        ForEach(animals) { animal in
                            NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                AnimalListItemView(animal: animal)

                                // Show favorite animales 
                                
                                if favorites.contains(animal) {
                                    Spacer()
                                    Image(systemName: "heart.fill")
                                        .accessibilityLabel("This is a favorite animal")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }

                        // Credits view
                        CreditsView()
                            .modifier(CenterModifier())
                    }
                    .listStyle(GroupedListStyle()) // Remove the default list style
                    .background(Color.clear) // Clear background
                    .ignoresSafeArea()
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(animals) { animal in
                                NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                    AnimalGriditemView(animal: animal)


                                }
                            }
                        }
                        .padding(10)
                        .animation(.easeIn)
                    }
                }
            }
            .navigationBarTitle("Critter Clan", displayMode: .large)
            .padding(.top)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        // LIST
                        Button(action: {
                            print("List View Activated")
                            isGridViewActive = false
                            haptics.impactOccurred()
                        }) {
                            Image(systemName: "square.fill.text.grid.1x2")
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .primary : .accentColor)
                        }

                        // GRID
                        Button(action: {
                            print("Grid view is activated")
                            isGridViewActive = true
                            haptics.impactOccurred()
                            gridSwitch()
                        }) {
                            Image(systemName: toolbarIcon)
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .accentColor : .primary)
                        }
                        
                    }
                    
                    
                    
                }
            }
        }
        .environmentObject(favorites)


         //: NAVIGATION
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(animal: Animal(
            id: "1",
            name: "Sample Animal",
            headline: "This is a sample headline",
            description: "This is a sample animal description",
            link: "https://example.com",
            image: "sample_image",
            gallery: ["image1", "image2"],
            fact: ["fact1", "fact2"]
        ))
        .previewDevice("iPhone Pro 11")
    }
}
