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
import Photos
import CoreLocation

class DashBoardViewController: BaseViewController, popUpDelegate, PopUpDelegate ,CLLocationManagerDelegate{
    func popUpAlertDidTap2(_ vc: PopUp2ViewController) {}
    

    @IBOutlet weak var uploadQrCodeLbl: UILabel!
    @IBOutlet weak var scanQrCodeLbl: UILabel!
    @IBOutlet var bannerView: ImageSlideshow!
    @IBOutlet var pointsView: UIView!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var tierView: UIView!
    @IBOutlet var tierNameLabel: UILabel!
    @IBOutlet var tierImageView: UIImageView!
    @IBOutlet weak var points: UILabel!
//    @IBOutlet weak var redemptionCatalogue: UILabel!
//    @IBOutlet weak var myredemptions: UILabel!
//    @IBOutlet weak var lodgequery: UILabel!
//    @IBOutlet weak var helplinecall: UILabel!
//    @IBOutlet weak var dreamGift: UILabel!
//    @IBOutlet weak var eWarranty: UILabel!
    
    @IBOutlet weak var riseTicketBtn: GradientButton!
    @IBOutlet weak var riseAticketTitleLbl: UILabel!
    @IBOutlet weak var askHelpTitleLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var statusMessagaeLbl: UILabel!
    
    @IBOutlet weak var memberhipIdHeadingLbl: UILabel!
    
    @IBOutlet weak var membershipIDDataLbl: UILabel!
    
    @IBOutlet weak var pointBalanceDataLbl: UILabel!
    
    @IBOutlet weak var pointBalanceHeadingLbl: UILabel!
    @IBOutlet weak var maintenanceLbl: UILabel!
    @IBOutlet weak var maintenanceView: UIView!
//    @IBOutlet weak var scanAndUploadImg: UIImageView!
    @IBOutlet weak var panDeatilsl: UILabel!
    
    @IBOutlet weak var collectionViewScrollData: UICollectionView!
    
    
    let pageIndicator = UIPageControl()
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    var reachability = Reach()
    var vm = DashBoardViewModel()
    var sourceArray = [AlamofireSource]()
    var isActive = true
    var isCalled = false
    var bannerImagesArray = [ObjImageGalleryList]()
    var dashboardCatagoryImage = ["Earn_Points","Group 8890","Group 5335","Group 5908","question-circle 2","__TEMP__SVG__ 1"]
    var dashboardCatagoryContentArray = ["meMyEarning","My Redemptions","rcRedemptionCatalogueKEY","EWarranty"]
    
    var timers = Timer()
    
    var latitude = ""
    var longitude = ""
    var internetPushMessage = ""
    var locationManager = CLLocationManager()
    var currentlocation:CLLocation!
    var parameterJSON:JSON?
    var newproductArray: [[String:Any]] = []
    var savedCodeListArray = [QRCodeSaveResponseList]()
    var uploadedCodes:Array = [UploadedCodes]()
    var sendScannedCodes:Array = [SendUploadedCodes]()
    var codeLIST:Array = [ScanCodeSTORE]()
    
