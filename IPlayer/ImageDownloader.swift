//
//  ImageDownloader.swift
//  IPlayer
//
//  Created by Shashank Kannam on 8/16/17.
//  Copyright © 2017 Shashank Kannam. All rights reserved.
//

import UIKit

class ImageDownloader {
    
    typealias completionHandler = (_ result: UIImage?, _ error: Error?) -> ()
    
    class func getImageFromURL(imgUrl: String, completion: @escaping completionHandler) {
        guard let url = URL(string: imgUrl) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        let img = UIImage(data: data)
        if let albumImg = img {
            completion(albumImg, nil)
        }
    }
}
