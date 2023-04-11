//
//  DashBoardViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class DashBoardViewModel{
    
    weak var VC:DashBoardViewController?
    var requestAPIs = RestAPI_Requests()
    
    func dashboardAPICall(parameters: JSON, completion: @escaping (DashboardModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.dashboard_API(parameters: parameters) { (result, error) in
            if error == nil {
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
    
    
    
    
    func dashboardImagesAPICall(parameters: JSON, completion: @escaping (DashboardImagesModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.dashboardBanner_API(parameters: parameters) { (result, error) in
            if error == nil {
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
    func userStatus(parameters: JSON, completion: @escaping (UserStatusModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.userIsActive(parameters: parameters) { (result, error) in
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
