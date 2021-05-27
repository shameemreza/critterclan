//
//  VideoModel.swift
//  critterclan
//
//  Created by Shameem Reza on 27/5/21.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    
    //COMPUTED PROPERTY
    var thumbnail: String {
        "video-\(id)"
    }
}
