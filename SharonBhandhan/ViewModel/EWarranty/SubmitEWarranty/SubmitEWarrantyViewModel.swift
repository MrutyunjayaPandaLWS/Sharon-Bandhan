//
//  SubmitEWarrantyViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class SubmitEWarrantyViewModel{

    weak var VC: SubmitEWarrantyViewController?
    var requestAPIs = RestAPI_Requests()
    func e_warrantyListAPi(parameters: JSON, completion: @escaping (E_WarrantyListingModel?) -> ()){
        self.VC?.startLoading()
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

   
        func generateWarrantyDetails(parameters: JSON, completion: @escaping (SaveEWarrantyDetails?) -> ()){
            self.VC?.startLoading()
            self.requestAPIs.saveEwarrantyDetails(parameters: parameters) { (result, error) in
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
    
    func downloadEwarranty(parameters: JSON, completion: @escaping (DownloadEWarranty?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.downloadEwarranty(parameters: parameters) { (result, error) in
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
