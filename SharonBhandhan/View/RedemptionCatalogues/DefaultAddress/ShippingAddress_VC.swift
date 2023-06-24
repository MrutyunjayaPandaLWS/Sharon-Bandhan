//
//  ShippingAddress_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 14/03/22.
//

import UIKit
import Firebase
import LanguageManager_iOS

class ShippingAddress_VC: BaseViewController, SendUpdatedAddressDelegate, popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
   
    @IBOutlet var customerAddressTV: UITextView!
    @IBOutlet var customerNameLabel: UILabel!
    @IBOutlet var totalPointsHeadingLabel: UILabel!
    @IBOutlet var totalPoints: UILabel!
    @IBOutlet var proceedToCheckoutButton: GradientButton!
    @IBOutlet var defaultAddressHeadingLabel: UILabel!
    
    var receiverName = ""
    var address = ""
    var stateID = -1
    var stateName = ""
    var districtID = -1
    var districtName = ""
    var cityID = -1
    var cityName = ""
    var pincode = ""
    var emailID = ""
    var address1 = ""
    var countryID = -1
    var countryName = ""
    var redemptionDate = ""
    
    var mobilenumber = ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    
    
    var dreamGiftID = 0
    var totalPoint = 0
    var giftName = ""
    var contractorName = ""
    var giftStatusId = 0
    var redemptionTypeId = 0
    var VM = ShippingAddressViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        print(totalPoint,"sdjsd")
        languagelocalization()
        customerDetailApi()
        NotificationCenter.default.addObserver(self, selector: #selector(successScreen), name: Notification.Name.catalogueSubmission, object: nil)
        //dismissCurrentVC
        NotificationCenter.default.addObserver(self, selector: #selector(afterDismissed), name: Notification.Name.dismissCurrentVC, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.stopLoading()
        
        self.totalPoints.text = "\(self.totalPoint)"
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Default Address")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

    }
    @objc func afterDismissed(){
        customerDetailApi()
    }
    @objc func successScreen(){
        self.navigationController?.popToRootViewController(animated: true)
    }
   
    func languagelocalization(){
        self.defaultAddressHeadingLabel.text = "coDefaultAddressKEY".localiz()
        self.totalPointsHeadingLabel.text = "mcTotalPointsKEY".localiz()
        self.proceedToCheckoutButton.setTitle("PROCESS TO CHECKOUT".localiz(), for: .normal)
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.defaultAddressHeadingLabel.text = "Default Address"
//            self.totalPointsHeadingLabel.text = "Total Points"
//            self.proceedToCheckoutButton.setTitle("PROCEED TO CHECKOUT", for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.defaultAddressHeadingLabel.text = "डिफ़ॉल्ट पता"
//            self.totalPointsHeadingLabel.text = "कुल अंक"
//            self.proceedToCheckoutButton.setTitle("चेक आउट करने के लिए आगे बढ़ें", for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.defaultAddressHeadingLabel.text = "ডিফল্ট ঠিকানা"
//            self.totalPointsHeadingLabel.text = "মোট পয়েন্ট"
//            self.proceedToCheckoutButton.setTitle("চেকআউটে এগিয়ে যান", for: .normal)
//        }else{
//            self.defaultAddressHeadingLabel.text = "డిఫాల్ట్ చిరునామా"
//            self.totalPointsHeadingLabel.text = "మొత్తం పాయింట్లు"
//            self.proceedToCheckoutButton.setTitle("చెక్అవుట్‌కి వెళ్లండి", for: .normal)
//        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditAddressViewController") as! EditAddressViewController
        vc.delegate = self
        vc.selectedname = self.customerNameLabel.text ?? ""
        vc.selectedemail = self.emailID
        vc.selectedmobile = self.mobilenumber
        vc.selectedState = self.stateName
        vc.selectedStateID = self.stateID
        vc.selectedCountry = self.countryName
        vc.selectedCountryId = self.countryID
        vc.selectedCity = self.cityName
        vc.selectedCityID = self.cityID
        vc.selectedaddress = self.address1
        vc.selectedpincode = self.pincode
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func checkoutButton(_ sender: Any) {
        self.startLoading()
        
        if self.verifiedStatus == 6 || self.verifiedStatus == 4 || self.verifiedStatus != 1{
            if self.checkAccountStatus == "1"{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }else{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }
            
        }else if self.verifiedStatus == 1{
            if stateID == -1 || cityID == -1 || address1 == "" || pincode == "" || mobilenumber == ""{
            self.stopLoading()
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Shipping address requires: State,City,Address,Pin code and Mobile Number,details,Click on 'Edit' to edit and add details".localiz()
                    
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Shipping address requires: State,City,Address,Pin code and Mobile Number,details,Click on 'Edit' to edit and add details"
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "शिपिंग पते की आवश्यकता है: राज्य, शहर, पता, पिनकोड और मोबाइल_नंबर, विवरण, संपादित करने और विवरण जोड़ने के लिए 'संपादित करें' पर क्लिक करें"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "শিপিং ঠিকানার প্রয়োজন: রাজ্য, শহর, ঠিকানা, পিনকোড এবং মোবাইল_ নম্বর, বিশদ বিবরণ, সম্পাদনা করতে ক্লিক করুন"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "షిప్పింగ్ చిరునామా అవసరం: రాష్ట్రం, నగరం, చిరునామా, పిన్‌కోడ్ మరియు మొబైల్_నెంబర్, వివరాలు, క్లిక్ చేయండి'సవరించు'కు సవరించండి"
//                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                if self.totalPoint <= Int(self.pointBalance) ?? 0{
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionOTP_VC") as? RedemptionOTP_VC
                    vc!.stateID = self.stateID
                    vc!.cityID = self.cityID
                    
                    vc!.stateName = self.stateName
                    vc!.cityName = self.cityName
                    vc!.pincode = self.pincode
                    vc!.address1 = self.address1
                    vc!.customerName = self.customerNameLabel.text ?? ""
                    vc!.mobile = self.mobilenumber
                    vc!.emailId = self.emailID
                    vc!.countryId = self.countryID
                    vc!.countryName = self.countryName
                    vc!.redeemedPoints = self.totalPoint
                    vc!.dreamGiftId = self.dreamGiftID
                    vc!.giftPts = self.totalPoint
                    vc!.giftName = self.giftName
                    vc!.contractorName = self.contractorName
                    vc!.giftStatusId = self.giftStatusId
                    vc!.redemptionTypeId = self.redemptionTypeId
                    print(self.redemptionTypeId, "RedemptionTypeId")
                    
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }else{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "Insufficent Point Balance".localiz()
                        
//                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                            vc!.descriptionInfo = "Insufficient Point Balance"
//                         }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                             vc!.descriptionInfo = "अपर्याप्त प्वाइंट बैलेंस"
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                            vc!.descriptionInfo = "অপর্যাপ্ত পয়েন্ট ব্যালেন্স"
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                            vc!.descriptionInfo = "తగినంత పాయింట్ బ్యాలెన్స్ లేదు"
//                          }
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
              
            }
        }
        
    }
    
    //Delegate:
    
    
    func updatedAddressDetails(_ vc: EditAddressViewController) {
        DispatchQueue.main.async {
            self.customerNameLabel.text = vc.selectedname
            print(vc.selectedname)
            print(vc.selectedCity)
            print(vc.selectedpincode)
            print(vc.selectedmobile)
            print(vc.selectedemail)
            
            self.customerAddressTV.text = "\(vc.selectedaddress),\n\(vc.selectedState),\n\(vc.selectedCity), \(vc.selectedpincode),\n\("rMobileKEY".localiz())o: \(vc.selectedmobile),\n\("ewEmailIDKEY".localiz()):\(vc.selectedemail)"

//            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                self.customerAddressTV.text = "\(vc.selectedaddress),\n\(vc.selectedState),\n\(vc.selectedCity), \(vc.selectedpincode),\nMobile No: \(vc.selectedmobile),\nEmail ID:\(vc.selectedemail)"
//             }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                 self.customerAddressTV.text = "\(vc.selectedaddress),\n\(vc.selectedState),\n\(vc.selectedCity), \(vc.selectedpincode),\nमोबाइल नहीं है: \(vc.selectedmobile),\nईमेल आईडी:\(vc.selectedemail)"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                self.customerAddressTV.text = "\(vc.selectedaddress),\n\(vc.selectedState),\n\(vc.selectedCity), \(vc.selectedpincode),\nমোবাইল নাম্বার: \(vc.selectedmobile),\nইমেইল আইডি:\(vc.selectedemail)"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                self.customerAddressTV.text = "\(vc.selectedaddress),\n\(vc.selectedState),\n\(vc.selectedCity), \(vc.selectedpincode),\nమొబైల్ నెం: \(vc.selectedmobile),\nఇమెయిల్ ID:\(vc.selectedemail)"
//              }
           
//            self.pincode = vc.selectedpincode
//            self.stateID = vc.selectedStateID
//            self.stateName = vc.selectedState
//            self.cityName = vc.selectedCity
//            print(vc.selectedStateID)
//            self.cityID = vc.selectedCityID
//            print(vc.selectedCityID)
//            self.address1 = vc.selectedaddress
//            self.emailID = vc.selectedemail
//            self.mobilenumber = vc.selectedmobile
//            self.countryID = vc.selectedCountryId
//            self.countryName = vc.selectedCountry
        }
    }
    
    // Api:-
    
    func customerDetailApi(){
        let parameters = [
            "ActionType": "6",
            "CustomerId": "\(userID)"
        ] as [String: Any]
        print(parameters)
        self.VM.myProifleDetails(parameters: parameters) { response in
            let profileDetails = response?.getCustomerDetailsMobileAppResult?.lstCustomerJson ?? []
            DispatchQueue.main.async {
                self.stopLoading()
                
                self.customerAddressTV.text = "\(profileDetails[0].address1 ?? "")\n\(profileDetails[0].cityName ?? ""),\n\(profileDetails[0].stateName ?? ""), \(profileDetails[0].zip ?? "")\n\("rMobileKEY".localiz()): \(profileDetails[0].mobile ?? "")\n\("mpEmailIDKEY".localiz()): \(profileDetails[0].email ?? "")"
                
                
//                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                    self.customerAddressTV.text = "\(profileDetails[0].address1 ?? "")\n\(profileDetails[0].cityName ?? ""),\n\(profileDetails[0].stateName ?? ""), \(profileDetails[0].zip ?? "")\n\("Mobile No"): \(profileDetails[0].mobile ?? "")\n\("EmailID"): \(profileDetails[0].email ?? "")"
//
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                    self.customerAddressTV.text = "\(profileDetails[0].address1 ?? "")\n\(profileDetails[0].cityName ?? ""),\n\(profileDetails[0].stateName ?? ""), \(profileDetails[0].zip ?? "")\n\("मोबाइल नहीं है:"): \(profileDetails[0].mobile ?? "")\n\("ईमेल आईडी"): \(profileDetails[0].email ?? "")"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                    self.customerAddressTV.text = "\(profileDetails[0].address1 ?? "")\n\(profileDetails[0].cityName ?? ""),\n\(profileDetails[0].stateName ?? ""), \(profileDetails[0].zip ?? "")\n\("মোবাইল নাম্বার"): \(profileDetails[0].mobile ?? "")\n\("ইমেইল আইডি"): \(profileDetails[0].email ?? "")"
//                }else{
//                    self.customerAddressTV.text = "\(profileDetails[0].address1 ?? "")\n\(profileDetails[0].cityName ?? ""),\n\(profileDetails[0].stateName ?? ""), \(profileDetails[0].zip ?? "")\n\("మొబైల్ నెం"): \(profileDetails[0].mobile ?? "")\n\("ఇమెయిల్ ID"): \(profileDetails[0].email ?? "")"
//                }
                self.stateID = profileDetails[0].stateId ?? 0
                self.stateName = profileDetails[0].stateName ?? ""
                self.districtID = profileDetails[0].districtId ?? 0
                self.cityID = profileDetails[0].cityId ?? 0
                self.cityName = profileDetails[0].cityName ?? ""
                self.pincode = profileDetails[0].zip ?? ""
                self.countryID = profileDetails[0].countryId ?? 0
                self.countryName = profileDetails[0].countryName ?? ""
                self.address1 = profileDetails[0].address1 ?? ""
                self.mobilenumber = profileDetails[0].mobile ?? ""
                self.customerNameLabel.text = profileDetails[0].firstName ?? ""
                self.emailID = profileDetails[0].email ?? ""
            }
           
            
           
          
        }
    }
}
