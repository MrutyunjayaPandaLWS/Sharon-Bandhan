//
//  RedemptionCatalogueVC.swift
//  centuryDemo
//
//  Created by Arkmacbook on 10/03/22.
//

import UIKit
import SDWebImage
import CoreData
import Firebase
class RedemptionCatalogueVC: BaseViewController, AddedToCartOrPlannerDelegate, popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    

    @IBOutlet var redemptionCatalogueHeadingLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var pointsHeadingLabel: UILabel!
    
    @IBOutlet weak var searchProductTF: UITextField!
    @IBOutlet var catalogueCollectionView: UICollectionView!
    @IBOutlet var productTableView: UITableView!
    
    @IBOutlet weak var noDataFound: UILabel!
    
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var VM = RedemptionsCatalogueListViewModel()
    var searchText = ""
    var categoryId = -1
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var productCategoryListArray = [ProductCateogryModels]()
    var selectedCatalogueID = 0
    var totalCartValue = 0
    var selectedPlannerID = 0
    var fromSideMenu = ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noDataFound.isHidden = true
        self.VM.VC = self
        productTableView.delegate = self
        productTableView.dataSource = self
        catalogueCollectionView.delegate = self
        catalogueCollectionView.dataSource = self
        self.pointsLabel.text = pointBalance
        var vc = self.storyboard?.instantiateViewController(withIdentifier: "TaxRelatedPopupViewController") as! TaxRelatedPopupViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        redemptionCategoryList()
      //  redemptionCatalogueList()
        myCartList()
        plannerListing()
        languagelocalization()
        
       
