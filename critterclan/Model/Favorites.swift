//
//  Favorites.swift
//  critterclan
//
//  Created by Yashraj jadhav on 13/09/23.
//

import SwiftUI

class Favorites: ObservableObject {
  @Published var Animals: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        if let savedAnimals = UserDefaults.standard.array(forKey: saveKey) as? [String] {
            Animals = Set(savedAnimals)
        } else {
            Animals = []
        }
    }


    // returns true if our set contains this animal
    func contains(_ animal: Animal) -> Bool {
        Animals.contains(animal.id)
    }

    // adds the animal to our set, updates all views, and saves the change
    func add(_ animal: Animal) {
        objectWillChange.send()
        Animals.insert(animal.id)
        save()
    }

    // removes the animal from our set, updates all views, and saves the change
    func remove(_ animal: Animal) {
        objectWillChange.send()
        Animals.remove(animal.id)
        save()
    }

    func save() {
        UserDefaults.standard.set(Array(Animals), forKey: saveKey)
    }

}