    var addressString : String = ""
    var country = ""
    var city = ""
    var address = ""
    var pincode = ""
    var loyaltyIDData = ""{
        didSet
        {
            if loyaltyIDData != ""{
                self.fetchDetails2()
                self.fetchDetails()
            }
        }
    }
    var reachability1: ReachabilityAutoSync?
    lazy var picker = UIImagePickerController()
    var strdata1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        picker.delegate = self
        riseTicketBtn.semanticContentAttribute = .forceRightToLeft
        self.collectionViewScrollData.delegate = self
        self.collectionViewScrollData.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkVerificationStatus), name: Notification.Name.verificationStatus, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deactivateAccount), name: Notification.Name.deactivatedAcc, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(codeStatus), name: Notification.Name.optionView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkUserStatus), name: Notification.Name.userIsActive, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(refreshlanguageValues),name:NSNotification.Name(rawValue: "languagerefreshRequired"),object: nil)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
  
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let collectionViewFLowLayout = UICollectionViewFlowLayout()
        collectionViewFLowLayout.itemSize = CGSize(width: CGFloat((self.collectionViewScrollData.frame.width / 4) - 2.5), height: 110)
        collectionViewFLowLayout.minimumLineSpacing = 2.5
        collectionViewFLowLayout.minimumInteritemSpacing = 2.5
         self.collectionViewScrollData.collectionViewLayout = collectionViewFLowLayout
        profileImage.layer.cornerRadius = (profileImage.frame.height / 2)
    }
    
    
    @IBAction func didTappedProfileUpdate(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    
    @IBAction func pandetailsButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PancardViewController") as! PancardViewController
        vc.iscomefrom = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    override func viewWillLayoutSubviews() {
//        self.pointsView.layer.cornerRadius = self.pointsView.frame.size.height / 2
//        self.tierView.layer.cornerRadius = self.tierView.frame.size.height / 2
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if MyCommonFunctionalUtilities.isInternetCallTheApi() != false{
////            self.maintenanceAPI()
////            self.isUpdateAvailable()
////            if sourceArray.isEmpty {
////                self.bannerImagesAPI()
////            }
//        }
        reachability1 = try? ReachabilityAutoSync()
        startMonitoringReachability()
        self.slideMenuController()?.closeLeft()
        pageIndicator.currentPageIndicatorTintColor = UIColor.red
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        bannerView.pageIndicator = pageIndicator
        languageLocalization()
        maintenanceView.isHidden = true
        self.locationManager.startUpdatingLocation()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Dashboard")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    
    deinit{
        reachability1?.stopNotifier()
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
            vc!.descriptionInfo = "NotAllowedRedeemKey".localiz()
//            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                vc!.descriptionInfo = "You are not allowled to redeem .Please contact your administrator"
//             }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                 vc!.descriptionInfo = "आपको रिडीम करने की अनुमति नहीं है। कृपया अपने व्यवस्थापक से संपर्क करें"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                vc!.descriptionInfo = "ரிடீம் செய்ய உங்களுக்கு அனுமதி இல்லை .தயவுசெய்து உங்கள் நிர்வாகியைத் தொடர்பு கொள்ளவும்"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                vc!.descriptionInfo = "రీడీమ్ చేసుకోవడానికి మీకు అనుమతి లేదు .దయచేసి మీ నిర్వాహకుడిని సంప్రదించండి"
//              }
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTappedRiseTicketBtn(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerQueryListingViewController") as! CustomerQueryListingViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    @IBAction func notification(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HistoryNotificationsViewController") as! HistoryNotificationsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
        riseTicketBtn.setTitle("Raise a Ticket".localiz(), for: .normal)
        riseAticketTitleLbl.text = "Raise a ticket our team will connect you soon".localiz()
        askHelpTitleLbl.text = "Ask Help ?".localiz()
        collectionViewScrollData.reloadData()
        self.points.text = "hpPointsKEY".localizableString(loc: "en");
        self.tierNameLabel.text = "hpTierKEY".localizableString(loc: "en");
//        hpUploadCodeKEY
        scanQrCodeLbl.text =  "fcScanQRCodeKEY".localiz()
        memberhipIdHeadingLbl.text = "hpMembershipIDKEY".localiz()
        pointBalanceHeadingLbl.text = "Points Balance".localiz()
        uploadQrCodeLbl.text = "hpUploadCodeKEY".localiz()
//        self.lodgequery.text = "hpLodgeQueryKEY".localiz()
//        myredemptions.text = "hpMyRedemptionsKEY".localiz()
//        helplinecall.text = "hpHelpLineCallKEY".localiz()
//        self.redemptionCatalogue.text = "rcRedemptionCatalogueKEY".localiz()
        self.panDeatilsl.text = "panDetails".localiz()
//        self.dreamGift.text = "mdgMyDreamGiftKEY".localiz()
        self.maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localiz()
//        scanAndUploadImg.image = UIImage(named: "Group 5912")
//        eWarranty.text = "EWarranty".localiz()
        
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            points.text = "hpPointsKEY".localizableString(loc: "en");
//            tierNameLabel.text = "hpTierKEY".localizableString(loc: "en");
//            lodgequery.text = "hpLodgeQueryKEY"
//            myredemptions.text = "hpMyRedemptionsKEY"
//            helplinecall.text = "hpHelpLineCallKEY"
//            redemptionCatalogue.text = "Redemption Catalogue"
//            panDeatilsl.text = "panDetails"
//            dreamGift.text = "mdgMyDreamGiftKEY"
//            maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "en")
//            scanAndUploadImg.image = UIImage(named: "Group 5912")
//            eWarranty.text = "EWarranty"
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            points.text = "hpPointsKEY".localizableString(loc: "hi");
//            panDeatilsl.text = "panDetails".localizableString(loc: "hi")
//            tierNameLabel.text = "hpTierKEY".localizableString(loc: "hi");
//            lodgequery.text = "hpLodgeQueryKEY".localizableString(loc: "hi");
//            myredemptions.text = "hpMyRedemptionsKEY".localizableString(loc: "hi");
//            helplinecall.text = "hpHelpLineCallKEY".localizableString(loc: "hi");
//            redemptionCatalogue.text = "hpRedemptionCatalogueKEY".localizableString(loc: "hi");
//            dreamGift.text = "माई ड्रीम गिफ्ट"
//            maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "hi")
//            scanAndUploadImg.image = UIImage(named: "Group 6556")
//            eWarranty.text = "ई - वारंटी"
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            points.text = "hpPointsKEY".localizableString(loc: "ta-IN");
//            panDeatilsl.text = "panDetails".localizableString(loc: "ta-IN")
//            tierNameLabel.text = "hpTierKEY".localizableString(loc: "ta-IN");
//            lodgequery.text = "hpLodgeQueryKEY".localizableString(loc: "ta-IN");
//            myredemptions.text = "hpMyRedemptionsKEY".localizableString(loc: "ta-IN");
//            helplinecall.text = "hpHelpLineCallKEY".localizableString(loc: "ta-IN");
//            redemptionCatalogue.text = "hpRedemptionCatalogueKEY".localizableString(loc: "ta-IN");
//            dreamGift.text = "என் கனவு பரிசு"
//            maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "ta-IN")
//            scanAndUploadImg.image = UIImage(named: "Group 6557")
//            eWarranty.text = "மின் - உத்தரவாதம்"
//        }else{
//            points.text = "hpPointsKEY".localizableString(loc: "te");
//            panDeatilsl.text = "panDetails".localizableString(loc: "te")
//            tierNameLabel.text = "hpTierKEY".localizableString(loc: "te");
//            lodgequery.text = "hpLodgeQueryKEY".localizableString(loc: "te");
//            myredemptions.text = "hpMyRedemptionsKEY".localizableString(loc: "te");
//            helplinecall.text = "hpHelpLineCallKEY".localizableString(loc: "te");
//            redemptionCatalogue.text = "hpRedemptionCatalogueKEY".localizableString(loc: "te");
//            dreamGift.text = "నా డ్రీమ్ గిఫ్ట్"
//            maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "te")
//            scanAndUploadImg.image = UIImage(named: "Group 6558")
//            eWarranty.text = "ఇ - వారంటీ"
//        }
    }
    
    func ImageSetups(){
        sourceArray.removeAll()
        if bannerImagesArray.count > 0 {
            for image in bannerImagesArray {
                
                let filterImage = (image.imageGalleryUrl ?? "").dropFirst()
                let images = ("\(PROMO_IMG)\(filterImage)").replacingOccurrences(of: " ", with: "%20")
                
                sourceArray.append(AlamofireSource(urlString: images, placeholder: UIImage(named: "backgroundImage"))!)
                bannerView.contentScaleMode = .scaleToFill
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
                    vc!.descriptionInfo = "account_deactivated_check_with_the_administrator".localiz()
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            } else {
                DispatchQueue.main.async {
                    print(response?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? "")
                    UserDefaults.standard.setValue(response?.lstCustomerFeedBackJsonApi?[0].customerTypeId ?? "-1", forKey: "CUSTTYPE")
                    print(response?.lstCustomerFeedBackJsonApi?[0].customerTypeId, "customer type id")
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
                    self.nameLbl.text = response?.lstCustomerFeedBackJsonApi?[0].firstName ?? ""
                    self.membershipIDDataLbl.text = response?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? ""
                    self.loyaltyIDData = response?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? ""
                    self.pointBalanceDataLbl.text = "  \(response?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)"
                    
                    if let image = response?.lstCustomerFeedBackJsonApi?[0].customerImage{
                        var customerImage = String(image)
                        if customerImage.first == "~"{
                            customerImage = String(customerImage.dropFirst())
                        }
                        if customerImage.contains("UploadFiles/CustomerImage"){
                            self.profileImage.sd_setImage(with: URL(string: customerImageURL + "\(customerImage)"), placeholderImage: UIImage(named: "icons8-test-account-96"))
                        }else{
                            self.profileImage.sd_setImage(with: URL(string: profileImageURL + "\(customerImage)"), placeholderImage: UIImage(named: "icons8-test-account-96"))
                        }
                    }else{
                        self.profileImage.image = UIImage(named: "icons8-test-account-96")
                    }
                    self.statusMessagaeLbl.text = response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "-"
//                    if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Bronze" {
//                        self.tierImageView.image = UIImage(named: "grade1")
//                        self.statusMessagaeLbl.text = "Bronze"
//                    } else if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Gold" {
//                        self.tierImageView.image = UIImage(named: "grade2")
//                        self.statusMessagaeLbl.text = "Gold"
//                    } else if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Silver" {
//                        self.tierImageView.image = UIImage(named: "grade3")
//                        self.statusMessagaeLbl.text = "Silver"
//                    } else {
//                        self.tierImageView.image = UIImage(named: "grade3")
//                    }
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
                    vc!.descriptionInfo = "account_deactivated_check_with_the_administrator".localiz()
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Your account is deactivated please check with the administrator"
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "आपका खाता निष्क्रिय कर दिया गया है कृपया व्यवस्थापक से संपर्क करें"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "உங்கள் கணக்கு செயலிழக்கப்பட்டது, நிர்வாகியுடன் சரிபார்க்கவும்"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "మీ ఖాతా నిష్క్రియం చేయబడింది, దయచేసి నిర్వాహకుడిని సంప్రదించండి"
//                      }
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
                    
                    let alertController = UIAlertController(title: "New update Available!".localiz(), message: "force update message".localiz(), preferredStyle: .alert)
                    
                    // Create the actions
                    let okAction = UIAlertAction(title: "Update Now".localiz(), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.openURL(NSURL(string: "\(trackUrl)")! as URL)
                        
                    }
                    //                     Add the actions
                    alertController.addAction(okAction)
                    // Present the controller
                    self.present(alertController, animated: true, completion: nil)
                       
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
                        self.maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localiz()
//                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                            self.maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localiz()
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                            self.maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "hi")
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                            self.maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "ta-IN")
//                        }else{
//                            self.maintenanceLbl.text = "hpTheAppISUnableToAccessTheServicesAsMaintenanceKEY".localizableString(loc: "te")
//                        }
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


extension DashBoardViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardCatagoryContentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectCell", for: indexPath) as! DashboardCollectCell
        cell.imageInCell.image = UIImage(named: self.dashboardCatagoryImage[indexPath.row])
        cell.messageCell.text = self.dashboardCatagoryContentArray[indexPath.row].localiz()
        return cell
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("JSGAGUSGs")
//
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            collectionview.deselectItem(at: indexPath, animated: true)
//     }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            if indexPath.item == 0{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyEarningsViewController") as! MyEarningsViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if indexPath.item == 1{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyRedemptionsListViewController") as! MyRedemptionsListViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if indexPath.item == 2{
                
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionCatalogueVC") as! RedemptionCatalogueVC
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if indexPath.item == 3{
                
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DownloadEWarrantyListViewController") as! DownloadEWarrantyListViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if indexPath.item == 4{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerQueryListingViewController") as! CustomerQueryListingViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.item == 5{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelplineViewController") as! HelplineViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelplineViewController") as! HelplineViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}

extension DashBoardViewController{
    func codesSubmission(){
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
//            self.dismiss(animated: true){
//                self.internetPushMessage = "Check Internet Connection"
//                self.fetchDetails()
//                self.dismiss(animated: true){
//                    NotificationCenter.default.post(name: .optionView, object: nil)
//                    self.scheduleNotification()
//                }
//
//            }
            
        }else{
        for item in self.codeLIST {
            let singleImageDict:[String:Any] = [
                "QRCode": item.code ?? "",
                "ScanType": 1,
                "Latitude": item.latitude ?? "",
                "Longitude": item.longitude ?? ""
            ]
            self.newproductArray.append(singleImageDict)
        }
        self.parameterJSON = [
            
            "Address": "\(self.addressString)",
            "City": "\(self.city)",
            "Country": "\(self.country)",
            "Latitude": "\(self.latitude)",
            "Longitude": "\(self.longitude)",
            "LoyaltyID": "\(loyaltyIDData)",
            "PinCode": "\(self.pincode)",
            "QRCodeSaveRequestList": self.newproductArray as [[String:Any]],
            "SourceType": "1",
            "State": ""
        ]
        print(self.parameterJSON ?? "")
            self.getAddressFromLatLon(pdblLatitude: String(self.latitude), withLongitude: String(self.longitude))
            return
    }
    }
    
    func fetchDetails(){
        
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{

            
        }else{
            self.codeLIST.removeAll()
            let fetchRequest:NSFetchRequest<ScanCodeSTORE> = ScanCodeSTORE.fetchRequest()
            do{
                self.codeLIST = try persistanceservice.context.fetch(fetchRequest)
                print(self.codeLIST.count, "Count")
                
                if self.codeLIST.count != 0{
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                        self.codesSubmission()
                    })
                }else{
                    print("Scan Code Data not found")
                }
                
            }catch{
                print("error while fetching data")
            }
        }
    }
    
    func fetchDetails2(){
        let fetchRequest:NSFetchRequest<UploadedCodes> = UploadedCodes.fetchRequest()
        do{
            self.uploadedCodes = try persistanceservice.context.fetch(fetchRequest)
            print(self.uploadedCodes.count)
            
        }catch{
            print("error while fetching data")
        }
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
                                        if (error != nil)
                                        {
                                            print("reverse geodcode fail: \(error!.localizedDescription)")
                                        }
                                        let pm = placemarks! as [CLPlacemark]
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            print(pm.country)
                                            print(pm.locality)
                                            print(pm.subLocality)
                                            print(pm.thoroughfare)
                                            print(pm.postalCode)
                                            print(pm.subThoroughfare)
                                            if pm.thoroughfare != nil {
                                                self.addressString = self.addressString + pm.thoroughfare! + ", "
                                                self.address = pm.thoroughfare!
                                            }
                                            if pm.subLocality != nil {
                                                self.addressString = self.addressString + pm.subLocality! + ", "
                                                self.address = self.address + pm.subLocality!
                                            }
                                            if pm.locality != nil {
                                                self.addressString = self.addressString + pm.locality! + ", "
                                                self.city = pm.locality!
                                            }
                                            if pm.country != nil {
                                                self.addressString = self.addressString + pm.country! + ", "
                                                self.country = pm.country!
                                            }
                                            if pm.postalCode != nil {
                                                self.addressString = self.addressString + pm.postalCode! + " "
                                                self.pincode = pm.postalCode!
                                            }


                                            print(self.addressString)

                                                self.stopLoading()
////                                                self.VM.saveScannedandUploadCodesApi(parameters: self.parameterJSON!)
//                                            self.codesSubmissionsApi()
                                            self.codesSubmissionsApi()
//
                                        }
                                    })
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        self.latitude = "\(userLocation.coordinate.latitude)"
        self.longitude = "\(userLocation.coordinate.longitude)"

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }else{
                let placemark = placemarks as [CLPlacemark]?
                if placemark?.count ?? 0 > 0{
                    let placemark = placemarks![0]
                    print(placemark.locality!)
                    print(placemark.administrativeArea!)
                    print(placemark.country!)
                    print(placemark.location!)
                    self.country = placemark.country!
                    self.addressString = "\(placemark.name!),\(String(describing: placemark.subLocality)),\(placemark.subAdministrativeArea!),\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
                    print(self.addressString,"Addresss")
                }
            }
        }

    }
    
    func codesSubmissionsApi(){
        self.sendScannedCodes.removeAll()
        self.savedCodeListArray.removeAll()
        self.vm.submitCodesApi(parameters: self.parameterJSON!) { response in
            DispatchQueue.main.async {
                self.stopLoading()
                self.savedCodeListArray = response?.qRCodeSaveResponseList ?? []
                print(self.savedCodeListArray.count, "Saved Codes Count")
                print(self.uploadedCodes.count)
                
                for codes in self.savedCodeListArray {
                    print("Codes Status", codes.codeStatus ?? 0)
                    let type2Array = self.uploadedCodes.filter { $0.code == codes.qRCode}
                    print(type2Array.count)
                    if type2Array.count == 0{
                    let qRCodeDBTable = UploadedCodes(context: persistanceservice.context)
                    qRCodeDBTable.code = codes.qRCode
                    qRCodeDBTable.latitude = codes.latitude
                    qRCodeDBTable.langitude = codes.longitude
                    qRCodeDBTable.codeStatus = String(codes.codeStatus ?? 0)
                    print(qRCodeDBTable.codeStatus)
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                    let resultdate = formatter.string(from: date)
                    qRCodeDBTable.date = resultdate
                    persistanceservice.saveContext()
                    let qRCodeDBTable1 = SendUploadedCodes(context: persistanceservice.context)
                    qRCodeDBTable1.code = codes.qRCode
                    persistanceservice.saveContext()
                    }else{
                        let index =  self.uploadedCodes.firstIndex(of: type2Array[0])
                        let productObj = self.uploadedCodes[index!]
                        persistanceservice.context.delete(productObj)
                       
                        persistanceservice.saveContext()
                        
                        let qRCodeDBTable = UploadedCodes(context: persistanceservice.context)
                        qRCodeDBTable.code = codes.qRCode
                        qRCodeDBTable.latitude = codes.latitude
                        qRCodeDBTable.langitude = codes.longitude
                        qRCodeDBTable.codeStatus = String(codes.codeStatus ?? 0)
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                        let resultdate = formatter.string(from: date)
                        qRCodeDBTable.date = resultdate
                        persistanceservice.saveContext()
                        let qRCodeDBTable1 = SendUploadedCodes(context: persistanceservice.context)
                        qRCodeDBTable1.code = codes.qRCode
                        persistanceservice.saveContext()
                    }
                }
               
               
                
                if self.savedCodeListArray.count != 0{
                    self.dismiss(animated: true){
                        self.clearTable()
                        self.fetchDetails()
                        self.dismiss(animated: true){
                            self.internetPushMessage = "QR Codes Synced Successfully"
                            self.scheduleNotification()
                            NotificationCenter.default.post(name: .optionView, object: nil)
                            
                        }
                       
                    }
                   
                    
                }else {
                    self.dismiss(animated: true){
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            
                            
                            let alertController = UIAlertController(title: "", message: "QR Code Submission Failed", preferredStyle: .alert)
                            
                            // Create the actions
                            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                self.clearTable()
                                self.codeLIST.removeAll()
                                self.internetPushMessage = "QR Code Submission Failed"
                                self.scheduleNotification()
                                
                            }
                            
                            // Add the actions
                            alertController.addAction(okAction)
                            
                            // Present the controller
                            self.present(alertController, animated: true, completion: nil)
                            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            let alertController = UIAlertController(title: "", message: "क्यूआर कोड सबमिशन विफल", preferredStyle: .alert)
                            
                            // Create the actions
                            let okAction = UIAlertAction(title: "ठीक है", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                self.clearTable()
                                self.codeLIST.removeAll()
                                self.internetPushMessage = "क्यूआर कोड सबमिशन विफल"
                                self.scheduleNotification()
                                
                            }
                            
                            // Add the actions
                            alertController.addAction(okAction)
                            // Present the controller
                            self.present(alertController, animated: true, completion: nil)
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            let alertController = UIAlertController(title: "", message: "QR কোড জমা দেওয়া ব্যর্থ হয়েছে৷", preferredStyle: .alert)
                            
                            // Create the actions
                            let okAction = UIAlertAction(title: "ওকে", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                self.clearTable()
                                self.codeLIST.removeAll()
                                self.internetPushMessage = "QR কোড জমা দেওয়া ব্যর্থ হয়েছে৷"
                                self.scheduleNotification()
                                
                            }
                            // Add the actions
                            alertController.addAction(okAction)
                            
                            // Present the controller
                            self.present(alertController, animated: true, completion: nil)
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                            let alertController = UIAlertController(title: "", message: "QR కోడ్ సమర్పణ విఫలమైంది", preferredStyle: .alert)
                            
                            // Create the actions
                            let okAction = UIAlertAction(title: "అలాగే", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                self.clearTable()
                                self.codeLIST.removeAll()
                                self.internetPushMessage = "QR కోడ్ సమర్పణ విఫలమైంది"
                                self.scheduleNotification()
                            }
                            
                            // Add the actions
                            alertController.addAction(okAction)
                            
                            // Present the controller
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                    }
                }
            }
        }
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "CenturyProClub Service Completed"
        content.body = "\(internetPushMessage)"
        content.sound = .default
        content.userInfo = ["value": "Data with local notification"]
        
        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: Date().addingTimeInterval(3))
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
        center.add(request) {(error) in
            if error != nil {
                print("Error \(error?.localizedDescription ?? "Error in local notification")")
            } else {
                print("QR Codes Synced Successfully")
            }
        }
    }
}


