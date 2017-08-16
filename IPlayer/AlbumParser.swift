//
//  AlbumParser.swift
//  IPlayer
//
//  Created by Shashank Kannam on 8/15/17.
//  Copyright © 2017 Shashank Kannam. All rights reserved.
//

import Foundation

class AlbumParser {

    class func getAlbums(parseWithData: Data) -> [Album] {
        
        var albums = [Album]()
        guard let parsedData = try? JSONSerialization.jsonObject(with: parseWithData, options: .allowFragments) else { return albums }
        guard let albumsData = parsedData as? Dictionary<String, Any> else {return albums}
        guard let albumsArray = albumsData["results"] as? [Dictionary<String, Any>] else { return albums }
        for metaData in albumsArray {
            var album = Album(trackName: "", artistName: "", collectionName: "", artworkUrl60: "", previewUrl: "")
            if let trackName = metaData["trackName"] as? String {
                album.trackName = trackName
            }
            if let collectionName = metaData["collectionName"] as? String {
                album.collectionName = collectionName
            }
            if let artistName = metaData["artistName"] as? String {
                album.artistName = artistName
            }
            if let artworkUrl60 = metaData["artworkUrl60"] as? String {
                album.artworkUrl60 = artworkUrl60
            }
            if let previewUrl = metaData["previewUrl"] as? String {
                album.previewUrl = previewUrl
            }
            albums.append(album)
            
        }
        return albums
    }
}
