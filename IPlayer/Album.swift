//
//  Album.swift
//  IPlayer
//
//  Created by Shashank Kannam on 8/15/17.
//  Copyright © 2017 Shashank Kannam. All rights reserved.
//

import Foundation

struct Album {
    
    var trackName: String!
    var artistName: String!
    var collectionName: String!
    var artworkUrl60: String!
    var previewUrl: String!
    
    init(trackName: String, artistName: String, collectionName: String, artworkUrl60: String, previewUrl: String) {
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.artworkUrl60 = artworkUrl60
        self.previewUrl = previewUrl
    }
}
