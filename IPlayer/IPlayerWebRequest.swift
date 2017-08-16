//
//  IPlayerWebRequest.swift
//  IPlayer
//
//  Created by Shashank Kannam on 8/15/17.
//  Copyright © 2017 Shashank Kannam. All rights reserved.
//

import Foundation

class IPlayerWebRequest {
    
    static let shared = IPlayerWebRequest()
    
    typealias completionHandler = (_ result: IplayerWebRequestedResponse) -> ()
    
    func getDatafromURL(albumsURL: String, completion: @escaping completionHandler) {
        var result = IplayerWebRequestedResponse(dataIn: nil, responseIn: nil, errorIn: nil)
        guard let url = URL(string: albumsURL) else {
            completion(result)
            return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            result = IplayerWebRequestedResponse(dataIn: data, responseIn: response, errorIn: error)
            if error == nil,let dataIn = data {
                result = IplayerWebRequestedResponse(dataIn: dataIn, responseIn: response, errorIn: error)
            } else if error != nil {
                result = IplayerWebRequestedResponse(dataIn: data, responseIn: response, errorIn: error)
            }
            completion(result)
        }
        task.resume()
    }
}

