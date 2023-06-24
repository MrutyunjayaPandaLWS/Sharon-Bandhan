//
//  DreamGiftDetailsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//
import UIKit
import SDWebImage
import Firebase
import Toast_Swift
import LanguageManager_iOS
class DreamGiftDetailsViewController: BaseViewController, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
    }
    
    

    @IBOutlet weak var tdspopints: UILabel!
    @IBOutlet var dreamGiftMessage: UILabel!
    @IBOutlet var dreamGiftImage: UIImageView!
    @IBOutlet var dreamGiftName: UILabel!
    @IBOutlet var createdDate: UILabel!
    @IBOutlet var desiredDate: UILabel!
    @IBOutlet var pointsRequired: UILabel!
    @IBOutlet var redeemablePointsAsOnToday: UILabel!
    @IBOutlet var possibleDate1: UILabel!
    @IBOutlet var possibleDate2: UILabel!
    @IBOutlet var possibledate3: UILabel!
    @IBOutlet var avgPoints1: UILabel!
    @IBOutlet var avgPoints2: UILabel!
    @IBOutlet var avgPoints3: UILabel!
    @IBOutlet weak var dreamGiftType: UILabel!
    @IBOutlet weak var redeemBTN: UIButton!
    @IBOutlet weak var messageView: GradientView!
    @IBOutlet weak var giftDetailsView: UIView!
    @IBOutlet weak var avgPointsTitleLbl: UILabel!
    @IBOutlet weak var expectedRedemption: UILabel!
    
    @IBOutlet weak var tdsPts: UILabel!
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var existingDate: UILabel!
    @IBOutlet weak var expireDate: UILabel!
    @IBOutlet weak var ptsRequired: UILabel!
    @IBOutlet weak var removeBTN: UIButton!
    var giftType = ""
    var giftImage = ""
    var giftName = ""
    var addedDate = ""
    var tdsvalue = 0.0
    var expiredDate = ""
    var pointsRequires = ""
    var pointsBalance = 0
    var avgEarningPoints = ""
    var selectedDreamGiftId = ""
    var dreamGiftRedemptionId = 0
    var selectedGiftStatusID = 0
    var isRedeemable = 0
    var totalPts = 0
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var contractorName = ""
    var VM = DreamGiftDetailsViewModel()
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var isRedeemableStatus = UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable")
    override func viewDidLoad() {
        super.viewDidLoad()
        giftDetailsAPi()
        languagelocalization()
        print(isRedeemable,"redeemPoints")
        self.dreamGiftType.roundCorners(corners: [.topLeft, .bottomRight], radius: 20)
        self.avgPointsTitleLbl.roundCorners(corners: .topLeft, radius: 8)
        self.expectedRedemption.roundCorners(corners: .bottomLeft, radius: 8)
        self.avgPoints3.roundCorners(corners: .topRight, radius: 8)
        self.possibledate3.roundCorners(corners: .bottomRight, radius: 8)
        self.dreamGiftType.text = giftType
        self.dreamGiftName.text = giftName
        self.createdDate.text = addedDate
        self.desiredDate.text = expiredDate
        self.tdspopints.text = "\(tdsvalue)"
        self.pointsRequired.text = pointsRequires
        print(selectedDreamGiftId, "Dream Gift ID")
//        removeDreamGiftDetails
        NotificationCenter.default.addObserver(self, selector: #selector(removeGiftDetails), name: Notification.Name.removeDreamGiftDetails, object: nil)
        let receivedImage = giftImage
              print(receivedImage)
              let totalImgURL = productCatalogueImgURL + receivedImage
        dreamGiftImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "backgroundImage 1"))
