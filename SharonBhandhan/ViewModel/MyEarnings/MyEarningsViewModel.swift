//
//  MyEarningsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class MyEarningsViewModel{

    weak var VC:MyEarningsViewController?
    var requestAPIs = RestAPI_Requests()
    var myEarningListArray = [LstRewardTransJsonDetails]()
    
    func myEarningListAPi(parameters: JSON, completion: @escaping (MyEarningModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.myEarningListApi(parameters: parameters) { (result, error) in
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
