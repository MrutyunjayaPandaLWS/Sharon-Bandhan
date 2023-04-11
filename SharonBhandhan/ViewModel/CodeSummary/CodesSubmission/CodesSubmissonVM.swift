//
//  CodesSubmissonVM.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 28/04/2022.
//

import Foundation

class CodesSubmissonVM {
    weak var VC: ScannedCodes_VC?
    var requestAPIs = RestAPI_Requests()

    func submitCodesApi(parameters: JSON, completion: @escaping (ScannedandUploadCodesModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.submitCodesApi(parameters: parameters) { (result, error) in
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

