//
//  IplayerWebRequestedResponse.swift
//  IPlayer
//
//  Created by Shashank Kannam on 8/15/17.
//  Copyright © 2017 Shashank Kannam. All rights reserved.
//

import Foundation

class IplayerWebRequestedResponse {
    
    let data: Data?
    let response: URLResponse?
    let error: Error?
    
    init(dataIn: Data?, responseIn: URLResponse?, errorIn: Error?) {
        self.data = dataIn
        self.response = responseIn
        self.error = errorIn
    }
}
