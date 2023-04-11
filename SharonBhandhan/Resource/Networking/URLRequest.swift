//
//  URLRequest.swift
//  TestApp
//
//  Created by Arokia IT on 8/6/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit


extension URLRequest {
    init(baseUrl: String, path: String, method: RequestMethod, params: JSON) {
        //BASIC AUTH
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8.rawValue)!
        let base64LoginString = loginData.base64EncodedString()
        
        //URL part
        let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
        self.init(url: url)
        httpMethod = method.rawValue
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        setValue("Basic " + base64LoginString, forHTTPHeaderField: "Authorization")
        switch method {
        case .post, .put:
            httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            break
        default:
            break
        }
    }
}

