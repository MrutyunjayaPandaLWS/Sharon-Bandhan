//
//  RedemptionsCatalogueListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit

class RedemptionsCatalogueListViewModel{
    
    weak var VC: RedemptionCatalogueVC?
    var requestAPIs = RestAPI_Requests()
    var redemptionCategoryArray = [ObjCatalogueCategoryListJson]()
    var redemptionCatalogueArray = [ObjCatalogueList]()
    var productsArray = [ObjCatalogueList]()
    var myCartListArray = [CatalogueSaveCartDetailListResponse1]()
    var myPlannerListArray = [ObjCatalogueList2]()
    
    func redemptionCateogry(parameters: JSON, completion: @escaping (RedemptionCategoryModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.redemptionCateogryListing(parameters: parameters) { (result, error) in
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
    
    func redemptionCatalogue(parameters: JSON, completion: @escaping (RedemptionCatalogueModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.redemptionCatalogueListing(parameters: parameters) { (result, error) in
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
    
    func addToPlanners(parameters: JSON, completion: @escaping (AddToPlannerModel?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.addToPlannerApi(parameters: parameters) { (result, error) in
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
    
    func plannerListingApi(parameters: JSON, completion: @escaping (PlannerListModels?) -> ()){
        self.VC?.startLoading()
        self.requestAPIs.plannerListApi(parameters: parameters) { (result, error) in
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
class ProductCateogryModels : NSObject{
    var productCategoryId:String!
    var productCategorName:String!
    var isSelected: Int!
    init(productCategoryId: String, productCategorName: String, isSelected: Int!){
        self.productCategoryId = productCategoryId
        self.productCategorName = productCategorName
        self.isSelected = isSelected
    }
}
