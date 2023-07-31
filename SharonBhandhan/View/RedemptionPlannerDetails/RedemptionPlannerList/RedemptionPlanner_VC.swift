//
//  RedemptionPlanner_VC.swift
//  centuryDemo
//
//  Created by Arkmacbook on 12/03/22.
//

import UIKit
import SDWebImage
import Firebase
import Toast_Swift
import LanguageManager_iOS

class RedemptionPlanner_VC: BaseViewController, RedemptionPlannerDelegate, popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
    }
    
   
    @IBOutlet var redemptionPlannerTitleLabel: UILabel!
    @IBOutlet var productsTableView: UITableView!
//    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var addToPlannerBTN: GradientButton!
    
    var VM = RedemptionPlannerListViewModel()
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var selectedPlannerID = 0
    var totalCartValue = 0
    var catalogueID = 0
    var fromSideMenu = ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.addToPlannerBTN.isHidden = true
        self.productsTableView.delegate = self
        self.productsTableView.dataSource = self
        self.productsTableView.separatorStyle = .none
        var vc = self.storyboard?.instantiateViewController(withIdentifier: "TDS_PopUpVC") as! TDS_PopUpVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
  
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            self.plannerListing()
            self.myCartList()
        }
        languagelocalization()
        
   
//            guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//            tracker.set(kGAIScreenName, value: "Redemption Planner Listing")
//
//            guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//            tracker.send(builder.build() as [NSObject : AnyObject])

    }
    func languagelocalization(){
        self.redemptionPlannerTitleLabel.text = "wlWishlistKEY".localiz()
        self.addToPlannerBTN.setTitle("Add To Planner".localiz(), for: .normal)
        
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.redemptionPlannerTitleLabel.text = "wlWishlistKEY".localiz()
//            self.addToPlannerBTN.setTitle("Add To Planner".localiz(), for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.redemptionPlannerTitleLabel.text = "मोचन योजनाकार"
//            self.addToPlannerBTN.setTitle("योजनाकार में जोड़ें", for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.redemptionPlannerTitleLabel.text = "রিডেম্পশন প্ল্যানার"
//            self.addToPlannerBTN.setTitle("প্ল্যানার যোগ করুন", for: .normal)
//        }else{
//            self.redemptionPlannerTitleLabel.text = "విముక్తి ప్లానర్"
//            self.addToPlannerBTN.setTitle("ప్లానర్‌కు జోడించు", for: .normal)
//        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func addedToPlannerBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionCatalogueVC") as! RedemptionCatalogueVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //Delegate:-
    
    func removeProduct(_ cell: RedemptionPlanner_TVC) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            guard let tappedIndex = productsTableView.indexPath(for: cell) else{return}
            self.selectedPlannerID = self.VM.myPlannerListArray[tappedIndex.row].redemptionPlannerId ?? 0
            self.removeProductInPlanner()
            self.productsTableView.reloadData()
        }
    }
    
    func producDetails(_ cell: RedemptionPlanner_TVC) {
        guard let tappedIndex = productsTableView.indexPath(for: cell) else{return}
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionPlannerDetails_VC") as! RedemptionPlannerDetails_VC
        vc.productImage = self.VM.myPlannerListArray[tappedIndex.row].productImage ?? ""
        vc.tdspercentage1 = Double(self.VM.myPlannerListArray[tappedIndex.row].tDSPercentage ?? 0)
        print(vc.tdspercentage1,"%%Points")
        vc.applicabletds = Double(self.VM.myPlannerListArray[tappedIndex.row].applicableTds ?? 0)
        vc.productName = self.VM.myPlannerListArray[tappedIndex.row].productName ?? ""
        vc.productPoints = self.VM.myPlannerListArray[tappedIndex.row].pointsRequired ?? 0
        vc.selectedPlannerID = self.VM.myPlannerListArray[tappedIndex.row].redemptionPlannerId ?? 0
        vc.selectedCatalogueID = self.VM.myPlannerListArray[tappedIndex.row].catalogueId ?? 0
        vc.averageLesserDate = self.VM.myPlannerListArray[tappedIndex.row].avgLesserExpDate ?? ""
        vc.redeemableAverageEarning = self.VM.myPlannerListArray[tappedIndex.row].redeemableAverageEarning ?? ""
        vc.isRedeem = self.VM.myPlannerListArray[tappedIndex.row].is_Redeemable ?? 0
        let calcValue =  ((self.VM.myPlannerListArray[tappedIndex.row].pointsRequired ?? 0) + Int(self.VM.myPlannerListArray[tappedIndex.row].applicableTds ?? Int(0.0))) - Int(pointBalance)!
        print(calcValue)
        vc.requiredPoints = calcValue
       
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func productRedeem(_ cell: RedemptionPlanner_TVC) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            self.selectedPlannerID = -1
            guard let tappedIndex = productsTableView.indexPath(for: cell) else{return}
            if cell.productRedeemBTN.tag == tappedIndex.row{
                let filterCategory = self.VM.myCartListArray.filter { $0.catalogueId == self.VM.myPlannerListArray[tappedIndex.row].catalogueId ?? 0}
                if filterCategory.count > 0{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "Gift product is already added in the Redeem list".localiz()
                        
                        //                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        //                        vc!.descriptionInfo = "Gift product is already added in the Redeem list".localiz()
                        //                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                        //                         vc!.descriptionInfo = "उपहार उत्पाद पहले से ही रिडीम सूची में जोड़ा जा चुका है"
                        //                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        //                        vc!.descriptionInfo = "উপহার পণ্য ইতিমধ্যেই রিডিম তালিকায় যোগ করা হয়েছে"
                        //                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        //                        vc!.descriptionInfo = "బహుమతి ఉత్పత్తి ఇప్పటికే రీడీమ్ జాబితాలో జోడించబడింది"
                        //                      }
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }else{
                    print(UserDefaults.standard.integer(forKey: "PlannerIsRedeemable"))
                    if self.totalCartValue < Int(self.pointBalance) ?? 0 {
                        let calcValue = self.totalCartValue + Int(self.VM.myPlannerListArray[tappedIndex.row].pointsRequired!) + Int(self.VM.myPlannerListArray[tappedIndex.row].applicableTds ?? 0)
                        if calcValue <= Int(self.pointBalance) ?? 0{
                            if self.verifiedStatus == 6 || self.verifiedStatus == 4{
                                if self.checkAccountStatus == "1"{
                                    NotificationCenter.default.post(name: .verificationStatus, object: nil)
                                }else{
                                    NotificationCenter.default.post(name: .verificationStatus, object: nil)
                                }
                                
                            }else if self.verifiedStatus == 1{
                                if UserDefaults.standard.integer(forKey: "PlannerIsRedeemable") == -3{
                                    self.view.makeToast("Your PAN Details are pending,Please contact your administrator!".localiz(), duration: 2.0, position: .bottom)
                                }else if UserDefaults.standard.integer(forKey: "PlannerIsRedeemable") == -4{
                                    self.view.makeToast("Your PAN Details are rejected,Please contact your administrator!".localiz(), duration: 2.0, position: .bottom)
                                }else if UserDefaults.standard.integer(forKey: "PlannerIsRedeemable") == 1{
                                    self.selectedPlannerID = self.VM.myPlannerListArray[tappedIndex.row].catalogueId ?? 0
                                    addToCartApi()
                                }else{
                                    self.view.makeToast("Insufficient point balance to redeem!".localiz(), duration: 2.0, position: .bottom)
                                }
                            }
                            
                        }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "Insufficent Point Balance".localiz()
                                
                                
                                //                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                //                                vc!.descriptionInfo = "Insufficent Point Balance".localiz()
                                //                             }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                //                                 vc!.descriptionInfo = "अपर्याप्त अंक संतुलन"
                                //                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                //                                vc!.descriptionInfo = "অপর্যাপ্ত পয়েন্ট ব্যালেন্স"
                                //                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                                //                                vc!.descriptionInfo = "సరిపోని పాయింట్లు బ్యాలెన్స్"
                                //                              }
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
                        }
                    }else{
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "Insufficent Point Balance".localiz()
                            
                            //                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            //                            vc!.descriptionInfo = "Insufficent Point Balance".localiz()
                            //                         }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            //                             vc!.descriptionInfo = "अपर्याप्त अंक संतुलन"
                            //                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            //                            vc!.descriptionInfo = "অপর্যাপ্ত পয়েন্ট ব্যালেন্স"
                            //                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                            //                            vc!.descriptionInfo = "సరిపోని పాయింట్లు బ్యాలెన్స్"
                            //                          }
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                    }
                }
                self.productsTableView.reloadData()
            }
        }
    }
    
    //Api:-
    
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
                
                if self.VM.myPlannerListArray.count != 0 {
                    
                    UserDefaults.standard.set(self.VM.myPlannerListArray[0].is_Redeemable ?? 0, forKey: "PlannerIsRedeemable")
                    UserDefaults.standard.synchronize()
                    print(UserDefaults.standard.integer(forKey: "PlannerIsRedeemable"))
                    self.productsTableView.isHidden = false
                    self.addToPlannerBTN.isHidden = true
                    self.productsTableView.reloadData()
                }else{
                    self.productsTableView.isHidden = true
                    self.addToPlannerBTN.isHidden = false
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
                      "CatalogueId": "\(selectedPlannerID)",
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
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyCart_VC") as! MyCart_VC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Something went wrong please try again later.".localiz()
                    
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Something went wrong please try again later.".localiz()
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "कुछ गलत हुआ कृपया बाद में पुन: प्रयास करें।"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "কিছু ভুল হয়েছে। পরে আবার চেষ্টা করুন."
//
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "ఏదో తప్పు జరిగినది. దయచేసి కాసేపు ఆగక ప్రయత్నించండి."
//                      }
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
                self.stopLoading()
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Something went wrong please try again later.".localiz()
                    
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Something went wrong please try again later.".localiz()
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "कुछ गलत हुआ कृपया बाद में पुन: प्रयास करें।"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "কিছু ভুল হয়েছে। পরে আবার চেষ্টা করুন."
//                        
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "ఏదో తప్పు జరిగినది. దయచేసి కాసేపు ఆగక ప్రయత్నించండి."
//                      }
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
                

                self.productsTableView.reloadData()
                self.stopLoading()
            }
        }
    }
}

