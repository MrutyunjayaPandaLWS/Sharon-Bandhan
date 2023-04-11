//
//  RedemptionPlannerDetails_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 14/03/22.
//

import UIKit
import SDWebImage
import Firebase
import Toast_Swift
class RedemptionPlannerDetails_VC: BaseViewController, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    @IBOutlet weak var tdsPts: UILabel!
    
    @IBOutlet weak var tdsApplicable: UILabel!
    @IBOutlet weak var tdsvalue: UILabel!
    @IBOutlet weak var tdsprice: UILabel!
    @IBOutlet var redemptionPlannerTitleLabel: UILabel!
    @IBOutlet var congratulationsImageView: UIImageView!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var pointHeading: UILabel!
    @IBOutlet var points: UILabel!
    @IBOutlet var redeemButton: GradientButton!
    @IBOutlet var removeButton: UIButton!
    @IBOutlet var redemptionPlannerSummaryHEadingLabel: UILabel!
    @IBOutlet var todayRedemablePoinsHEading: UILabel!
    @IBOutlet var todayPointsHeading: UILabel!
    @IBOutlet var todayPoints: UILabel!
    @IBOutlet var avgEarningsLabel: UILabel!
    @IBOutlet var monthlyPointsLabel: UILabel!
    @IBOutlet var monthlyHeadingLabel: UILabel!
    @IBOutlet var giftLabel: UILabel!
    @IBOutlet weak var congratulationHeight: NSLayoutConstraint!
    @IBOutlet weak var infoLblHeight: NSLayoutConstraint!
    @IBOutlet weak var infoDetailsLbl: UILabel!
    @IBOutlet var percentageHeight: NSLayoutConstraint!
    
    var productImage = ""
    var productName = ""
    var quantity = ""
    var redemptionRefNo = ""
    var descDetails = ""
    var termsandContions = ""
    var redemptionPoints = ""
    var status = ""
    var redemptionsDate = ""
    var redemptionId = ""
    var totalPoint = ""
    var cartCounts = ""
    var productPoints = 0
    var selectedCatalogueID = 0
    
    
    var VM = RedemptionPlannerListViewModel()
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var selectedPlannerID = 0
    var totalCartValue = 0
    var requiredPoints = 0
    var averageLesserDate = ""
    var redeemableAverageEarning = ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var tdspercentage1 = 0.0
    var applicabletds = 0.0
    var isRedeem = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        plannerListing()
        myCartList()
        productNameLabel.text = self.productName
        print(tdsprice!)
        self.tdsvalue.text = "\(applicabletds)"
        percentageHeight.constant = 0
        //self.tdsprice.text = "\(tdspercentage1)%"
        points.text = "\(productPoints)"
        let totalImgURL = productCatalogueImgURL + productImage
        productImageView.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        self.todayPoints.text = "\(pointBalance)"
        self.monthlyPointsLabel.text = redeemableAverageEarning
        //        if (productPoints + Int(applicabletds)) > Int(pointBalance)!  {
        //            redeemButton.isEnabled = false
        //            congratulationsImageView.isHidden = true
        //            infoDetailsLbl.isHidden = false
        //            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
        //                infoDetailsLbl.text = "You need \(requiredPoints) more redeemable points to redeem this product"
        //            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
        //                infoDetailsLbl.text = "आप की जरूरत है \(requiredPoints) इस उत्पाद को भुनाने के लिए अधिक रिडीम करने योग्य अंक"
        //            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
        //                infoDetailsLbl.text = "তোমার দরকার \(requiredPoints) এই পণ্যটি খালাস করার জন্য আরও খালাসযোগ্য পয়েন্ট"
        //            }else{
        //                infoDetailsLbl.text = "నీకు అవసరం \(requiredPoints) ఈ ఉత్పత్తిని రీడీమ్ చేయడానికి మరిన్ని రీడీమ్ చేయగల పాయింట్‌లు"
        //            }
        //
        //            redeemButton.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
        //        }else{
        //            congratulationsImageView.isHidden = false
        //            infoDetailsLbl.isHidden = true
        //            redeemButton.isEnabled = true
        //            redeemButton.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
        //            }
        if self.isRedeem == 1{
            congratulationsImageView.isHidden = false
            infoDetailsLbl.isHidden = true
            redeemButton.isEnabled = true
            redeemButton.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }else{
            redeemButton.isEnabled = false
            congratulationsImageView.isHidden = true
            infoDetailsLbl.isHidden = false
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                infoDetailsLbl.text = "You need \(requiredPoints) more redeemable points to redeem this product"
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                infoDetailsLbl.text = "आप की जरूरत है \(requiredPoints) इस उत्पाद को भुनाने के लिए अधिक रिडीम करने योग्य अंक"
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                infoDetailsLbl.text = "তোমার দরকার \(requiredPoints) এই পণ্যটি খালাস করার জন্য আরও খালাসযোগ্য পয়েন্ট"
            }else{
                infoDetailsLbl.text = "నీకు అవసరం \(requiredPoints) ఈ ఉత్పత్తిని రీడీమ్ చేయడానికి మరిన్ని రీడీమ్ చేయగల పాయింట్‌లు"
            }
            
            redeemButton.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
            //        }else{
            //            congratulationsImageView.isHidden = false
            //            infoDetailsLbl.isHidden = true
            //            redeemButton.isEnabled = true
            //            redeemButton.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
            //        }
    }
    languagelocalization()
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Redemption Planner Details")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
func languagelocalization(){
    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
        giftLabel.text = "Your expected redemption of \(productName) is in \(averageLesserDate)"
        self.redemptionPlannerTitleLabel.text = "Redemption Planner Details"
        self.pointHeading.text = "Points"
        self.redeemButton.setTitle("Redeem", for: .normal)
        self.removeButton.setTitle("Remove", for: .normal)
        self.redemptionPlannerSummaryHEadingLabel.text = "Redemption Planner Summary"
        self.todayRedemablePoinsHEading.text = "Redeemable Points as on Today"
        self.todayRedemablePoinsHEading.text = "Points"
        self.avgEarningsLabel.text = "Average earning required per month"
        self.monthlyHeadingLabel.text = "Points"
        self.tdsPts.text = "TDS points"
        self.tdsApplicable.text = "TDS applicable @"
    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
        giftLabel.text = "आपका अपेक्षित मोचन \(productName) में है \(averageLesserDate)"
        self.redemptionPlannerTitleLabel.text = "मोचन योजनाकार विवरण"
        self.pointHeading.text = "पॉइंट्स"
        self.redeemButton.setTitle("भुनाना", for: .normal)
        self.removeButton.setTitle("हटाना", for: .normal)
        self.redemptionPlannerSummaryHEadingLabel.text = "मोचन योजनाकार सारांश"
        self.todayRedemablePoinsHEading.text = "आज के अनुसार रिडीम करने योग्य अंक"
        self.todayRedemablePoinsHEading.text = "पॉइंट्स"
        self.avgEarningsLabel.text = "प्रति माह औसत कमाई की आवश्यकता"
        self.monthlyHeadingLabel.text = "पॉइंट्स"
        self.tdsPts.text = "टीडीएस अंक"
        self.tdsApplicable.text = "टीडीएस लागू @"
    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
        giftLabel.text = "আপনার প্রত্যাশিত খালাস \(productName) মধ্যে আছে \(averageLesserDate)"
        self.redemptionPlannerTitleLabel.text = "রিডেম্পশন প্ল্যানারের বিবরণ"
        self.pointHeading.text = "পয়েন্ট"
        self.redeemButton.setTitle("রিডিম", for: .normal)
        self.removeButton.setTitle("অপসারণ", for: .normal)
        self.redemptionPlannerSummaryHEadingLabel.text = "রিডেম্পশন প্ল্যানার সারাংশ"
        self.todayRedemablePoinsHEading.text = "আজকের মত রিডিমেবল পয়েন্ট"
        self.todayRedemablePoinsHEading.text = "পয়েন্ট"
        self.avgEarningsLabel.text = "প্রতি মাসে গড় উপার্জন প্রয়োজন"
        self.monthlyHeadingLabel.text = "পয়েন্ট"
        self.tdsPts.text = "টিডিএস পয়েন্ট"
        self.tdsApplicable.text = "টিডিএস প্রযোজ্য @"
    }else{
        giftLabel.text = "మీరు ఆశించిన విముక్తి \(productName) లో ఉంది \(averageLesserDate)"
        self.redemptionPlannerTitleLabel.text = "విముక్తి ప్లానర్ వివరాలు"
        self.pointHeading.text = "వపాయింట్లు"
        self.redeemButton.setTitle("రీడీమ్ చేయండి", for: .normal)
        self.removeButton.setTitle("తొలగించు", for: .normal)
        self.redemptionPlannerSummaryHEadingLabel.text = "విముక్తి ప్లానర్ సారాంశం"
        self.todayRedemablePoinsHEading.text = "నేటికి రీడీమ్ చేయగల పాయింట్‌లు"
        self.todayRedemablePoinsHEading.text = "వపాయింట్లు"
        self.avgEarningsLabel.text = "నెలకు సగటు సంపాదన అవసరం"
        self.monthlyHeadingLabel.text = "వపాయింట్లు"
        self.tdsPts.text = "TDS పాయింట్లు"
        self.tdsApplicable.text = "TDS వర్తిస్తుంది @"
    }
}

