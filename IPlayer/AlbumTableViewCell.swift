//
//  AlbumTableViewCell.swift
//  IPlayer
//
//  Created by Shashank Kannam on 8/15/17.
//  Copyright © 2017 Shashank Kannam. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackNameLBL: UILabel!
    @IBOutlet weak var collectionNameLBL: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    func configureCell(album: Album) {
        trackNameLBL.text = album.trackName
        collectionNameLBL.text = album.collectionName
        downloadImage(url: album.artworkUrl60)
    }
    
    func downloadImage(url: String) {
        albumImageView.image = nil
        DispatchQueue.global(qos: .userInitiated).async {
            ImageDownloader.getImageFromURL(imgUrl: url) { [weak self] (img, error) in
                DispatchQueue.main.async {
                    self?.albumImageView.image = img
                }
            }
        }
    }
    
    class func reuseID() -> String {
        return "AlbumCell"
    }
    
    class func nibName() -> String {
        return "AlbumTableViewCell"
    }
    
}
