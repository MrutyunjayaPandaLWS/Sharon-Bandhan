//
//  RedemptionOTP_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 14/03/22.
//

import UIKit
import Firebase
import DPOTPView


class RedemptionOTP_VC: BaseViewController,UITextFieldDelegate, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
    }
    
    @IBOutlet weak var otpView: DPOTPView!
    

    @IBOutlet var otpVerificationLabel: UILabel!
    @IBOutlet var weSendOtpLabel: UILabel!
    @IBOutlet var otpTF: UITextField!
    @IBOutlet var otpWithinLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var otpWithinLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet var timerLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet var resendOTPStackView: UIStackView!
    @IBOutlet var resendOTPHeightConstraint: NSLayoutConstraint!
    @IBOutlet var didntReciveLabel: UILabel!
    @IBOutlet var resendOTPButton: UIButton!
    @IBOutlet weak var submitBTN: GradientButton!
    
    
    var stateID = 0
    var cityID = 0
    var stateName = ""
    var cityName = ""
    var pincode = ""
    var address1 = ""
    var customerName = ""
    var mobile = ""
    var emailId = ""
    var countryId = 0
    var countryName = ""
    var redeemedPoints = 0
    var productsParameter:JSON?
    var sentSMSParameter:JSON?
    var totalRedeemedPoints = 0
    var redemptionRefId = ""
    
    var dreamGiftId = 0
    var giftPts = 0
    var giftName = ""
    var contractorName = ""
    var giftStatusId = 0
    var redemptionTypeId = 0
    
    var userID = UserDefaults.standard.integer(forKey: "UserID")
    var customerMobile = UserDefaults.standard.string(forKey: "CustomerMobile") ?? ""
    var merchanMobile = UserDefaults.standard.string(forKey: "MerchantMobile") ?? ""
    let emailID = UserDefaults.standard.string(forKey: "CustomerEmail") ?? ""
    let firstname = UserDefaults.standard.string(forKey: "FirstName") ?? ""
    let merchantEmail = UserDefaults.standard.string(forKey: "MerchantEmail") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    
    
    var OTPforVerification = ""
    var newproductArray: [[String:Any]] = []
    var sendSMArray: [[String:Any]] = []
    var getID = ""
    var count = 60
    var timer = Timer()
    var VM = RedemptionOTPVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
      // if #available(iOS 16.0, *) {
            self.myCartList()
                self.getOTP()
        self.otpTF.keyboardType = .numberPad
        self.otpTF.delegate = self
        self.resendOTPStackView.isHidden = true
        self.resendOTPHeightConstraint.constant = 0
        NotificationCenter.default.addObserver(self, selector: #selector(sendSuccess), name: Notification.Name.redemptionSubmission, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissVC), name: Notification.Name.dismissScreen, object: nil)
      languagelocalization()
        print(self.cityID, "City ID")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.otpView.text = ""
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "RedemptionOTP")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    
    
    @objc func sendSuccess(){
        sendSuccessMessage()
    }
    @objc func dismissVC(){
        self.dismiss(animated: true){
            NotificationCenter.default.post(name: .catalogueSubmission, object: nil)
        }
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.otpVerificationLabel.text = "OTP Verification"
            self.weSendOtpLabel.text = "We send a OTP to your Number"
            self.otpWithinLabel.text = "OTP will Receive within"
            self.didntReciveLabel.text = "Didn't receive OTP Code?"
            self.resendOTPButton.setTitle("Resend OTP", for: .normal)
            self.submitBTN.setTitle("Submit", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.otpVerificationLabel.text = "ओटीपी सत्यापन"
            self.weSendOtpLabel.text = "हम आपके नंबर पर एक ओटीपी भेजते हैं"
            self.otpWithinLabel.text = "ओटीपी के भीतर प्राप्त होगा"
            self.didntReciveLabel.text = "ओटीपी कोड प्राप्त नहीं हुआ?"
            self.resendOTPButton.setTitle("ओटीपी पुनः भेजें", for: .normal)
            self.submitBTN.setTitle("प्रस्तुत", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.otpVerificationLabel.text = "ওটিপি ভেরিফিকেশন"
            self.weSendOtpLabel.text = "আমরা আপনার নাম্বারে একটি ওটিপি পাঠাই"
            self.otpWithinLabel.text = "ওটিপি এর মধ্যেই পাবেন"
            self.didntReciveLabel.text = "OTP কোড পাননি?"
            self.resendOTPButton.setTitle("OTP আবার পাঠান", for: .normal)
            self.submitBTN.setTitle("জমা দিন", for: .normal)
        }else{
            self.otpVerificationLabel.text = "OTP ధృవీకరణ"
            self.weSendOtpLabel.text = "మేము మీ నంబర్‌కి OTPని పంపుతాము"
            self.otpWithinLabel.text = "లోపల OTP అందుతుంది"
            self.didntReciveLabel.text = "OTP కోడ్ అందలేదా?"
            self.resendOTPButton.setTitle("OTP ను మళ్ళీ పంపు", for: .normal)
            self.submitBTN.setTitle("సమర్పించండి", for: .normal)
        }
    }
 
 
    func getOTP(){
        
        let parameters = [
            "MerchantUserName": "cpcmerchant",
            "MobileNo": "\(loyaltyId)",
            "UserId": "0",
            "UserName": "\(loyaltyId)",
            "Name": "\(firstname)"
            
        ] as [String: Any]
        print(parameters)
        self.VM.redemptionOTPValue(parameters: parameters) { response in
            DispatchQueue.main.async {
                self.stopLoading()
                print(response?.returnMessage ?? "0")
                self.OTPforVerification = response?.returnMessage ?? ""
                self.count = 60
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            }
      
        }
        
    }
    @objc func update() {
           if(self.count > 1){
               self.count = count - 1
               self.timerLabel.text = "0:\(self.count - 1)"
               self.resendOTPStackView.isHidden = true
               self.resendOTPHeightConstraint.constant = 0
           }else{
               self.resendOTPStackView.isHidden = false
               self.resendOTPHeightConstraint.constant = 32
               self.timerLabel.text = "0:0"
               self.timer.invalidate()
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
            if self.VM.myCartListArray.count != 0 {
                DispatchQueue.main.async {
                    if self.VM.myCartListArray.count != 0{
                        
                        self.newproductArray.removeAll()
                        self.sendSMArray.removeAll()
                        let yesterday = "\(Calendar.current.date(byAdding: .day, value: 0, to: Date())!)"
                        let today = yesterday.split(separator: " ")
                        let desiredDateFormat = self.convertDateFormater("\(today[0])", fromDate: "yyyy-MM-dd", toDate: "yyyy-MM-dd")
                       print("\(desiredDateFormat)")
                        for item in self.VM.myCartListArray {
                            let createdDate = String(item.createdDate ?? "").split(separator: " ")
                            
                          
                            
                                let singleImageDict:[String:Any] = [
                                    "CatalogueId": item.catalogueId ?? 0,
                                    "DeliveryType": "In Store",
                                    "HasPartialPayment": false,
                                    "NoOfPointsDebit": "\(item.pointsRequired ?? 0)",
                                    "NoOfQuantity": item.noOfQuantity ?? 0,
                                    "PointsRequired": "\(item.pointsRequired ?? 0)",
                                    "ProductCode": "\(item.productCode ?? "")",
                                    "ProductImage": "\(item.productImage ?? "")",
                                    "ProductName": "\(item.productName ?? "")",
                                    "RedemptionDate": "\(desiredDateFormat)",
                                    "RedemptionId": item.redemptionId ?? 0,
                                    "RedemptionTypeId": self.redemptionTypeId,
                                    "Status": item.status ?? 0,
                                    "CatogoryId": item.categoryID ?? 0,
                                    "CustomerCartId": item.customerCartId ?? 0,
                                    "TermsCondition": "\(item.termsCondition ?? "")",
                                    "TotalCash": item.totalCash ?? 0,
                                    "VendorId": item.vendorId ?? 0
                                ]
                                print(singleImageDict)
                                self.newproductArray.append(singleImageDict)
                                
                                let smsArray:[String:Any] = [
                                    "CatalogueId": item.catalogueId ?? 0,
                                    "DeliveryType": "In Store",
                                    "HasPartialPayment": false,
                                    "NoOfPointsDebit": "\(item.pointsRequired ?? 0)",
                                    "NoOfQuantity": item.noOfQuantity ?? 0,
                                    "PointsRequired": "\(item.pointsRequired ?? 0)",
                                    "ProductCode": "\(item.productCode ?? "")",
                                    "ProductImage": "\(item.productImage ?? "")",
                                    "ProductName": "\(item.productName ?? "")",
                                    "RedemptionDate": "\(desiredDateFormat)",
                                    "RedemptionId": item.redemptionId ?? 0,
                                    "RedemptionRefno": "\(self.redemptionRefId)",
                                    "RedemptionTypeId": self.redemptionTypeId,
                                    "Status": item.status ?? 0,
                                    "TermsCondition": "\(item.termsCondition ?? "")",
                                    "TotalCash": item.totalCash ?? 0,
                                    "VendorId": item.vendorId ?? 0
                                    ]
                                print(smsArray, "SMS Array")
                                print(self.redemptionRefId, "Refer ID")
                                self.sendSMArray.append(smsArray)
                            
                            
                        }
                        
                        
                }
                    
                }
            }else{
                DispatchQueue.main.async {
                    self.stopLoading()
                }
            }
            
        }
    }
    

    

    
    @IBAction func resendOTP(_ sender: Any) {
        self.otpView.text = ""
        getOTP()

    }
    
    @available(iOS 16.0, *)
    @IBAction func submitButton(_ sender: Any) {
        print(contractorName, "Contractor Name")
        print(self.cityID, "City ID")
        if otpView.text?.count == 6{
            if self.OTPforVerification == self.otpView.text!{
                self.timer.invalidate()
                if self.contractorName == ""{
                    productsParameter = [
                        "ActionType": 51,
                        "ActorId": userID,
                        "MemberName": "\(self.customerName)",
                        "ObjCatalogueDetails": [
                                "DomainName": "Century_Ply"
                            ],
                        "ObjCatalogueList": self.newproductArray as [[String: Any]],
                        "ObjCustShippingAddressDetails":["Address1":"\(self.address1)","CityId":"\(self.cityID)", "CityName":"\(self.cityName)","CountryId":"\(self.countryId)","StateName": "\(self.stateName)","StateId":"\(self.stateID)","Zip":"\(self.pincode)","Email":"\(self.emailId)","FullName":"\(self.customerName)","Mobile": self.mobile],"SourceMode":5
                    ]
                    print(productsParameter ?? [])
                }else{
                    self.productsParameter = [
                            "ActionType": 51,
                            "ActorId": userID,
                            "MemberName": "\(contractorName)",
                            "ObjCatalogueList": [
                                [
                                    "DreamGiftId": "\(dreamGiftId)",
                                    "LoyaltyId": "\(loyaltyId)",
                                    "PointBalance": "\(pointBalance)",
                                    "NoOfPointsDebit": "\(giftPts)",
                                    "NoOfQuantity": 1,
                                    "PointsRequired": "\(giftPts)",
                                    "ProductName": "\(giftName)",
                                    "RedemptionTypeId": self.redemptionTypeId
                                ]
                            ],
                            "ObjCustShippingAddressDetails": [
                                "Address1": "\(self.address1)",
                                "CityId": self.cityID,
                                "CityName": "\(self.cityName)",
                                "CountryId": 103,
                                "Email": "\(self.emailId)",
                                "FullName": "\(contractorName)",
                                "Mobile": "\(loyaltyId)",
                                "StateId": self.stateID,
                                "StateName": "\(self.stateName)",
                                "Zip": "\(self.pincode)"
                            ],
                            "SourceMode": 5,
                            "ObjCatalogueDetails": [
                                "DomainName": "Century_Ply"
                            ]
                        
                    ] as [String: Any]
                    print(self.productsParameter ?? [], "Dream Gift")
                }
                self.VM.redemptionSubmission(parameters: productsParameter!) { response in
                       print(response?.returnMessage ?? "", "Redemption Submission")
                        print(response?.returnValue ?? "", "ReturnValue")
                        let message = response?.returnMessage ?? ""
                        print(message)

                        let seperateMessage = message.split(separator: "-")
                    print(seperateMessage.count, "Akjdslafjasjefjklsdaljkfsdljfljdaf")
                    if seperateMessage.count > 1 {
                        print(seperateMessage[0])
                        print(seperateMessage[1])
                        print(seperateMessage[2])
                        if seperateMessage[1] >= "1" {
                            print("Success")
                            self.redemptionRefId = response?.returnMessage ?? ""
                            if self.contractorName == ""{
                                self.myCartList()
                            }
                            DispatchQueue.main.async {
                                self.stopLoading()
                                self.sendSMSApi()
                            }
                        }
                    }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.itsComeFrom = "RedemptionFailed"
                                self.stopLoading()
                                self.timer.invalidate()
                                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                    vc!.descriptionInfo = "Redemption Failed"
                                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                     vc!.descriptionInfo = "मोचन विफल"
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                    vc!.descriptionInfo = "রিডিম্পশন ব্যর্থ হয়েছে"
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                                    vc!.descriptionInfo = "విముక్తి విఫలమైంది"
                                  }
                                vc!.modalPresentationStyle = .overFullScreen
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
//                        self.stopLoading()
//                        self.timer.invalidate()
//                        self.dismiss(animated: true){
//                //            dismissCurrentVC
//                            NotificationCenter.default.post(name: .dismissCurrentVC, object: nil)
//                        }
                        }
                    
                }
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "InValid OTP"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "अमान्य ओटीपी"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "অবৈধ ওটিপি৷"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "చెల్లని OTP"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }else{
            if otpView.text?.count == 0 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Please Enter Correct OTP"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "कृपया सही ओटीपी दर्ज करें"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "দয়া করে সঠিক ওটিপি লিখুন"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "దయచేసి సరైన OTPని ఎంటర్ చేయండి"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else if otpView.text?.count != 6{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Enter Valid OTP"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "वैध ओटीपी दर्ज करें"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "বৈধ ওটিপি লিখুন"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "చెల్లుబాటు అయ్యే OTPని ఎంటర్ చేయండి"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.stopLoading()
        self.timer.invalidate()
        self.dismiss(animated: true){
//            dismissCurrentVC
            NotificationCenter.default.post(name: .dismissCurrentVC, object: nil)
        }
    }
    
    func sendSMSApi(){
        print(redemptionRefId, "RefID")
        print(self.redeemedPoints, "RedeemedPoints")
        if self.contractorName == ""{
            productsParameter = [
                
                    "ActionType": 51,
                    "MerchantEmailID": "\(merchantEmail)",
                    "MerchantID": 1,
                    "MerchantMobileNo": "\(merchanMobile)",
                    "ActorId": "\(userID)",
                    "MemberName": "\(firstname)",
                    "UserName": "\(customerMobile)",
                    "TotalPointsRedeemed": "\(redeemedPoints)",
                    "ObjCatalogueList": self.sendSMArray as [[String: Any]],
                    "ObjCustShippingAddressDetails": [
                        "Address1": "\(self.address1)",
                        "CityId": self.cityID,
                        "CityName": "\(self.cityName)",
                        "CountryId": 103,
                        "Email": "",
                        "FullName": "\(firstname)",
                        "Mobile": "\(mobile)",
                        "StateId": self.stateID,
                        "StateName": "\(self.stateName)",
                        "Zip": "\(self.pincode)"
                    ]
                    ] as [String:Any]
        }else{
            productsParameter = [
                    "actiontype": 51,
                    "merchantemailid": "\(self.merchantEmail)",
                    "MerchantID": 1,
                    "MerchantMobileNo": "\(self.merchanMobile)",
                    "ActorId": userID,
                    "MemberName": "\(contractorName)",
                    "UserName": "\(loyaltyId)",
                    "TotalPointsRedeemed": "\(giftPts)",
                    "ObjCatalogueList": [
                            "DreamGiftId": "\(dreamGiftId)",
                            "LoyaltyId": "\(loyaltyId)",
                            "PointBalance": "\(pointBalance)",
                            "NoOfPointsDebit": "\(giftPts)",
                            "NoOfQuantity": 1,
                            "PointsRequired": "\(giftPts)",
                            "ProductName": "\(giftName)",
                            "RedemptionTypeId": self.redemptionTypeId
                        ],
                    "ObjCustShippingAddressDetails": [
                        "Address1": "\(self.address1)",
                        "CityId": self.cityID,
                        "CityName": "\(cityName)",
                        "CountryId": 103,
                        "Email": "",
                        "FullName": "\(self.contractorName)",
                        "Mobile": "\(loyaltyId)",
                        "StateId": stateID,
                        "StateName": "\(stateName)",
                        "Zip": "\(pincode)"
                    ]
                ] as [String:Any]
        }
       
        print(productsParameter!)
        self.VM.sendSMSApi(parameters: productsParameter!) { response in
            print(response?.returnValue ?? 0, "Send SMS Status")
            if response?.returnValue ?? 0 >= 0{
                DispatchQueue.main.async{
                    self.sendSuccessMessage()
                }
            }
            }
        }
    
    func sendSuccessMessage(){
        if self.contractorName == ""{
            productsParameter = [
                    "CustomerName": "\(firstname)",
                    "EmailID": "",
                    "LoyaltyID": "\(loyaltyId)",
                    "Mobile": "\(customerMobile)",
                    "PointBalance": "\(pointBalance)",
                    "RedeemedPoint": "\(redeemedPoints)"
            ] as [String:Any]
        }else{
            productsParameter = [
                    "CustomerName": "\(firstname)",
                    "EmailID": "",
                    "LoyaltyID": "\(loyaltyId)",
                    "Mobile": "\(customerMobile)",
                    "PointBalance": "\(pointBalance)",
                    "RedeemedPoint": "\(giftPts)"
            ] as [String:Any]
        }
        
        print(productsParameter ?? [])
        
        self.VM.sendSUCESSApi(parameters: productsParameter!) { response in
            DispatchQueue.main.async {
                self.stopLoading()
                if response?.sendSMSForSuccessfulRedemptionMobileAppResult! == true{
                    if self.contractorName == ""{
                        
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionSuccess_VC") as! RedemptionSuccess_VC
                        vc.modalPresentationStyle = .overCurrentContext
                        vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true, completion: nil)
                    }else{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionSuccess_VC") as! RedemptionSuccess_VC
                        vc.modalPresentationStyle = .overCurrentContext
                        vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true, completion: nil)
                        self.removeDreamGift()
                    }
                    
                }
                self.stopLoading()
            }
           
        }
    }
    
    func removeDreamGift(){
        let parameters = [
                "ActionType": 4,
                "ActorId": "\(userID)",
                "DreamGiftId": "\(dreamGiftId)",
                "GiftStatusId": 4
        ] as [String: Any]
        print(parameters)
        self.VM.removeDreamGift(parameters: parameters) { response in
            let result = response?.returnValue ?? 0
            print(result)
            if result == 1 {
                DispatchQueue.main.async{
                    self.stopLoading()
                }
                
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")

      if string == numberFiltered {
        let currentText = otpView.text ?? "-"
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 6
      } else {
        return false
      }
    }
}
