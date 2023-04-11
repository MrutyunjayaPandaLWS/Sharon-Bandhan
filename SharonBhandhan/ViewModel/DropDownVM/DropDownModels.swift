//
//  DropDownModels.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 19/04/2022.
//

import UIKit

class DropDownModels{
    
    weak var VC: DropDownVC?
    var requestAPIs = RestAPI_Requests()
    var stateArray = [StateList]()
    var cityArray = [CityList]()
    var areaArray = [AreaList]()
    
    
    func stateList(parameters: JSON, completion: @escaping (StateListModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.stateList(parameters: parameters) { (result, error) in
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
    func cityList(parameters: JSON, completion: @escaping (CityListModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.cityList(parameters: parameters) { (result, error) in
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
    
    
    func areaList(parameters: JSON, completion: @escaping (AreaListModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.areaListApi(parameters: parameters) { (result, error) in
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
