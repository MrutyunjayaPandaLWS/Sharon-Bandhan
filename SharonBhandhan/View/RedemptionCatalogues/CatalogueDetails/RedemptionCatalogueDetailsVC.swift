//
//  RedemptionCatalogueDetailsVC.swift
//  centuryDemo
//
//  Created by Arkmacbook on 10/03/22.
//

import UIKit
import SDWebImage
import Firebase
class RedemptionCatalogueDetailsVC: BaseViewController, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
    }
    
    

    @IBOutlet weak var tdsvalue: UILabel!
    @IBOutlet weak var tdspercentage: UILabel!
    @IBOutlet var redemptionDetailsHeadingLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var redBackgroundView: UIView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var categoryTypeLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var pointsHeadingLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var termsAndCondtionsLabel: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var qtyValue: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var productRefNo: UILabel!
    @IBOutlet weak var addToCart: GradientButton!
    @IBOutlet weak var addToPlanner: GradientButton!
    @IBOutlet weak var addedToPlannerBTN: GradientButton!
    @IBOutlet weak var addedToCart: GradientButton!
    @IBOutlet weak var addBTNStackView: UIStackView!
    @IBOutlet weak var descriptions: UILabel!
    @IBOutlet weak var termsandConditions: UILabel!
    
    @IBOutlet weak var tdsPts: UILabel!
    
    @IBOutlet weak var tdsApplicable: UILabel!
    var productImage = ""
    var prodRefNo = ""
    var productCategory = ""
    var productName = ""
    var productPoints = ""
    var tdspercentage1 = 0.0
    var applicabletds = 0.0
    var productDetails = ""
    var termsandContions = ""
    var quantity = 0
    var categoryId = 0
    var catalogueId = 0
    var isComeFrom = ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var totalCartValue = 0
    var isPlanner: Bool?
    
    var VM = CatalogueDetailsViewModel()
    var selectedCatalogueID = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        categoryTypeLabel.text = productCategory
        productRefNo.text = prodRefNo
        tdsvalue.text = "\(Int(applicabletds))"
        tdspercentage.text = "\(tdspercentage1)%"
        productNameLabel.text = productName
        pointsLabel.text = productPoints
        qtyValue.text = "\(quantity)"
        descriptionLabel.text = productDetails
        termsAndCondtionsLabel.text = termsandContions
        let receivedImage = productImage
        print(receivedImage)
        let totalImgURL = productCatalogueImgURL + receivedImage
        productImageView.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
//        if (Int(productPoints)! + Int(self.applicabletds)) >= Int(pointBalance)!{
//            self.addToCart.isHidden = false
//            self.addToPlanner.isHidden = true
//        }else{
//            self.addToPlanner.isHidden = false
//            self.addToCart.isHidden = true
//        }
//
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if isComeFrom == "MyRedemption"{
            cartButton.isHidden = true
            countLabel.isHidden = true
            addBTNStackView.isHidden = true
            quantityLbl.isHidden = false
            qtyValue.isHidden = false
        }else{
            quantityLbl.isHidden = true
            qtyValue.isHidden = true
            self.myCartList()
            }
        languagelocalization()
        languagelocalization1()
        
        
