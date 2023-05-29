//
//  DashBoardViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import SlideMenuControllerSwift
import ImageSlideshow
import Alamofire
import CoreData
import LanguageManager_iOS
import Firebase
import AVFoundation
import KSImageCarousel
import Lottie

class DashBoardViewController: BaseViewController, popUpDelegate, PopUpDelegate {
    func popUpAlertDidTap2(_ vc: PopUp2ViewController) {}
    

    @IBOutlet var bannerView: ImageSlideshow!
    @IBOutlet var pointsView: UIView!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var tierView: UIView!
    @IBOutlet var tierNameLabel: UILabel!
    @IBOutlet var tierImageView: UIImageView!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var redemptionCatalogue: UILabel!
    @IBOutlet weak var myredemptions: UILabel!
    @IBOutlet weak var lodgequery: UILabel!
    @IBOutlet weak var helplinecall: UILabel!
    @IBOutlet weak var dreamGift: UILabel!
    @IBOutlet weak var eWarranty: UILabel!
    @IBOutlet weak var maintenanceLbl: UILabel!
    @IBOutlet weak var maintenanceView: UIView!
    @IBOutlet weak var scanAndUploadImg: UIImageView!
    @IBOutlet weak var panDeatilsl: UILabel!
    
    
    
    let pageIndicator = UIPageControl()
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    
    var vm = DashBoardViewModel()
    var sourceArray = [AlamofireSource]()
    var isActive = true
    var isCalled = false
    var bannerImagesArray = [ObjImageGalleryList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        self.bannerImagesAPI()
        NotificationCenter.default.addObserver(self, selector: #selector(checkVerificationStatus), name: Notification.Name.verificationStatus, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deactivateAccount), name: Notification.Name.deactivatedAcc, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(codeStatus), name: Notification.Name.optionView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkUserStatus), name: Notification.Name.userIsActive, object: nil)
        NotificationCenter.default.addObserver(self,
                                       selector: #selector(refreshlanguageValues),
                                       name:NSNotification.Name(rawValue: "languagerefreshRequired"),
                                       object: nil)
        
    }
    @IBAction func pandetailsButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PancardViewController") as! PancardViewController
        vc.iscomefrom = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillLayoutSubviews() {
        self.pointsView.layer.cornerRadius = self.pointsView.frame.size.height / 2
        self.tierView.layer.cornerRadius = self.tierView.frame.size.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.maintenanceAPI()
        self.isUpdateAvailable()
        self.slideMenuController()?.closeLeft()
        pageIndicator.currentPageIndicatorTintColor = UIColor.red
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        bannerView.pageIndicator = pageIndicator
        languageLocalization()
        maintenanceView.isHidden = true
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Dashboard")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

    }
  
    override func viewDidLayoutSubviews() {
        slideMenuController()?.changeLeftViewWidth(self.view.frame.size.width * 0.87)
        SlideMenuOptions.contentViewScale = 1
    }
    
    @objc func refreshlanguageValues(){
        self.languageLocalization()
        self.dashboardAPI()
    }
    @objc func checkUserStatus(){
        self.userStatusApi()
    }
    @objc func deactivateAccount(){
        UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
        clearTable()
        clearTable1()
        clearTable2()
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setInitialViewAsRootViewController()
            }
        }
    }
    
    @objc func checkVerificationStatus(){
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
            vc!.delegate = self
            vc!.titleInfo = ""
            vc!.itsComeFrom = "AccountVerification"
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
             }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                 vc!.descriptionInfo = "आपको रिडीम करने की अनुमति नहीं है। कृपया अपने व्यवस्थापक से संपर्क करें"
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                vc!.descriptionInfo = "আপনি রিডিম করতে পারবেন না। অনুগ্রহ করে আপনার প্রশাসকের সাথে যোগাযোগ করুন"
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                vc!.descriptionInfo = "రీడీమ్ చేసుకోవడానికి మీకు అనుమతి లేదు .దయచేసి మీ నిర్వాహకుడిని సంప్రదించండి"
              }
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func notification(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryNotificationsViewController") as! HistoryNotificationsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func languageChange(_ sender: Any) {
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboardLanguagePopUpVC") as? DashboardLanguagePopUpVC
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
    }
    @IBAction func sideMenuButton(_ sender: Any) {
        self.openLeft()
    }
    @IBAction func redemptionCatalogue(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionCatalogueVC") as! RedemptionCatalogueVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func myRedemption(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyRedemptionsListViewController") as! MyRedemptionsListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func lodgeQuery(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerQueryListingViewController") as! CustomerQueryListingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func helplineCall(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelplineViewController") as! HelplineViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func dreamGift(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DreamGiftListingViewController") as! DreamGiftListingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func scanQRCode(_ sender: Any) {
//        if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "0" == "5" && UserDefaults.standard.string(forKey: "QRCode") ?? "0" == "1"{
//            DispatchQueue.main.async{
////                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
////                vc!.delegate = self
////                vc!.titleInfo = ""
////                vc!.descriptionInfo = "Your daily uploading limit exceeded"
////                vc!.modalPresentationStyle = .overCurrentContext
////                vc!.modalTransitionStyle = .crossDissolve
////                self.present(vc!, animated: true, completion: nil)
//            }
//            return
//
//     }else{
//         if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
//             DispatchQueue.main.async {
//                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CP_Scanner_VC") as? CP_Scanner_VC
//                 vc?.selectedindex = 1
//                 self.navigationController?.pushViewController(vc!, animated: true)
//             }
//         } else {
//             DispatchQueue.main.async {
//                 AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
//                     if granted == true {
//                         DispatchQueue.main.async{
//                             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CP_Scanner_VC") as? CP_Scanner_VC
//                            vc?.selectedindex = 1
//                             self.navigationController?.pushViewController(vc!, animated: true)
//                         }
//                     } else {
//                         DispatchQueue.main.async{
//                             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CP_NeedCameraAccess_VC") as? CP_NeedCameraAccess_VC
//                             vc?.selectedindex = 1
//                             self.navigationController?.pushViewController(vc!, animated: true)
//                         }
//                     }
//                 })
//             }
//         }
//    }
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
        vc.itsFrom = "ScanCode"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func uploadCode(_ sender: Any) {
//        print(UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "0")
//        print(UserDefaults.standard.string(forKey: "QRCode") ?? "6")
//
//        if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "0" == "5" && UserDefaults.standard.string(forKey: "QRCode") ?? "0" == "1"{
//            DispatchQueue.main.async{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
//                vc!.delegate = self
//                vc!.titleInfo = ""
//                vc!.descriptionInfo = "Your daily uploading limit exceeded"
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//            return
//
//     }else{
//         if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
//             DispatchQueue.main.async {
//                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CP_Scanner_VC") as? CP_Scanner_VC
//                vc?.selectedindex = 2
//                 self.navigationController?.pushViewController(vc!, animated: true)
//             }
//         } else {
//             DispatchQueue.main.async {
//                 AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
//                     if granted == true {
//                         DispatchQueue.main.async{
//                             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CP_Scanner_VC") as? CP_Scanner_VC
//                             vc?.selectedindex = 2
//                             self.navigationController?.pushViewController(vc!, animated: true)
//                         }
//                     } else {
//                         DispatchQueue.main.async{
//                             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CP_NeedCameraAccess_VC") as? CP_NeedCameraAccess_VC
//                             vc?.selectedindex = 2
//                             self.navigationController?.pushViewController(vc!, animated: true)
//                         }
//                     }
//                 })
//             }}
//     }
        
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
        vc.itsFrom = "UploadCode"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
        
}
    @IBAction func generate_EWarrenty(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DownloadEWarrantyListViewController") as! DownloadEWarrantyListViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func languageLocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            points.text = "hpPointsKEY".localizableString(loc: "en");
            tierNameLabel.text = "hpTierKEY".localizableString(loc: "en");
            lodgequery.text = "Lodge Query"
            myredemptions.text = "My Redemption"
            helplinecall.text = "Helpline Call"
            redemptionCatalogue.text = "Redemption Catalogue"
            panDeatilsl.text = "Pan Details"
            dreamGift.text = "My Dream Gift"
            maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "en")
//            scanAndUploadImg.image = UIImage(named: "english")
            eWarranty.text = "E - Warranty"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            points.text = "hpPointsKEY".localizableString(loc: "hi");
            panDeatilsl.text = "panDetails".localizableString(loc: "hi")
            tierNameLabel.text = "hpTierKEY".localizableString(loc: "hi");
            lodgequery.text = "hpLodgeQueryKEY".localizableString(loc: "hi");
            myredemptions.text = "hpMyRedemptionsKEY".localizableString(loc: "hi");
            helplinecall.text = "hpHelpLineCallKEY".localizableString(loc: "hi");
            redemptionCatalogue.text = "hpRedemptionCatalogueKEY".localizableString(loc: "hi");
            dreamGift.text = "माई ड्रीम गिफ्ट"
            maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "hi")