@IBAction func backButton(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
}
@IBAction func redeemButton(_ sender: Any) {
    myCartList()
    if self.verifiedStatus == 6 || self.verifiedStatus == 4{
        if self.checkAccountStatus == "1"{
            NotificationCenter.default.post(name: .verificationStatus, object: nil)
        }else{
            NotificationCenter.default.post(name: .verificationStatus, object: nil)
        }
        
    }else if self.verifiedStatus == 1{
        
        let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == selectedCatalogueID}
        if filterCategory.count > 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Gift product is already added in the Redeem list"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                    vc!.descriptionInfo = "उपहार उत्पाद पहले से ही रिडीम सूची में जोड़ा जा चुका है"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "উপহার পণ্য ইতিমধ্যেই রিডিম তালিকায় যোগ করা হয়েছে"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "బహుమతి ఉత్పత్తి ఇప్పటికే రీడీమ్ జాబితాలో జోడించబడింది"
                }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            print(self.totalCartValue)
            print(self.pointBalance)
            if self.totalCartValue <= Int(self.pointBalance) ?? 0 {
                if UserDefaults.standard.integer(forKey: "PlannerIsRedeemable") == -3{
                    self.view.makeToast("Your PAN Details are pending,Please contact your administrator!", duration: 2.0, position: .bottom)
                }else if UserDefaults.standard.integer(forKey: "PlannerIsRedeemable") == -4{
                    self.view.makeToast("Your PAN Details are rejected,Please contact your administrator!", duration: 2.0, position: .bottom)
                }else if UserDefaults.standard.integer(forKey: "PlannerIsRedeemable") == 1{
                    let calcValue = self.totalCartValue + Int(productPoints + Int(applicabletds))
                    if calcValue <= Int(self.pointBalance) ?? 0{
                        if self.verifiedStatus == 6 || self.verifiedStatus == 4{
                            if self.checkAccountStatus == "1"{
                                NotificationCenter.default.post(name: .verificationStatus, object: nil)
                            }else{
                                NotificationCenter.default.post(name: .verificationStatus, object: nil)
                            }
                            
                        }else if self.verifiedStatus == 1{
                            addToCartApi()
                        }
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
                    }
                }else{
                    self.view.makeToast("Insufficient point balance to redeem!", duration: 2.0, position: .bottom)
                }
                
                

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
            }
            
        }
    }
}
@IBAction func removeButton(_ sender: Any) {
    removeProductInPlanner()
}


