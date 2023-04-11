//
//  ForgotPasswordViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class ForgotPasswordViewModel{
    
    weak var VC:ForgotPasswordViewController?
    var requestAPIs = RestAPI_Requests()
    
    
    func forgotPasswordAPI(parameters: JSON, completion: @escaping (ForgotPasswordModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.forgotPassword_API(parameters: parameters) { (result, error) in
            if error == nil {
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
    
    func membershipIDVerification(parameters: JSON, completion: @escaping (MemberVerificationModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.membershipIDVerification_API(parameters: parameters) { (result, error) in
            if error == nil {
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
