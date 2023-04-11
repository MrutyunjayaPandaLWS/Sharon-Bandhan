//
//  CreateNewQueryViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class CreateNewQueryViewModel{
       weak var VC: CreateNewQueryViewController?
       var requestAPIs = RestAPI_Requests()
       
       
       
       func helpTopicList(parameters: JSON, completion: @escaping (HelpTopicModel?) -> ()){
           self.VC?.startLoading()
           self.requestAPIs.helpTopicListingApi(parameters: parameters) { (result, error) in
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
    
    func newQuerySubmission(parameters: JSON, completion: @escaping (NewQuerySubmission?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.newQuerySubmissionApi(parameters: parameters) { (result, error) in
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