func plannerListing(){
    let parameters = [
        "ActionType": "6",
        "ActorId": "\(userID)"
    ] as [String : Any]
    print(parameters)
    self.VM.plannerListingApi(parameters: parameters) { response in
        self.VM.myPlannerListArray = response?.objCatalogueList ?? []
        print(self.VM.myPlannerListArray.count, "Planner List Cout")
        DispatchQueue.main.async {
            
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
        
        print(response?.returnValue ?? 0, "Added TO Cart")
        
        if response?.returnValue == 1{
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
func removeProductInPlanner(){
    let parameters = [
        "ActionType": 17,
        "ActorId": "\(userID)",
        "RedemptionPlannerId": "\(selectedPlannerID)"
    ] as [String: Any]
    print(parameters)
    self.VM.removePlannedProduct(parameters: parameters) { response in
        if response?.returnValue == 1{
            self.plannerListing()
            self.navigationController?.popViewController(animated: true)
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
                self.stopLoading()
            }
        }
        
    }
}

func myCartList(){
    let parameters = [
        "ActionType": "2",
        "LoyaltyID": "\(loyaltyId)"
    ] as [String: Any]
    print(parameters)
    self.VM.myCartList(parameters: parameters) { response in
        self.VM.myCartListArray = response?.catalogueSaveCartDetailListResponse ?? []
        print(self.VM.myCartListArray.count)
        
        DispatchQueue.main.async {
            for data in self.VM.myCartListArray{
                self.totalCartValue = data.sumOfTotalPointsRequired ?? 0
                print(self.totalCartValue, "TotalValue")
            }
            
            self.stopLoading()
        }
    }
}

}