//            guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//            tracker.set(kGAIScreenName, value: "Redemption Catalogue")
//
//            guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//            tracker.send(builder.build() as [NSObject : AnyObject])

    }
 
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.redemptionCatalogueHeadingLabel.text = "rcRedemptionCatalogueKEY".localizableString(loc: "en")
            self.pointsHeadingLabel.text = "Redeemable Points"
            searchProductTF.attributedPlaceholder = NSAttributedString(string: "Search Product Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.redemptionCatalogueHeadingLabel.text = "rcRedemptionCatalogueKEY".localizableString(loc: "hi")
            self.pointsHeadingLabel.text = "रिडीमेंबल पॉइंट्स"
            searchProductTF.attributedPlaceholder = NSAttributedString(string: "उत्पाद का नाम खोजें", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.redemptionCatalogueHeadingLabel.text = "rcRedemptionCatalogueKEY".localizableString(loc: "ta-IN")
            self.pointsHeadingLabel.text = "மீட்டெடுக்கக்கூடிய புள்ளிகள்"
            searchProductTF.attributedPlaceholder = NSAttributedString(string: "தயாரிப்பு பெயரைத் தேடுங்கள்", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        }else{
            self.redemptionCatalogueHeadingLabel.text = "rcRedemptionCatalogueKEY".localizableString(loc: "te")
            self.pointsHeadingLabel.text = "రీడీమ్ చేయగల పాయింట్లు"
            searchProductTF.attributedPlaceholder = NSAttributedString(string: "శోధన ఉత్పత్తి పేరు", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        }
    }
    
    @IBAction func searchProductEditingChanged(_ sender: Any) {
        
        if self.VM.redemptionCatalogueArray.count > 0 {
            let arr = self.VM.redemptionCatalogueArray.filter{ ($0.productName!.localizedCaseInsensitiveContains(self.searchProductTF.text!))}
                   if self.searchProductTF.text! != ""{
                   if arr.count > 0 {
                    self.VM.redemptionCatalogueArray.removeAll(keepingCapacity: true)
                    self.VM.redemptionCatalogueArray = arr
                       self.productTableView.reloadData()
                       productTableView.isHidden = false
                       self.noDataFound.isHidden = true
                   }else {
                    self.VM.redemptionCatalogueArray = self.VM.productsArray
                       self.productTableView.reloadData()
                       productTableView.isHidden = true
                       self.noDataFound.isHidden = false
                   }
               }else{
                self.VM.redemptionCatalogueArray = self.VM.productsArray
                   self.productTableView.reloadData()
                   productTableView.isHidden = false
               }
                   let searchText = self.searchProductTF.text!
               if searchText.count > 0 || self.VM.redemptionCatalogueArray.count == self.VM.productsArray.count {
                       self.productTableView.reloadData()
                   }
               }

    }
    

    @IBAction func cartButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyCart_VC") as! MyCart_VC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //Delegate:-
    

    
    func addToCart(_ cell: Products_TVC) {
      //  self.selectedCatalogueID = -1
        guard let tappedIndex = productTableView.indexPath(for: cell) else{return}
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionCatalogueDetailsVC") as! RedemptionCatalogueDetailsVC
        vc.isComeFrom = "Catalogue"
        vc.productImage = self.VM.redemptionCatalogueArray[tappedIndex.row].productImage ?? ""
        vc.prodRefNo = self.VM.redemptionCatalogueArray[tappedIndex.row].redemptionRefno ?? ""
        vc.productCategory = self.VM.redemptionCatalogueArray[tappedIndex.row].catogoryName ?? ""
        vc.productName = self.VM.redemptionCatalogueArray[tappedIndex.row].productName ?? ""
        vc.productPoints = "\(self.VM.redemptionCatalogueArray[tappedIndex.row].pointsRequired ?? 0)"
        vc.productDetails = self.VM.redemptionCatalogueArray[tappedIndex.row].productDesc ?? ""
        vc.termsandContions = self.VM.redemptionCatalogueArray[tappedIndex.row].termsCondition ?? ""
        vc.selectedCatalogueID = self.VM.redemptionCatalogueArray[tappedIndex.row].catalogueId ?? 0
        vc.catalogueId = self.VM.redemptionCatalogueArray[tappedIndex.row].catalogueId ?? 0
        vc.tdspercentage1 = self.VM.redemptionCatalogueArray[tappedIndex.row].TDSPercentage ?? 0.0
        print(vc.tdspercentage1,"%points")
        vc.applicabletds = self.VM.redemptionCatalogueArray[tappedIndex.row].ApplicableTds ?? 0.0
        vc.isPlanner = self.VM.redemptionCatalogueArray[tappedIndex.row].isPlanner
        print(self.VM.redemptionCatalogueArray[tappedIndex.row].isPlanner!)
        self.navigationController?.pushViewController(vc, animated: true)
//        if cell.addToCartButton.tag == tappedIndex.row{
//            if self.totalCartValue < Int(self.pointBalance) ?? 0 {
//                let calcValue = self.totalCartValue + Int(self.VM.redemptionCatalogueArray[tappedIndex.row].pointsRequired!)
//                if calcValue <= Int(self.pointBalance) ?? 0{
//                    self.selectedCatalogueID = self.VM.redemptionCatalogueArray[tappedIndex.row].catalogueId ?? 0
//                    addToCartApi()
//                }else{
//                    DispatchQueue.main.async{
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                        vc!.delegate = self
//                        vc!.titleInfo = ""
//
//                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                            vc!.descriptionInfo = "Insufficient redeemable balance!"
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                            vc!.descriptionInfo = "अपर्याप्त प्रतिदेय शेष!"
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                            vc!.descriptionInfo = "অপর্যাপ্ত খালাসযোগ্য ব্যালেন্স!"
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                            vc!.descriptionInfo = "తగినంత రీడీమ్ చేయదగిన బ్యాలెన్స్ లేదు!"
//                        }
//                        vc!.modalPresentationStyle = .overCurrentContext
//                        vc!.modalTransitionStyle = .crossDissolve
//                        self.present(vc!, animated: true, completion: nil)
//                    }
//                }
//            }else{
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    vc!.descriptionInfo = "Insufficient redeemable balance!"
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Insufficient redeemable balance!"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                        vc!.descriptionInfo = "अपर्याप्त प्रतिदेय शेष!"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "অপর্যাপ্ত খালাসযোগ্য ব্যালেন্স!"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "తగినంత రీడీమ్ చేయదగిన బ్యాలెన్స్ లేదు!"
//                    }
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                }
//            }
//            self.productTableView.reloadData()
//        }
    }
    
    func addToPlanner(_ cell: Products_TVC) {
        guard let tappedIndex = productTableView.indexPath(for: cell) else{return}
            self.selectedPlannerID = self.VM.redemptionCatalogueArray[tappedIndex.row].catalogueId ?? 0
            self.addedToPlanner()
            self.productTableView.reloadData()
    }
    
    //Api:-
    
    func redemptionCategoryList(){
        self.VM.redemptionCategoryArray.removeAll()
        self.productCategoryListArray.removeAll()
        let parameters = [
                "ObjCatalogueRetriveRequest": [
                    "ActionType": "1",
                    "ActorId": "\(userID)",
                    "IsActive": 1
                ]
        ] as [String: Any]
        print(parameters)
        
        self.VM.redemptionCateogry(parameters: parameters) { respone in
            self.VM.redemptionCategoryArray = respone?.getCatalogueCategoryDetailsResult?.objCatalogueCategoryListJson ?? []
            DispatchQueue.main.async {
                    self.catalogueCollectionView.isHidden = false
                    self.productCategoryListArray.append((ProductCateogryModels(productCategoryId: "-1", productCategorName: "All", isSelected: 0)))
                        for item in self.VM.redemptionCategoryArray{
                            self.productCategoryListArray.append(ProductCateogryModels(productCategoryId: "\(item.catogoryId ?? 0)", productCategorName: item.catogoryName ?? "", isSelected: 0))
                        }
                    self.redemptionCatalogueList()
                
                self.catalogueCollectionView.reloadData()
                self.productTableView.reloadData()
                self.stopLoading()
                

            }
            
        }
    }
    
    func redemptionCatalogueList(){
        self.VM.redemptionCatalogueArray.removeAll()
        let parameters = [
                "ActionType": "6",
                "ActorId": "\(userID)",
                "ObjCatalogueDetails": [
                    "MerchantId": 1,
                    "CatogoryId": categoryId
                ],
                "SearchText": "\(searchProductTF.text ?? "")"
        ] as [String: Any]
        print(parameters)
        
        self.VM.redemptionCatalogue(parameters: parameters) { respone in
            self.VM.redemptionCatalogueArray = respone?.objCatalogueList ?? []
            self.VM.productsArray = self.VM.redemptionCatalogueArray
            print(self.VM.redemptionCatalogueArray.count, "Redemption Catalouge Array Count")
            if self.VM.redemptionCatalogueArray.count != 0{
                DispatchQueue.main.async {
                    self.productTableView.isHidden = false
                    self.noDataFound.isHidden = true
                    self.productTableView.reloadData()
                    self.stopLoading()
                }
            }else{
                DispatchQueue.main.async {
                    self.noDataFound.isHidden = false
                    self.productTableView.isHidden = true
                    self.stopLoading()
                    
                }
            }
            
        }
    }
    
    func addToCartApi(){
        let parameters = [
            "ActionType": "1",
              "ActorId": "\(userID)",
              "CatalogueSaveCartDetailListRequest": [
                  [
                      "CatalogueId": "\(selectedCatalogueID)",
                      "DeliveryType": "1",
                      "NoOfQuantity": "1"
                  ]
              ],
              "LoyaltyID": "\(loyaltyId)",
              "MerchantId": "1"
        ] as [String: Any]
        print(parameters)
        self.VM.addToCart(parameters: parameters) { response in
            if response?.returnValue == 1{
                DispatchQueue.main.async{
                    self.myCartList()
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Product has been added to Cart"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "उत्पाद कार्ट में जोड़ दिया गया है"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "পণ্য কার্টে যোগ করা হয়েছে"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "ఉత్పత్తి కార్ట్‌కి జోడించబడింది"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Something went wrong!"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "कुछ गलत हो गया!"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "কিছু ভুল হয়েছে!"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "ఎక్కడో తేడ జరిగింది!"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
            DispatchQueue.main.async {
                self.stopLoading()
            }
            
        }
        
    }
    
    func myCartList(){
        self.VM.myCartListArray.removeAll()
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": "\(loyaltyId)"
        ] as [String: Any]
        print(parameters)
        self.VM.myCartList(parameters: parameters) { response in
            self.VM.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
            self.countLabel.text = "\(self.VM.myCartListArray.count)"
            DispatchQueue.main.async {
                for data in self.VM.myCartListArray{
                    self.totalCartValue = data.sumOfTotalPointsRequired ?? 0
                    
                }
                self.productTableView.reloadData()
                self.stopLoading()
            }
        }
    }
    
    func addedToPlanner(){
        let parameters = [
                "ActionType": 0,
                "ActorId": "\(userID)",
                "ObjCatalogueDetails": [
                    "CatalogueId": "\(selectedPlannerID)"
                ]
        ] as [String: Any]
        print(parameters,"addToPlanner")
        self.VM.addToPlanners(parameters: parameters) { response in
            
            if response?.returnValue ?? 0 >= 1{
                self.redemptionCategoryList()
             //   self.redemptionCatalogueList()
                self.plannerListing()
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                   
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Product has been added to Planner List"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "उत्पाद को योजनाकार सूची में जोड़ा गया है"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "পণ্য পরিকল্পনাকারী তালিকা যোগ করা হয়েছে"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "ఉత్పత్తి ప్లానర్ జాబితాకు జోడించబడింది"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                   
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Something went wrong!"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "कुछ गलत हो गया!"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "কিছু ভুল হয়েছে!"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "ఎక్కడో తేడ జరిగింది!"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
            DispatchQueue.main.async {
                self.stopLoading()
            }
        }
    }
    
    func plannerListing(){
        self.VM.myPlannerListArray.removeAll()
        let parameters = [
            "ActionType": "6",
            "ActorId": "\(userID)"
        ] as [String : Any]
        print(parameters)
        self.VM.plannerListingApi(parameters: parameters) { response in
            self.VM.myPlannerListArray = response?.objCatalogueList ?? []
            
            DispatchQueue.main.async {
                self.stopLoading()
            }
        }
        
    }
    
}



extension RedemptionCatalogueVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.redemptionCatalogueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Products_TVC", for: indexPath) as! Products_TVC
        cell.delegate = self
        print(self.VM.redemptionCatalogueArray[indexPath.row].TDSPercentage ?? 0.0,"TDS")
        print(self.VM.redemptionCatalogueArray[indexPath.row].ApplicableTds ?? 0.0,"Applicable")
        cell.productNameLabel.text = self.VM.redemptionCatalogueArray[indexPath.row].productName ?? ""
        cell.categoryTypeLabel.text = self.VM.redemptionCatalogueArray[indexPath.row].catogoryName ?? ""
        cell.pointsLabel.text = "\(self.VM.redemptionCatalogueArray[indexPath.row].pointsRequired ?? 0)"
        let receivedImage = self.VM.redemptionCatalogueArray[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell.productImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        cell.addToPlanner.tag = indexPath.row
        cell.addToCartButton.tag = indexPath.row
        let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == self.VM.redemptionCatalogueArray[indexPath.row].catalogueId ?? 0 }
        let filterPlannerList = self.VM.myPlannerListArray.filter { $0.catalogueId == self.VM.redemptionCatalogueArray[indexPath.row].catalogueId ?? 0 }
        let productPoints = self.VM.redemptionCatalogueArray[indexPath.row].pointsRequired ?? 0
        if Int(self.pointBalance) ?? 0 >= productPoints{
            cell.addedToCart.isHidden = true
            cell.addToPlanner.isHidden = true
            cell.addToCartButton.isHidden = false
            cell.addedToPlanner.isHidden = true
        }else{
            if self.VM.redemptionCatalogueArray[indexPath.row].isPlanner! == true{
                cell.addedToCart.isHidden = true
                cell.addToPlanner.isHidden = false
                cell.addToCartButton.isHidden = true
                cell.addedToPlanner.isHidden = true
            }else{
                cell.addedToCart.isHidden = true
                cell.addToPlanner.isHidden = true
                cell.addToCartButton.isHidden = true
                cell.addedToPlanner.isHidden = true
            }
        }
//        if filterCategory.count > 0 {
//            cell.addedToCart.isHidden = false
//            cell.addToPlanner.isHidden = true
//            cell.addToCartButton.isHidden = true
//            cell.addedToPlanner.isHidden = true
//        }
        if filterPlannerList.count > 0 {
            if Int(pointBalance) ?? 0 > Int(productPoints) {
                cell.addedToCart.isHidden = true
                cell.addToPlanner.isHidden = true
                cell.addToCartButton.isHidden = false
                cell.addedToPlanner.isHidden = true
            }else{
                cell.addedToCart.isHidden = true
                cell.addToPlanner.isHidden = true
                cell.addToCartButton.isHidden = true
                cell.addedToPlanner.isHidden = false
                
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionCatalogueDetailsVC") as! RedemptionCatalogueDetailsVC
        vc.isComeFrom = "Catalogue"
        vc.productImage = self.VM.redemptionCatalogueArray[indexPath.row].productImage ?? ""
        vc.prodRefNo = self.VM.redemptionCatalogueArray[indexPath.row].redemptionRefno ?? ""
        vc.productCategory = self.VM.redemptionCatalogueArray[indexPath.row].catogoryName ?? ""
        vc.productName = self.VM.redemptionCatalogueArray[indexPath.row].productName ?? ""
        vc.productPoints = "\(self.VM.redemptionCatalogueArray[indexPath.row].pointsRequired ?? 0)"
        vc.productDetails = self.VM.redemptionCatalogueArray[indexPath.row].productDesc ?? ""
        vc.termsandContions = self.VM.redemptionCatalogueArray[indexPath.row].termsCondition ?? ""
        vc.selectedCatalogueID = self.VM.redemptionCatalogueArray[indexPath.row].catalogueId ?? 0
        vc.catalogueId = self.VM.redemptionCatalogueArray[indexPath.row].catalogueId ?? 0
        vc.tdspercentage1 = self.VM.redemptionCatalogueArray[indexPath.row].TDSPercentage ?? 0.0
        vc.applicabletds = self.VM.redemptionCatalogueArray[indexPath.row].ApplicableTds ?? 0.0
        vc.isPlanner = self.VM.redemptionCatalogueArray[indexPath.row].isPlanner
        print(self.VM.redemptionCatalogueArray[indexPath.row].isPlanner!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension RedemptionCatalogueVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productCategoryListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Catalogue_CVC", for: indexPath) as! Catalogue_CVC
        cell.catalogurLabel.text = "\(self.productCategoryListArray[indexPath.row].productCategorName ?? "")    "
            if self.categoryId == Int(self.productCategoryListArray[indexPath.item].productCategoryId!) ?? -1{
                cell.catalogurLabel.textColor = UIColor.white
                cell.catalogurLabel.backgroundColor = #colorLiteral(red: 0.007268199697, green: 0.4740364552, blue: 0.2290205359, alpha: 1)
            }else{
                cell.catalogurLabel.textColor = UIColor.darkGray
                cell.catalogurLabel.backgroundColor = #colorLiteral(red: 0.8392156959, green: 0.8392156959, blue: 0.8392156959, alpha: 1)
            }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.categoryId = Int(self.productCategoryListArray[indexPath.item].productCategoryId!) ?? -1
            self.productCategoryListArray[indexPath.item].isSelected = 1
           // self.redemptionCatalogueList()
            self.redemptionCategoryList()
    }

}