extension DashBoardViewController{
    func startMonitoringReachability() {
        guard let reachability = reachability1 else { return }
        
        // Set up a closure to handle reachability changes
        reachability1?.whenReachable = { [weak self] reachability in
            // Network is reachable, update UI or perform necessary tasks
            self?.updateReachabilityStatus(reachable: true)
        }
        reachability1?.whenUnreachable = { [weak self] _ in
            // Network is unreachable, update UI or perform necessary tasks
            self?.updateReachabilityStatus(reachable: false)
        }
        
        // Start monitoring
        do {
            try reachability1?.startNotifier()
        } catch {
            print("Failed to start reachability notifier")
        }
    }
    
    func updateReachabilityStatus(reachable: Bool) {
            // Update UI or perform necessary tasks based on reachability status
            if reachable {
                self.maintenanceAPI()
                self.isUpdateAvailable()
                if self.sourceArray.isEmpty {
                    self.bannerImagesAPI()
                }
                print("Network is reachable")
            } else {
                print("Network is unreachable")
            }
        }
}


extension DashBoardViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func openGallery() {
        PHPhotoLibrary.requestAuthorization({
            (newStatus) in
            if newStatus ==  PHAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.sourceType = .savedPhotosAlbum
                    self.picker.mediaTypes = ["public.image"]
                    self.present(self.picker, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Need Gallary access", message: "Allow Gallery access", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        DispatchQueue.main.async {
                            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
                    }
                    let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in

                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)

                }
            }
        })
    }

    func openCamera(){
        DispatchQueue.main.async {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                    if response {
                        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                            DispatchQueue.main.async {

                                self.picker.allowsEditing = false
                                self.picker.sourceType = .camera
                                self.picker.mediaTypes = ["public.image"]
                                self.present(self.picker,animated: true,completion: nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            let alertVC = UIAlertController(title: "NeedCameraAccess", message: "Allow", preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                UIAlertAction in
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            }
                            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                UIAlertAction in
                            }
                            alertVC.addAction(okAction)
                            alertVC.addAction(cancelAction)
                            self.present(alertVC, animated: true, completion: nil)

                        }
                    }
                }} else {
                    DispatchQueue.main.async {
                        self.noCamera()
                    }
                }
        }

    }


    func opencamera() {
        DispatchQueue.main.async {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    self.picker.allowsEditing = false
                    self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.picker.sourceType)!
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.present(self.picker,animated: true,completion: nil)
                }
            }else{
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "HRJohnsonneedtoaccesscameraGallery", message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                    let cancelAction = UIAlertAction(title: "Disallow", style: UIAlertAction.Style.cancel) {
                        UIAlertAction in
                    }
                    alertVC.addAction(okAction)
                    alertVC.addAction(cancelAction)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorrnodevice", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    //MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        DispatchQueue.main.async { [self] in
            guard let selectedImage = info[.originalImage] as? UIImage else {
                return
            }
            let imageData = selectedImage.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            self.profileImage.image = selectedImage
            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
            picker.dismiss(animated: true, completion: nil)
//                self.dismiss(animated: true, completion: nil)
            self.vm.imageSubmissionAPI(base64: self.strdata1)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
