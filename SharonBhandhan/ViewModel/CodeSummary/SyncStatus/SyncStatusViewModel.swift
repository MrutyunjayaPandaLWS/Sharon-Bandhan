//
//  SyncStatusViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class SyncStatusViewModel{
    weak var VC:CodeStatusListVC?
    var requestAPIs = RestAPI_Requests()
    var syncCodeArray = [QrUsegereport]()
    
    func syncStatusListingAPI(parameters: JSON, completion: @escaping (SyncStatusModel?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.syncStatusListing(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }
                
            }
        }
    }


}
