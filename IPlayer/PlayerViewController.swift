//
//  PlayerViewController.swift
//  IPlayer
//
//  Created by Shashank Kannam on 8/15/17.
//  Copyright © 2017 Shashank Kannam. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var trackNameLbl: UILabel!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var collectionLbl: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var previewBtn: UIButton!
    
    var album: Album!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    private func fetchData() {
        downloadImage(url: album.artworkUrl60)
        trackNameLbl.text = album?.trackName
        artistNameLbl.text = album?.artistName
        collectionLbl.text = album?.collectionName
    }

    
    private func downloadImage(url: String) {
        artworkImageView.image = nil
        DispatchQueue.global(qos: .userInitiated).async {
            ImageDownloader.getImageFromURL(imgUrl: url) { [weak self] (img, error) in
                DispatchQueue.main.async {
                    self?.artworkImageView.image = img
                }
            }
        }
    }
}
