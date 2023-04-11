//
//  SideMenuViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class SideMenuViewModel{
    
    weak var VC:SideMenuViewController?
    var requestAPIs = RestAPI_Requests()
    var menuListArray = [MenuMaster]()
    
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
    
    func menuList(parameters: JSON, completion: @escaping (MenuModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.menuListApi(parameters: parameters) { (result, error) in
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
    
    //deleteAccountApi
    
    func deleteAccount(parameters: JSON, completion: @escaping (DeleteAccountModels?) -> ()) {
        self.VC?.startLoading()
        self.requestAPIs.deleteAccountApi(parameters: parameters) { (result, error) in
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