//        //if pointsBalance <= ((Int(pointsRequires) ?? 0) + Int(self.tdsvalue)){
//        if ((Int(pointsRequires) ?? 0) + Int(tdsvalue)) <= Int(pointsBalance){
//            print(pointsRequired,"pointsRequired")
//            print(pointsBalance,"PointBalance")
//            print(tdsvalue,"TDs")
//            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                self.dreamGiftMessage.text = "Congratulations! you are eligible to win this existing Dream Gift"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                self.dreamGiftMessage.text = "बधाई! इस मौजूदा ड्रीम गिफ्ट को जीतने के लिए आप लगभग करीब हैं।"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                self.dreamGiftMessage.text = "অভিনন্দন! আপনি এই বিদ্যমান ড্রিম গিফট জেতার প্রায় কাছাকাছি।"
//            }else{
//                self.dreamGiftMessage.text = "అభినందనలు! ఇప్పటికే ఉన్న ఈ డ్రీమ్ గిఫ్ట్ గెలవడానికి మీరు దాదాపు దగ్గరలో ఉన్నారు."
//            }
//                self.redeemBTN.isEnabled = true
////            self.redeemBTN.backgroundColor = UIColor(red: 199/255, green: 34/255, blue: 4/255, alpha: 0.5)
//            self.redeemBTN.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
//
//
////        }else{
//            let points = ((Int(pointsRequires) ?? 0) + Int(self.tdsvalue))
//            print(pointsRequired,"pointsRequired")
//            print(pointsBalance,"PointBalance")
//            print(tdsvalue,"TDs")
//
//            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                    self.dreamGiftMessage.text = "Congratulations! You are almost near to win this existing Dream Gift."
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                    self.dreamGiftMessage.text = "बधाई! इस मौजूदा ड्रीम गिफ्ट को जीतने के लिए आप लगभग करीब हैं।"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                    self.dreamGiftMessage.text = "অভিনন্দন! আপনি এই বিদ্যমান ড্রিম গিফট জেতার প্রায় কাছাকাছি।"
//                }else{
//                    self.dreamGiftMessage.text = "అభినందనలు! ఇప్పటికే ఉన్న ఈ డ్రీమ్ గిఫ్ట్ గెలవడానికి మీరు దాదాపు దగ్గరలో ఉన్నారు."
//                }
//
//
//                self.redeemBTN.isEnabled = false
////            self.redeemBTN.backgroundColor = UIColor(red: 212/255, green: 74/255, blue: 35/255, alpha: 1.0)
//            redeemBTN.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
//        }
        
        if self.isRedeemable == 1{
            print(pointsRequired,"pointsRequired")
            print(pointsBalance,"PointBalance")
            print(tdsvalue,"TDs")
            self.dreamGiftMessage.text = "Congratulations! you are eligible to win this existing Dream Gift".localiz()
            
//            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                self.dreamGiftMessage.text = "Congratulations! you are eligible to win this existing Dream Gift"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                self.dreamGiftMessage.text = "बधाई! इस मौजूदा ड्रीम गिफ्ट को जीतने के लिए आप लगभग करीब हैं।"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                self.dreamGiftMessage.text = "অভিনন্দন! আপনি এই বিদ্যমান ড্রিম গিফট জেতার প্রায় কাছাকাছি।"
//            }else{
//                self.dreamGiftMessage.text = "అభినందనలు! ఇప్పటికే ఉన్న ఈ డ్రీమ్ గిఫ్ట్ గెలవడానికి మీరు దాదాపు దగ్గరలో ఉన్నారు."
//            }
                self.redeemBTN.isEnabled = true
            redeemBTN.backgroundColor = #colorLiteral(red: 0, green: 0.5832939148, blue: 0.2739756703, alpha: 1)
//            self.redeemBTN.backgroundColor = UIColor(red: 199/255, green: 34/255, blue: 4/255, alpha: 0.5)
            
        }else{
            self.dreamGiftMessage.text = "Congratulations! You are almost near to win this existing Dream Gift.".localiz()
            
//            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                self.dreamGiftMessage.text = "Congratulations! You are almost near to win this existing Dream Gift.".localiz()
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                    self.dreamGiftMessage.text = "बधाई! इस मौजूदा ड्रीम गिफ्ट को जीतने के लिए आप लगभग करीब हैं।"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                    self.dreamGiftMessage.text = "অভিনন্দন! আপনি এই বিদ্যমান ড্রিম গিফট জেতার প্রায় কাছাকাছি।"
//                }else{
//                    self.dreamGiftMessage.text = "అభినందనలు! ఇప్పటికే ఉన్న ఈ డ్రీమ్ గిఫ్ట్ గెలవడానికి మీరు దాదాపు దగ్గరలో ఉన్నారు."
//                }


                self.redeemBTN.isEnabled = false
//            self.redeemBTN.backgroundColor = UIColor(red: 212/255, green: 74/255, blue: 35/255, alpha: 1.0)
            self.redeemBTN.backgroundColor = .lightGray
        }
       

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Dream Gift Details")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    @objc func removeGiftDetails(){
        self.navigationController?.popViewController(animated: true)
    }
    func languagelocalization(){
        
        self.redeemablePointsAsOnToday.text = "\("Redeemable points as on today".localiz()) \(pointsBalance)"
        self.header.text = "Dream Gift Details".localiz()
        self.existingDate.text = "CreatedDateKey".localiz()
        self.expireDate.text = "DesiredDateKEY".localiz()
        self.ptsRequired.text = "Points Required".localiz()
        self.avgPointsTitleLbl.text = "mdgAveragepointsToBeEarnedPerMonthKEY".localiz()
        self.expectedRedemption.text = "Expected Redemption".localiz()
        self.redeemBTN.setTitle("Redeem Now".localiz(), for: .normal)
        self.removeBTN.setTitle("Remove".localiz(), for: .normal)
        self.tdsPts.text = "tdsPts".localiz()
        
        
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//
//            self.redeemablePointsAsOnToday.text = "Redeemable points as on today \(pointsBalance)"
//            self.header.text = "Dream Gift Details"
//            self.existingDate.text = "Created Date"
//            self.expireDate.text = "Desired Date"
//            self.ptsRequired.text = "Points Required"
//            self.avgPointsTitleLbl.text = "Average points to be earned per month"
//            self.expectedRedemption.text = "Expected Redemption"
//            self.redeemBTN.setTitle("Redeem Now", for: .normal)
//            self.removeBTN.setTitle("Remove", for: .normal)
//            self.tdsPts.text = "TDS points"
//
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.redeemablePointsAsOnToday.text = "आज के रूप में सम्मानजनक बिंदु \(pointsBalance)"
//            self.header.text = "ड्रीम उपहार विवरण"
//            self.existingDate.text = "रचना तिथि"
//            self.expireDate.text = "वांछित तारीख"
//            self.ptsRequired.text = "आवश्यक अंक"
//            self.avgPointsTitleLbl.text = "प्रति माह अर्जित किए जाने वाले औसत अंक"
//            self.expectedRedemption.text = "अपेक्षित मोचन"
//            self.redeemBTN.setTitle("अब एवज करें", for: .normal)
//            self.removeBTN.setTitle("हटाना", for: .normal)
//            self.tdsPts.text = "टीडीएस अंक"
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.redeemablePointsAsOnToday.text = "இன்று வரை பெறக்கூடிய புள்ளிகள் \(pointsBalance)"
//            self.header.text = "கனவு பரிசு விவரங்கள்"
//            self.existingDate.text = "உருவாக்கப்பட்ட தேதி"
//            self.expireDate.text = "விரும்பிய தேதி"
//            self.ptsRequired.text = "தேவையான புள்ளிகள்"
//            self.avgPointsTitleLbl.text = "ஒரு மாதத்திற்கு சராசரி புள்ளிகளைப் பெற வேண்டும்"
//            self.expectedRedemption.text = "எதிர்பார்க்கப்படும் மீட்பு"
//            self.redeemBTN.setTitle("இப்போது மீட்டுக்கொள்ளவும்", for: .normal)
//            self.removeBTN.setTitle("அகற்று", for: .normal)
//            self.tdsPts.text = "TDS புள்ளிகள்"
//
//        }else{
//            self.redeemablePointsAsOnToday.text = "ఈ రోజు నాటికి రీడిమబల్ పాయింట్ \(pointsBalance)"
//            self.header.text = "డ్రీం గిఫ్ట్ వివరాలు"
//            self.existingDate.text = "సృష్టించిన తేదీ"
//            self.expireDate.text = "కోరుకున్న తేదీ"
//            self.ptsRequired.text = "పాయింట్లు అవసరం"
//            self.avgPointsTitleLbl.text = "నెలకు సగటు పాయింట్లు సంపాదించాలి"
//            self.expectedRedemption.text = "ఆశించిన విముక్తి"
//            self.redeemBTN.setTitle("ఇప్పుడే రీడీమ్ చేయండి", for: .normal)
//            self.removeBTN.setTitle("తొలగించు", for: .normal)
//            self.tdsPts.text = "TDS పాయింట్లు"
//        }
    }
    
    func giftDetailsAPi(){
        
        let parameters = [
            "ActionType": "243",
            "ActorId": "\(userID)",
            "DreamGiftId": "\(selectedDreamGiftId)",
            "LoyaltyId": "\(loyaltyId)"
        ] as [String: Any]
        print(parameters)
        self.VM.myDreamGiftDetails(parameters: parameters) { response in
            //print(response?.lstDreamGift?[0].earlyExpectedDate ?? "")
            if self.VM.myDreamGiftDetailsArray.count > 0 {
                self.avgPoints1.text = "\(response?.lstDreamGift?[0].avgEarningPoints ?? 0)"
                self.avgPoints2.text = "\(response?.lstDreamGift?[0].earlyExpectedPoints ?? 0)"
                self.avgPoints3.text = "\(response?.lstDreamGift?[0].lateExpectedPoints ?? 0)"
                self.possibleDate1.text = "\(response?.lstDreamGift?[0].lateExpectedDate ?? "")"
                self.possibleDate2.text = "\(response?.lstDreamGift?[0].earlyExpectedDate ?? "")"
                self.possibledate3.text = "\(response?.lstDreamGift?[0].lateExpectedDate ?? "")"
            }
        }
    }
    
    @IBAction func redeemNowButton(_ sender: Any) {
        if self.verifiedStatus == 6 || self.verifiedStatus == 4{
            if self.checkAccountStatus == "1"{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }else{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }
            
        }else if self.verifiedStatus == 1{
            if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == -3{
                self.view.makeToast("Your PAN Details are pending,Please contact your administrator!".localiz(), duration: 2.0, position: .bottom)
            }else if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == -4{
                self.view.makeToast("Your PAN Details are rejected,Please contact your administrator!".localiz(), duration: 2.0, position: .bottom)
            }else if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == 1{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShippingAddress_VC") as! ShippingAddress_VC
                vc.redemptionTypeId = 3
                //vc.totalPoints = Int(pointsRequires) ?? 0
                vc.totalPoint = ((Int(pointsRequires) ?? 0) + Int(self.tdsvalue))
                vc.dreamGiftID = Int(selectedDreamGiftId) ?? 0
                vc.giftName = giftName
                vc.contractorName = contractorName
                vc.giftStatusId = selectedGiftStatusID
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.view.makeToast("Insufficient point balance to redeem!".localiz(), duration: 2.0, position: .bottom)
            }
  
        }
        
       
    }
    
    @IBAction func removeButton(_ sender: Any) {
        removeDreamGift()
    }
    
    func removeDreamGift(){
        let parameters = [
                "ActionType": 4,
                "ActorId": "\(userID)",
                "DreamGiftId": "\(selectedDreamGiftId)",
                "GiftStatusId": 4
        ] as [String: Any]
        print(parameters)
        self.VM.removeDreamGift(parameters: parameters) { response in
            let result = response?.returnValue ?? 0
            print(result)
            if result == 1 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "DreamGiftDetails"
                    vc!.descriptionInfo = "Dream Gift has been removed successfully".localiz()
//
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Dream Gift has been removed successfully".localiz()
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "ड्रीम गिफ्ट सफलतापूर्वक हटा दिया गया है"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "স্বপ্ন উপহার সফলভাবে সরানো হয়েছে"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "డ్రీమ్ గిఫ్ట్ విజయవంతంగా తీసివేయబడింది"
//                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
                
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "DreamGiftDetails"
                    vc!.descriptionInfo = "Dream Gift has been removed failed".localiz()
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Dream Gift has been removed failed"
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "ड्रीम गिफ्ट को हटा दिया गया है विफल"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "ড্রিম গিফট ব্যর্থ হয়েছে"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "డ్రీమ్ గిఫ్ట్ తీసివేయబడింది విఫలమైంది"
//                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
    
  
    
    
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
