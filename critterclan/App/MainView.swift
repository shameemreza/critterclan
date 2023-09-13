//
//  MainView.swift
//  critterclan
//
//  Created by Shameem Reza on 25/5/21.
//

import SwiftUI

struct MainView: View {
    // MARK: - PROPERTIES
   
    // MARK: - BODY
    var body: some View {
        TabView {
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
                   .tabItem {
                       Image(systemName: "square.grid.2x2")
                       Text("Browse")
                   }
            
            VideoListView()
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("Watch")
                }
            
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Location")
                }
            
            GalleryView()
                .tabItem {
                    Image(systemName: "photo")
                    Text("Gallery")
                }
            
        }//: TAB
    }
    
    
    // MARK: - PREVIEW
    
//    struct MainView_Previews: PreviewProvider {
//        static var previews: some View {
//            MainView(favoriteList: favoriteList, allAnimals: allAnimals)
//        }
//    }
}