//            scanAndUploadImg.image = UIImage(named: "hindi")
            eWarranty.text = "ई - वारंटी"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            points.text = "hpPointsKEY".localizableString(loc: "bn");
            panDeatilsl.text = "panDetails".localizableString(loc: "bn")
            tierNameLabel.text = "hpTierKEY".localizableString(loc: "bn");
            lodgequery.text = "hpLodgeQueryKEY".localizableString(loc: "bn");
            myredemptions.text = "hpMyRedemptionsKEY".localizableString(loc: "bn");
            helplinecall.text = "hpHelpLineCallKEY".localizableString(loc: "bn");
            redemptionCatalogue.text = "hpRedemptionCatalogueKEY".localizableString(loc: "bn");
            dreamGift.text = "আমার স্বপ্নের উপহার"
            maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "bn")
//            scanAndUploadImg.image = UIImage(named: "bengali")
            eWarranty.text = "ই - ওয়ারেন্টি"
        }else{
            points.text = "hpPointsKEY".localizableString(loc: "te");
            panDeatilsl.text = "panDetails".localizableString(loc: "te")
            tierNameLabel.text = "hpTierKEY".localizableString(loc: "te");
            lodgequery.text = "hpLodgeQueryKEY".localizableString(loc: "te");
            myredemptions.text = "hpMyRedemptionsKEY".localizableString(loc: "te");
            helplinecall.text = "hpHelpLineCallKEY".localizableString(loc: "te");
            redemptionCatalogue.text = "hpRedemptionCatalogueKEY".localizableString(loc: "te");
            dreamGift.text = "నా డ్రీమ్ గిఫ్ట్"
            maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "te")