extension RedemptionPlanner_VC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.VM.myPlannerListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedemptionPlanner_TVC") as! RedemptionPlanner_TVC
        cell.delegate = self
        cell.selectionStyle = .none
        cell.desireDateLabel.text = self.VM.myPlannerListArray[indexPath.row].actualRedemptionDate ?? ""
        cell.pointsLabel.text = "\(self.VM.myPlannerListArray[indexPath.row].pointsRequired ?? 0)"
        cell.productNameLabel.text = self.VM.myPlannerListArray[indexPath.row].productName ?? ""
        let receivedImage = self.VM.myPlannerListArray[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell.productImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "Group 6524"))
        cell.productDetailsBTN.tag = indexPath.row
        cell.productRedeemBTN.tag = indexPath.row
        cell.removeProductBTN.tag = indexPath.row
    
        
        if VM.myPlannerListArray[indexPath.row].is_Redeemable == 1{
            cell.productRedeemBTN.isEnabled = true
            cell.productRedeemBTN.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }else{
            cell.productRedeemBTN.isEnabled = false
            cell.productRedeemBTN.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
        }
        
//        if ((self.VM.myPlannerListArray[indexPath.row].pointsRequired ?? 0)+Int(self.VM.myPlannerListArray[indexPath.row].ApplicableTds ?? 0.0)) > Int(pointBalance)!  {
//            cell.productRedeemBTN.isEnabled = false
//            cell.productRedeemBTN.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
//        }else{
//                cell.productRedeemBTN.isEnabled = true
//                cell.productRedeemBTN.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
//            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
    
}
