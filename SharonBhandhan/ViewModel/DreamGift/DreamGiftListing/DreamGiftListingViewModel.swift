//
//  DreamGiftListingViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//


import UIKit

class DreamGiftListingViewModel{

    weak var VC: DreamGiftListingViewController?
    var requestAPIs = RestAPI_Requests()
    var myDreamGiftListArray = [LstDreamGift]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse1]()
    
    func myDreamGiftLists(parameters: JSON, completion: @escaping (MyDreamGiftModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.myDreamGiftList(parameters: parameters) { (result, error) in
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
    
    func removeDreamGift(parameters: JSON, completion: @escaping (RemoveGiftModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.removeDreamGifts(parameters: parameters) { (result, error) in
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
    func addToCart(parameters: JSON, completion: @escaping (AddToCartModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.addToCartApi(parameters: parameters) { (result, error) in
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
    
    func myCartList(parameters: JSON, completion: @escaping (MyCartModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.myCartList(parameters: parameters) { (result, error) in
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