//            scanAndUploadImg.image = UIImage(named: "telugu")
            eWarranty.text = "ఇ - వారంటీ"
        }
    }
    
    func ImageSetups(){
        sourceArray.removeAll()
        if bannerImagesArray.count > 0 {
            for image in bannerImagesArray {
                
                let filterImage = (image.imageGalleryUrl ?? "").dropFirst()
                let images = ("\(PROMO_IMG)\(filterImage)").replacingOccurrences(of: " ", with: "%20")
                
                sourceArray.append(AlamofireSource(urlString: images, placeholder: UIImage(named: "backgroundImage"))!)
            }
            bannerView.setImageInputs(sourceArray)
            bannerView.slideshowInterval = 3.0
            bannerView.zoomEnabled = false
        } else {
//            bannerDefaultImage.isHidden = false
        }
    }
    
    @objc func codeStatus(notification: Notification){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeSubmissionPopUp") as! CodeSubmissionPopUp
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func didTap() {
        if bannerImagesArray.count > 0 {
            bannerView.presentFullScreenController(from: self)
        }
    }
    
    
    //Delegate: -
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
        if vc.itsComeFrom == "AccountVerification"{
            
        }else if isActive == true {
            UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
            DispatchQueue.main.async {
                if #available(iOS 13.0, *) {
                    let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
                    sceneDelegate.setInitialViewAsRootViewController()
                } else {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.setInitialViewAsRootViewController()
                }
            }
        }
    }
    
    
    // Api:-
    
    func bannerImagesAPI() {
        let parameters : [String : Any] = ["ObjImageGallery":["AlbumCategoryID":"1"]]
        print(parameters)
        self.vm.dashboardImagesAPICall(parameters: parameters) { response in
            self.bannerImagesArray = response?.objImageGalleryList ?? []
            self.ImageSetups()
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTap))
            self.bannerView.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    func dashboardAPI() {
        let parameters : [String : Any] = [
            "ActorId":"\(userID)"
        ]
        print(parameters)
        self.vm.dashboardAPICall(parameters: parameters) { response in
            if response?.activeStatus == false {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    self.isActive = false
                    vc!.itsComeFrom = "DeactivateAccount"
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Your account is deactivated please check with the administrator"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "आपका खाता निष्क्रिय कर दिया गया है कृपया व्यवस्थापक से संपर्क करें"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "আপনার অ্যাকাউন্ট নিষ্ক্রিয় করা হয়েছে অনুগ্রহ করে প্রশাসকের সাথে চেক করুন৷"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "మీ ఖాతా నిష్క్రియం చేయబడింది, దయచేసి నిర్వాహకుడిని సంప్రదించండి"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            } else {
                DispatchQueue.main.async {
                    print(response?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? "")
                    UserDefaults.standard.setValue(response?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? "", forKey: "LoyaltyID")
                    UserDefaults.standard.setValue(response?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0, forKey: "RedeemablePointBalance")
                    UserDefaults.standard.setValue(response?.lstCustomerFeedBackJsonApi?[0].firstName, forKey: "FirstName")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].merchantMobile ?? "", forKey: "MerchantMobile")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].customerMobile ?? "", forKey: "CustomerMobile")
                    self.pointsLabel.text = String(response?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].merchantEmail ?? "", forKey: "MerchantEmail")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].customerEmail ?? "", forKey: "CustomerEmail")
                    UserDefaults.standard.set(response?.lstCustomerFeedBackJsonApi?[0].verifiedStatus ?? 0, forKey: "VerifiedStatus")
                    self.pointsLabel.text = String(response?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)
                    self.tierNameLabel.text = response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? ""
                    if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Bronze" {
                        self.tierImageView.image = UIImage(named: "grade1")
                    } else if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Gold" {
                        self.tierImageView.image = UIImage(named: "grade2")
                    } else if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Silver" {
                        self.tierImageView.image = UIImage(named: "grade3")
                    } else {
                        self.tierImageView.image = UIImage(named: "grade3")
                    }
                    if response?.objCatalogueDetailsForCustomer?.count ?? 0 != 0 {
                        if self.isCalled == false {
                            DispatchQueue.main.async{
                                self.isCalled = true
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DreamGiftPopUpViewController") as? DreamGiftPopUpViewController
                                vc!.dreamGiftArray = response?.objCatalogueDetailsForCustomer ?? []
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
                        }
                    }
                    self.stopLoading()
                }
            }
        }
    }
    
    //Check user is Active or not
    
    func userStatusApi(){
        let parameters = [
            "userid": "\(userID)"
        ] as [String: Any]
        print(parameters)
        self.vm.userStatus(parameters: parameters) { response in
            if response?.isActive == false {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "DeactivateAccount"
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Your account is deactivated please check with the administrator"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "आपका खाता निष्क्रिय कर दिया गया है कृपया व्यवस्थापक से संपर्क करें"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "আপনার অ্যাকাউন্ট নিষ্ক্রিয় করা হয়েছে অনুগ্রহ করে প্রশাসকের সাথে চেক করুন৷"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "మీ ఖాతా నిష్క్రియం చేయబడింది, దయచేసి నిర్వాహకుడిని సంప్రదించండి"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            }else{
                DispatchQueue.main.async {
                    self.stopLoading()
                    self.bannerImagesAPI()
                    self.languageLocalization()
                    self.dashboardAPI()
                    self.maintenanceAPI()
                    self.isUpdateAvailable()
                }
            }
        
        }
        
    }
    
    func isUpdateAvailable() {
        let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
        print(bundleId)
        Alamofire.request("https://itunes.apple.com/in/lookup?bundleId=\(bundleId)").responseJSON { response in
            if let json = response.result.value as? NSDictionary, let results = json["results"] as? NSArray, let entry = results.firstObject as? NSDictionary, let appStoreVersion = entry["version"] as? String,let appstoreid = entry["trackId"], let trackUrl = entry["trackViewUrl"], let installedVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                let installed = Int(installedVersion.replacingOccurrences(of: ".", with: "")) ?? 0
                print(installed)
                let appStore = Int(appStoreVersion.replacingOccurrences(of: ".", with: "")) ?? 0
                print(appStore)
                print(appstoreid)
                if appStore>installed {
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        let alertController = UIAlertController(title: "New update Available!", message: "Update is available to download. Downloading the latest update you will get the latest features, improvements and bug fixes of Century Pro Club App", preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "Update Now", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.openURL(NSURL(string: "\(trackUrl)")! as URL)
                            
                        }
                        //                     Add the actions
                        alertController.addAction(okAction)
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                        let alertController = UIAlertController(title: "नया अद्यतन उपलब्ध!", message: "अपडेट डाउनलोड करने के लिए उपलब्ध है। नवीनतम अपडेट को डाउनलोड करने पर आपको सेंचुरी प्रो क्लब ऐप की नवीनतम सुविधाएं, सुधार और बग फिक्स मिलेंगे", preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "अभी अद्यतन करें", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.openURL(NSURL(string: "\(trackUrl)")! as URL)
                            
                        }
                        //                     Add the actions
                        alertController.addAction(okAction)
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        let alertController = UIAlertController(title: "নতুন আপডেট উপলব্ধ!", message: "আপডেট ডাউনলোড করার জন্য উপলব্ধ. সর্বশেষ আপডেট ডাউনলোড করলে আপনি সেঞ্চুরি প্রো ক্লাব অ্যাপের সর্বশেষ বৈশিষ্ট্য, উন্নতি এবং বাগ ফিক্স পাবেন", preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "এখন হালনাগাদ করুন", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.openURL(NSURL(string: "\(trackUrl)")! as URL)
                            
                        }
                        //                     Add the actions
                        alertController.addAction(okAction)
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                    }else{
                        let alertController = UIAlertController(title: "క్రొత్త నవీకరణ అందుబాటులో ఉంది!", message: "డౌన్‌లోడ్ చేసుకోవడానికి అప్‌డేట్ అందుబాటులో ఉంది. తాజా అప్‌డేట్‌ను డౌన్‌లోడ్ చేయడం ద్వారా మీరు సెంచరీ ప్రో క్లబ్ యాప్ యొక్క తాజా ఫీచర్‌లు, మెరుగుదలలు మరియు బగ్ పరిష్కారాలను పొందుతారు", preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "ఇప్పుడే నవీకరించండి", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.openURL(NSURL(string: "\(trackUrl)")! as URL)
                            
                        }
                        //                     Add the actions
                        alertController.addAction(okAction)
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                    }
                       
                }else{
                    print("no updates")
                    
                }
            }
        }
    }
    
    func maintenanceAPI(){
        guard let url = URL(string: "http://appupdate.arokiait.com/updates/serviceget?pid=com.centuryproclub.customer") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                  error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                                                        dataResponse, options: [])
                print(jsonResponse)
                let isMaintenanceValue = ((jsonResponse as AnyObject).value(forKeyPath: "Result.is_maintenance") as? String)!
                let forceupdatevalue = ((jsonResponse as AnyObject).value(forKeyPath: "Result.version_number") as? String)!
                print(isMaintenanceValue)
                if isMaintenanceValue == "1"{
                    print(isMaintenanceValue)
                    DispatchQueue.main.async {
                        self.stopLoading()
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            self.maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "en")
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            self.maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "hi")
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            self.maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "bn")
                        }else{
                            self.maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "te")
                        }
                        self.maintenanceView.isHidden = false
                    }
                }else if isMaintenanceValue == "0"{
                    print(isMaintenanceValue)
                    DispatchQueue.main.async {
                        self.maintenanceView.isHidden = true
                        self.dashboardAPI()
                    }
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    func clearTable(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ScanCodeSTORE")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    func clearTable1(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UploadedCodes")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    func clearTable2(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SendUploadedCodes")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    
}
