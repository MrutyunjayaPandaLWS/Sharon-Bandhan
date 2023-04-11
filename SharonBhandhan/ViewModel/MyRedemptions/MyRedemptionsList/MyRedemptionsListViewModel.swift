//
//  MyRedemptionsListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class MyRedemptionsListViewModel{
    
    weak var VC:MyRedemptionsListViewController?
    var requestAPIs = RestAPI_Requests()
    var myRedemptionList = [ObjCatalogueRedemReqList]()

    
    func myRedemptionLists(parameters: JSON, completion: @escaping (MyRedemptionModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.redemptionListing_Post_API(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
                        self.VC?.stopLoading()
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
