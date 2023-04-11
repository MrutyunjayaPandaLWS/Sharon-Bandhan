//
//  SelectProductEWarrantyListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class SelectProductEWarrantyListViewModel{
    weak var VC: SelectProductEWarrantyListViewController?
    var requestAPIs = RestAPI_Requests()
    
    func addE_warrantyListAPi(parameters: JSON, completion: @escaping (E_WarrantyListingModel?) -> ()){
        DispatchQueue.main.async {
            self.VC?.startLoading()
            self.VC?.addE_warrantyListArray.removeAll()
        }
        
        
        self.requestAPIs.E_WarrantyListing(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        completion(result)
//                        self.VC?.stopLoading()
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