//            guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//            tracker.set(kGAIScreenName, value: "Redemption Catalogue Details")
//
//            guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//            tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.redemptionDetailsHeadingLabel.text = "Redemption Details"
            self.pointsHeadingLabel.text = "Points"
            self.descriptions.text = "Descriptions"
            self.termsandConditions.text = "Terms and Conditions"
            self.quantityLbl.text = "Quantity"
            self.tdsPts.text = "TDS points"
            self.tdsApplicable.text = "TDS applicable @"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.redemptionDetailsHeadingLabel.text = "मोचन विवरण"
            self.pointsHeadingLabel.text = "अंक"
            self.descriptions.text = "विवरण"
            self.termsandConditions.text = "नियम और शर्तें"
            self.quantityLbl.text = "मात्रा"
            self.tdsPts.text = "टीडीएस अंक"
            self.tdsApplicable.text = "टीडीएस लागू @"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.redemptionDetailsHeadingLabel.text = "রিডেম্পশন বিশদ"
            self.pointsHeadingLabel.text = "পয়েন্ট"
            self.descriptions.text = "বর্ণনা"
            self.termsandConditions.text = "নিয়ম ও শর্তাবলী"
            self.quantityLbl.text = "পরিমাণ"
            self.tdsPts.text = "টিডিএস পয়েন্ট"
            self.tdsApplicable.text = "টিডিএস প্রযোজ্য @"
        }else{
            self.redemptionDetailsHeadingLabel.text = "విముక్తి వివరాలు"
            self.pointsHeadingLabel.text = "పాయింట్లు"
            self.descriptions.text = "వివరణలు"
            self.termsandConditions.text = "నిబంధనలు మరియు షరతులు"
            self.quantityLbl.text = "పరిమాణం"
            self.tdsPts.text = "TDS పాయింట్లు"
            self.tdsApplicable.text = "TDS వర్తిస్తుంది @"
        }
    }
   
    func languagelocalization1(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.addToCart.setTitle("rcAddToCartKEY".localizableString(loc: "en"), for: .normal)
            self.addedToCart.setTitle("rcAddedToCartKEY".localizableString(loc: "en"), for: .normal)
            self.addToPlanner.setTitle("Add To Planner", for: .normal)
            self.addedToPlannerBTN.setTitle("Added To Planner", for: .normal)
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.addToCart.setTitle("rcAddToCartKEY".localizableString(loc: "hi"), for: .normal)
            self.addedToCart.setTitle("rcAddedToCartKEY".localizableString(loc: "hi"), for: .normal)
            self.addToPlanner.setTitle("प्लानर में जोड़ें", for: .normal)
            self.addedToPlannerBTN.setTitle("नियोजक में जोड़ा गया", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.addToCart.setTitle("rcAddToCartKEY".localizableString(loc: "ta-IN"), for: .normal)
            self.addedToCart.setTitle("rcAddedToCartKEY".localizableString(loc: "ta-IN"), for: .normal)
            self.addToPlanner.setTitle("திட்டமிடுபவருக்குச் சேர்க்கவும்", for: .normal)
            self.addedToPlannerBTN.setTitle("பிளானரில் சேர்க்கப்பட்டது", for: .normal)
            
        }else{
            self.addToCart.setTitle("rcAddToCartKEY".localizableString(loc: "te"), for: .normal)
            self.addedToCart.setTitle("rcAddedToCartKEY".localizableString(loc: "te"), for: .normal)
            self.addToPlanner.setTitle("ప్లానర్‌కి జోడించు", for: .normal)
            self.addedToPlannerBTN.setTitle("ప్లానర్‌కి చేర్చబడింది", for: .normal)
        }
    }
    
            
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cartButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyCart_VC") as! MyCart_VC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func addeToCartButton(_ sender: Any) {
        
        if self.verifiedStatus == 6 || self.verifiedStatus == 4{
            if self.checkAccountStatus == "1"{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }else{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }
            
        }else{
//            if self.totalCartValue <= Int(pointBalance)!{
//                let calcValues = self.totalCartValue + Int(self.productPoints)!
//                print(calcValues)
            if Int(productPoints) ?? 0 <= Int(pointBalance)!{
                    addToCartApi()
                }else{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            vc!.descriptionInfo = "Insufficent Point Balance"
                         }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                             vc!.descriptionInfo = "अपर्याप्त अंक संतुलन"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            vc!.descriptionInfo = "অপর্যাপ্ত পয়েন্ট ব্যালেন্স"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                            vc!.descriptionInfo = "సరిపోని పాయింట్లు బ్యాలెన్స్"
                          }
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
            //    }
                
            }
        }
    }
    
    @IBAction func addedToPlanner(_ sender: Any) {

//        if self.verifiedStatus == 6 || self.verifiedStatus == 4{
//            if self.checkAccountStatus == "1"{
//                NotificationCenter.default.post(name: .verificationStatus, object: nil)
//            }else{
//                NotificationCenter.default.post(name: .verificationStatus, object: nil)
//            }
//
//        }else{
            addedToPlanner()
       // }
    }
    
    //Api:-
    
    func myCartList(){
        let parameters = [
            "ActionType": "2",
            "LoyaltyID": "\(loyaltyId)"
        ] as [String: Any]
        print(parameters)
        self.VM.myCartList(parameters: parameters) { response in
            self.VM.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
            print(self.VM.myCartListArray.count)
            self.countLabel.text = "\(self.VM.myCartListArray.count)"
            DispatchQueue.main.async {
                
                if self.VM.myCartListArray.count != 0{
                    for data in self.VM.myCartListArray{
                        self.totalCartValue = data.sumOfTotalPointsRequired ?? 0
                        print(self.totalCartValue, "TotalValue")
                        let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == self.catalogueId}
                        print(filterCategory.count)
                        if filterCategory.count > 0 {
                            self.addedToCart.isHidden = false
                            self.addToPlanner.isHidden = true
                            self.addToCart.isHidden = true
                            self.addedToPlannerBTN.isHidden = true
                        }else{
                            print(Int(self.productPoints)!, "Value1")
                            print(Int(self.pointBalance)!, "Value 2")
                            
                            print("\(self.applicabletds)", "Value 3")
                            
                           // if (Int(self.productPoints)! + Int(self.applicabletds)) < Int(self.pointBalance)!{
                            if Int(self.productPoints) ?? 0 <= Int(self.pointBalance) ?? 0 {
                            self.addedToCart.isHidden = true
                                self.addToPlanner.isHidden = true
                                self.addToCart.isHidden = false
                                self.addedToPlannerBTN.isHidden = true
                            }else{
                                self.addedToCart.isHidden = true
                                self.addToPlanner.isHidden = false
                                self.addToCart.isHidden = true
                                self.addedToPlannerBTN.isHidden = true
                                
                                self.plannerListing()
                            }
                        }
                    }
                }else{
                    print(self.productPoints)
                    print(self.pointBalance, "asdfashjdfasdfasdf")
                    //if (Int(self.productPoints)! + Int(self.applicabletds)) < Int(self.pointBalance)!{
                    if Int(self.productPoints) ?? 0 <= Int(self.pointBalance) ?? 0 {
                        self.addedToCart.isHidden = true
                        self.addToPlanner.isHidden = true
                        self.addToCart.isHidden = false
                        self.addedToPlannerBTN.isHidden = true
                    }else{
                        self.addedToCart.isHidden = true
                        self.addToPlanner.isHidden = false
                        self.addToCart.isHidden = true
                        self.addedToPlannerBTN.isHidden = true
                        self.plannerListing()
                    }
                }

                self.stopLoading()
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
            
            print(response?.returnValue ?? 0, "Add To Cart")
            
            if response?.returnValue == 1{
                self.myCartList()
                DispatchQueue.main.async{
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
    
    func plannerListing(){
        let parameters = [
            "ActionType": "6",
            "ActorId": "\(userID)"
        ] as [String : Any]
        print(parameters)
        self.VM.plannerListingApi(parameters: parameters) { response in
            self.VM.myPlannerListArray = response?.objCatalogueList ?? []
            print(self.VM.myPlannerListArray.count)
            DispatchQueue.main.async {
                let filterCategory = self.VM.myPlannerListArray.filter { $0.catalogueId == self.catalogueId}
                print(filterCategory.count)
                if filterCategory.count > 0 {
                    self.addedToCart.isHidden = true
                    self.addToPlanner.isHidden = true
                    self.addToCart.isHidden = true
                    self.addedToPlannerBTN.isHidden = false
                    self.stopLoading()
                }else{
                    print(self.isPlanner, "IspLannser")
                    if self.isPlanner == true{
                        self.addedToCart.isHidden = true
                        self.addToPlanner.isHidden = false
                        self.addToCart.isHidden = true
                        self.addedToPlannerBTN.isHidden = true
                    }else{
                        self.addBTNStackView.isHidden = true
                       
                    }
                   
                    self.stopLoading()
            }
        }
         
        }
    }
  
    
    func addedToPlanner(){
        let parameters = [
                "ActionType": 0,
                "ActorId": "\(userID)",
                "ObjCatalogueDetails": [
                    "CatalogueId": "\(selectedCatalogueID)"
                ]
        ] as [String: Any]
        print(parameters)
        self.VM.addToPlanners(parameters: parameters) { response in
            print(response?.returnValue ?? 0, "Added To Planner")
            if response?.returnValue ?? 0 >= 1{
                self.plannerListing()
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Product has been added into Planner List"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "उत्पाद को योजनाकार सूची में जोड़ा गया है"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "পণ্য পরিকল্পনাকারী তালিকায় যোগ করা হয়েছে"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "ఉత్పత్తి ప్లానర్ జాబితాలోకి జోడించబడింది"
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
    
}
