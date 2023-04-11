//
//  LodgeListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class LodgeListViewModel{
 
    weak var VC: CustomerQueryListingViewController?
    var requestAPIs = RestAPI_Requests()
    var queryListingArray = [ObjCustomerAllQueryJsonList]()
    
    
    func queryListingApi(parameters: JSON, completion: @escaping (QueryListingModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.queryListingApi(parameters: parameters) { (result, error) in
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
