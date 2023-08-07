//
//  ScanOrUpload_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 16/03/22.
//

import UIKit
import Firebase
import UserNotifications
import NotificationCenter
import CoreData
import AudioToolbox
import AVFoundation
import CoreLocation
import CoreData
import Firebase
import Lottie
import LanguageManager_iOS

class ScanOrUpload_VC: BaseViewController, AVCaptureVideoDataOutputSampleBufferDelegate, UNUserNotificationCenterDelegate, CLLocationManagerDelegate, UITextFieldDelegate, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    

    @IBOutlet weak var internetCheckAnimationView: LottieAnimationView!
    @IBOutlet weak var syncCodeOutLBL: UILabel!
    @IBOutlet weak var syncNowOutBtn: UIButton!
    @IBOutlet weak var syncLaterOutBtn: UIButton!
    @IBOutlet weak var syncInternetCheck: UIView!
    @IBOutlet weak var withoutInternetView: UIView!
    @IBOutlet weak var scanAnimationView: LottieAnimationView!
    @IBOutlet var codeCountView: UIView!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var scannerView: UIView!
    @IBOutlet var uploadView: UIView!
    @IBOutlet var codeTF: UITextField!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var scanQRCodeButton: UIButton!
    @IBOutlet var enterQRCodeLabel: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var BottomView: GradientView!
    @IBOutlet weak var headerView: GradientView!
    @IBOutlet weak var closeBTN: UIButton!
    @IBOutlet weak var scannerImage: UIImageView!
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    
    var reachability = Reach()
    var isComeFrom = ""
    var isComingFrom = 0
    var newproductArray: [[String:Any]] = []
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var catalogueList = ""
    var addressString : String = ""
    var country = ""
    var city = ""
    var address = ""
    var pincode = ""
    
    var isScanned = false
    var isFirsttime = true
    var alertController = UIAlertController()
    var okAction = UIAlertAction()
    let session = AVCaptureSession()
    lazy var vision = Vision.vision()
    var barcodeDetector :VisionBarcodeDetector?
    var enteredCodeArray = [String]()
    var scannedListArray = [String]()
    var codeLIST:Array = [ScanCodeSTORE]()
    var uploadedCodes:Array = [UploadedCodes]()
    var sendScannedCodes:Array = [SendUploadedCodes]()
    var locationManager = CLLocationManager()
    var currentlocation:CLLocation!
    var isFrom = 0
    var isSwitchOn = 0
    var isscannedOnce = false
    var valueChecked = false
    var scannedCodes = ""
    
    var scannedStatus = false
    var scaned = 1
    var CapturedCodess = ""
    var currentUserID = ""
    var parameterJSON:JSON?
    var itsFrom = ""
    var VM = UploadAndScanViewModel()
    var savedCodeListArray = [QRCodeSaveResponseList]()
    var fromSideMenu = ""
    var scannedCodeArray = [String]()
    
    var uploadedCodes1:Array = [UploadedCodes]()
    var codeLIST1:Array = [ScanCodeSTORE]()
    var internetPushMessage = ""
    private var animationView: LottieAnimationView?
    
    var latitude = ""
    var longitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countLabel.cornerRadius = countLabel.frame.width/2
        self.codeCountView.cornerRadius = codeCountView.frame.width/2
        self.codeTF.keyboardType = .numberPad
        BottomView.clipsToBounds = true
        BottomView.layer.cornerRadius = 24
        BottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        fetchDetails()
        fetchDetails2()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        self.VM.VC = self
        codeTF.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(codeExists), name: Notification.Name.restartScan, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cameraAccess), name: Notification.Name.scanAccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startVideo), name: Notification.Name.startVideo, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(codesSubmission), name: Notification.Name.CodeSubmission, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(codesUploadAgain), name: Notification.Name.uploadAgain, object: nil)
        languagelocalization()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            if MyCommonFunctionalUtilities.isInternetCallTheApi() != false{
                DispatchQueue.main.async{
                    if self.codeLIST.count != 0{
                        NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                        self.scheduleNotification()
                    }
                }
            }
        })
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Scan/Upload QR code")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scanQRCodeButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 20, bottom: 2, right: 20)
    }
    
    @IBAction func syncLaterActBtn(_ sender: UIButton) {
        self.session.stopRunning()
        if self.fromSideMenu == "SideMenu"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            }
        }else{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .goToParticularVc, object: nil)
            }
        }
    }
    
    
    @IBAction func syncNowActBtn(_ sender: UIButton) {
            NotificationCenter.default.post(name: .CodeSubmission, object: nil)
    }
    
    
    func playAnimation(){
        animationView = .init(name: "cloud_sync")
        animationView!.frame = internetCheckAnimationView.bounds
          // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
          // 4. Set animation loop mode
        animationView!.loopMode = .loop
          // 5. Adjust animation speed
        animationView!.animationSpeed = 1
        internetCheckAnimationView.addSubview(animationView!)
          // 6. Play animation
        animationView!.play()
    }
    
    func languagelocalization(){
        playAnimation()
        self.withoutInternetView.isHidden = true
        self.header.text = "Upload Code".localiz()
        self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it.".localiz()
        self.codeTF.placeholder = "ucEnterYourCodeKEY".localiz()
        self.submitButton.setTitle("fpSubmitKEY".localiz(), for: .normal)
        self.enterQRCodeLabel.text = "Enter QR code in the above field and submit.".localiz()
        self.scanQRCodeButton.setTitle("fcScanQRCodeKEY".localiz(), for: .normal)
        self.infoLbl.text = "Click here to see your QR Codes".localiz()
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
    
    
    @objc func codesUploadAgain(notification: Notification){
        if self.itsFrom == "UploadCode"{
                self.fetchDetails()
                self.messageLbl.isHidden = false
                self.scannerView.isHidden = false
                self.uploadView.isHidden = true
                self.closeBTN.isHidden = false
                self.headerView.isHidden = true
            
            self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it.".localiz()
            self.scanQRCodeButton.setTitle("Upload QR Code".localiz(), for: .normal)
            self.infoLbl.text = "Click here to see your QR Codes".localiz()
            self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
                self.isScanned = true
                if self.isFirsttime == true{
                    NotificationCenter.default.post(name: .startVideo, object: nil)
                    self.isFirsttime = false
                    self.scaned = 1
                    self.scannedStatus = true
                }else{
                    self.session.startRunning()
                }
                self.clearTable()
                self.codeLIST.removeAll()
                self.fetchDetails()
                
            }else{
                self.headerView.isHidden = false
                self.closeBTN.isHidden = true
               
                self.enterQRCodeLabel.text = "Enter QR code in the above field and submit.".localiz()
                self.scanQRCodeButton.setTitle("Scan QR Code".localiz(), for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes".localiz()
                self.scanQRCodeButton.setImage(UIImage(named: "qr"), for: .normal)
                self.scannerView.isHidden = true
                self.uploadView.isHidden = false
                self.messageLbl.isHidden = true
                self.session.stopRunning()
                self.fetchDetails()
                self.isScanned = false
                self.isFrom = 0
                self.isscannedOnce = false
                self.fetchDetails()
                self.isScanned = false
                self.clearTable()
                self.session.stopRunning()
                self.codeLIST.removeAll()
                self.fetchDetails()
            }
         
    }
    
    @objc func startVideo(notification: Notification){
        startLiveVideo()
    }
    
    @objc func codeExists(notification: Notification){
        self.fetchDetails()
        self.restartScanning()
    }
    @objc func cameraAccess(notification: Notification){
        self.session.startRunning()
        self.messageLbl.isHidden = false
        self.headerView.isHidden = true
        self.closeBTN.isHidden = false
        self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
        self.scannerView.isHidden = false
        self.uploadView.isHidden = true
        
        self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it.".localiz()
        self.scanQRCodeButton.setTitle("Upload QR Code".localiz(), for: .normal)
        self.infoLbl.text = "Click here to see your QR Codes".localiz()
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted == true {
            } else {
                
            }
        })
    
        self.isScanned = true
        scaned = 1
        self.scannedStatus = false
        self.barcodeDetector = vision.barcodeDetector()
        isComingFrom = 0
        if isFirsttime == true{
            startLiveVideo()
            self.isFirsttime = false
            self.scaned = 1
            self.scannedStatus = true
        }else{
            session.startRunning()
        }
    }
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           self.scannerImage.layer.zPosition = 2
       }
    func fetchDetails(){
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.codeLIST.removeAll()
            self.uploadedCodes1.removeAll()
            let fetchRequest1:NSFetchRequest<UploadedCodes> = UploadedCodes.fetchRequest()
            let fetchRequest:NSFetchRequest<ScanCodeSTORE> = ScanCodeSTORE.fetchRequest()
            do{
                self.codeLIST = try persistanceservice.context.fetch(fetchRequest)
                self.uploadedCodes1 = try persistanceservice.context.fetch(fetchRequest1)
                print(self.codeLIST.count, "Count")
                if self.codeLIST.count != 0{
                    self.countLabel.isHidden = false
                    self.countLabel.text = "\(self.codeLIST.count)"
                }else{
                    self.countLabel.isHidden = true
                }
                for codes in self.codeLIST {
                    if (uploadedCodes1.contains{$0.code == codes.code}){
                    }else{
                        let qRCodeDBTable = UploadedCodes(context: persistanceservice.context)
                        qRCodeDBTable.code = codes.code
                        qRCodeDBTable.latitude = codes.latitude
                        qRCodeDBTable.langitude = codes.longitude
                        qRCodeDBTable.codeStatus = String(0)
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                        let resultdate = formatter.string(from: date)
                        qRCodeDBTable.date = resultdate
                        persistanceservice.saveContext()
                        let qRCodeDBTable1 = SendUploadedCodes(context: persistanceservice.context)
                        qRCodeDBTable1.code = codes.code
                        persistanceservice.saveContext()
                    }
                }
            }catch{
                print("error while fetching data")
            }
            print(uploadedCodes.count,"dskjdnsk")
        }else{
            self.codeLIST.removeAll()
            let fetchRequest:NSFetchRequest<ScanCodeSTORE> = ScanCodeSTORE.fetchRequest()
            do{
                self.codeLIST = try persistanceservice.context.fetch(fetchRequest)
                print(self.codeLIST.count, "Count")
                
                if self.codeLIST.count != 0{
                    self.countLabel.isHidden = false
                    self.countLabel.text = "\(self.codeLIST.count)"
                }else{
                    self.countLabel.isHidden = true
                }
            }catch{
                print("error while fetching data")
            }
        }
    }
    
    @objc func codesSubmission(notification: Notification){
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.dismiss(animated: true){
                self.internetPushMessage = "Check Internet Connection"
                self.fetchDetails()
                self.dismiss(animated: true){
                    NotificationCenter.default.post(name: .optionView, object: nil)
                    self.scheduleNotification()
                }
                
            }
            
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
                "LoyaltyID": "\(loyaltyId)",
                "PinCode": "\(self.pincode)",
                "QRCodeSaveRequestList": self.newproductArray as [[String:Any]],
                "SourceType": "1",
                "State": ""
            ]
            print(self.parameterJSON ?? "")
            
            //        if self.scanQRCodeButton.currentTitle == "Upload QR Code".localiz()
            //            ||  self.scanQRCodeButton.currentTitle == "क्यूआर कोड अपलोड करें" ||  self.scanQRCodeButton.currentTitle == "QR কোড আপলোড করুন" ||  self.scanQRCodeButton.currentTitle == "QR కోడ్‌ని అప్‌లోడ్ చేయండి"
            if self.scanQRCodeButton.currentTitle == "Upload QR Code".localiz(){
                self.isFrom = 1
                self.session.stopRunning()
                self.codeTF.text = ""
                self.scannerView.isHidden = false
                self.session.stopRunning()
                self.fetchDetails()
                self.getAddressFromLatLon(pdblLatitude: String(self.latitude), withLongitude: String(self.longitude))
                return
            }else{
                self.isFrom = 0
                self.fetchDetails()
                self.codeTF.text = ""
                self.getAddressFromLatLon(pdblLatitude: String(self.latitude), withLongitude: String(self.longitude))
                return
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDetails()
        if self.itsFrom == "ScanCode"{
            fetchDetails()
            self.headerView.isHidden = true
            self.closeBTN.isHidden = false
            self.messageLbl.isHidden = false
            
            self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it.".localiz()
            self.scanQRCodeButton.setTitle("Upload QR Code".localiz(), for: .normal)
            self.infoLbl.text = "Click here to see your QR Codes".localiz()
            self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
            self.scannerView.isHidden = false
            self.uploadView.isHidden = true
            DispatchQueue.global().async {
                self.session.startRunning()
            }
            
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted == true {
                } else {
                }
            })

            self.isScanned = true
            scaned = 1
            self.scannedStatus = false
            self.barcodeDetector = vision.barcodeDetector()
            self.session.stopRunning()
            if isFirsttime == true{
                startLiveVideo()
                self.isFirsttime = false
                self.scaned = 1
                self.scannedStatus = true
            }else{
                session.startRunning()
            }
        }else{
            fetchDetails()
            self.headerView.isHidden = false
            self.closeBTN.isHidden = true
          
            self.scanQRCodeButton.setImage(UIImage(named: "qr"), for: .normal)
            self.messageLbl.isHidden = true
            self.scannerView.isHidden = true
            self.uploadView.isHidden = false
            self.session.stopRunning()
            self.codeTF.setLeftPaddingPoints(10)
            
            self.enterQRCodeLabel.text = "Enter QR code in the above field and submit.".localiz()
            self.scanQRCodeButton.setTitle("Scan QR Code".localiz(), for: .normal)
            self.infoLbl.text = "Click here to see your QR Codes".localiz()
        }
    }
   
    func fetchDetails1(){
           
           let fetchRequest:NSFetchRequest<UploadedCodes> = UploadedCodes.fetchRequest()
           do{
               self.uploadedCodes = try persistanceservice.context.fetch(fetchRequest)
               print(self.uploadedCodes.count, "Uploaded Count")
               
               for QRCodes in self.savedCodeListArray{
                   print(QRCodes.qRCode ?? 0, "Codes")
                   let filterArray = self.uploadedCodes.filter{$0.code == QRCodes.qRCode}
                   if filterArray.count > 0{
                       for QrcodeData in self.uploadedCodes {
                           if QrcodeData.code == QRCodes.qRCode{
                               print(QRCodes.qRCode ?? "", "Deleted")
                               persistanceservice.context.delete(QrcodeData)
                               persistanceservice.saveContext()
                               self.fetchDetails2()
                           }
                       }
                   }
               }
          
           }catch{
               print("error while fetching data")
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
    func codesSubmissionsApi(){
        self.sendScannedCodes.removeAll()
        self.savedCodeListArray.removeAll()
        print(parameterJSON,"jdskdj")
        self.VM.submitCodesApi(parameters: self.parameterJSON!) { response in
            DispatchQueue.main.async {
                
                self.isScanned = false
                self.session.stopRunning()
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
                            NotificationCenter.default.post(name: .optionView, object: nil)
                        }
                    }
                }else {
                    self.dismiss(animated: true){
                        let alertController = UIAlertController(title: "", message: "QR Code Submission Failed".localiz(), preferredStyle: .alert)
                        // Create the actions
                        let okAction = UIAlertAction(title: "rOKKEY".localiz(), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            self.clearTable()
                            self.codeLIST.removeAll()
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
    
    
    @IBAction func closeScreen(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() != false{
            DispatchQueue.main.async{
                if self.codeLIST.count != 0{
                    NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                }
            }
        }
//        clearTable()
        self.session.stopRunning()
        if self.fromSideMenu == "SideMenu"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            }
        }else{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .goToParticularVc, object: nil)
            }
        }
        
        
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.fetchDetails()
            if self.codeTF.text != ""{
                if self.codeTF.text?.count == 12{
                    if self.codeLIST.count == 0{
                        print("UploadCode")
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                        let resultdate = formatter.string(from: date)
                        let qRCodeDBTable = ScanCodeSTORE(context: persistanceservice.context)
                        qRCodeDBTable.code = self.codeTF.text
                        qRCodeDBTable.date = resultdate
                        qRCodeDBTable.latitude = String(self.latitude)
                       qRCodeDBTable.longitude = String(self.longitude)
                        persistanceservice.saveContext()
                        self.fetchDetails()
                        self.restartScanning()
                    return
                    }else{
                        print("ScannedCode")
                        self.fetchDetails()
                        self.enteredCodeArray.removeAll()
                        for codes in self.codeLIST{
                            self.enteredCodeArray.append(codes.code ?? "")
                        }
                        let enterData = self.codeTF.text
                        if self.enteredCodeArray.contains(enterData ?? ""){
                            DispatchQueue.main.async{
                               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                               vc!.delegate = self
                               vc!.titleInfo = ""
                                vc!.itsComeFrom = "Upload"
                                vc!.descriptionInfo = "CodeScannedSuccess".localiz()
                               vc!.modalPresentationStyle = .overCurrentContext
                               vc!.modalTransitionStyle = .crossDissolve
                               self.present(vc!, animated: true, completion: nil)
                            }
                        }else{
                            if self.codeLIST.count <= 14{
                                let date = Date()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                                let resultdate = formatter.string(from: date)
                                let qRCodeDBTable = ScanCodeSTORE(context: persistanceservice.context)
                                qRCodeDBTable.code = self.codeTF.text
                                qRCodeDBTable.date = resultdate
                                qRCodeDBTable.latitude = String(self.latitude)
                                qRCodeDBTable.longitude = String(self.longitude)
                                persistanceservice.saveContext()
                                self.fetchDetails()
                                self.restartScanning()
                            }else{
                                
                                self.withoutInternetView.isHidden = false
                                self.syncCodeOutLBL.text = "Offline scanning limit exceeded. Sync pending codes in Wifi/Mobile data or Clear processed codes .".localiz()
                                self.codeTF.text = ""
                                self.session.stopRunning()
                                
                                
//                                let alert = UIAlertController(title: "", message: "Offline scanning limit exceeded. Sync pending codes in Wifi/Mobile data or Clear processed codes .".localiz(), preferredStyle: UIAlertController.Style.alert)
//                                alert.addAction(UIAlertAction(title: "okKey".localiz(), style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
//                                        self.codeTF.text = ""
//                                        self.session.stopRunning()
//                                    NotificationCenter.default.post(name: .CodeSubmission, object: nil)
//                                    }))
//                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                        
                    }
                    
                }else{
                    let alert = UIAlertController(title: "", message: "QR Code length should be 12".localiz(), preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "okKey".localiz(), style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                            self.codeTF.text = ""
                            self.session.stopRunning()
                        }))
                        self.present(alert, animated: true, completion: nil)
                }
            }else{
                let alert = UIAlertController(title: "", message: "Enter the QR Code".localiz(), preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "okKey".localiz(), style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
            }
            
        }else{
                // Create the alert controller
            let alertController = UIAlertController(title: "Enable Location Services".localiz(), message: "QR Code scanning requires Location Access".localiz(), preferredStyle: .alert)
                // Create the actions
            let okAction = UIAlertAction(title: "Settings".localiz(), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                    self.authorizelocationstates()
                }
            let cancelAction = UIAlertAction(title: "CancelKey".localiz(), style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
            }
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        //        clearTable()
                if MyCommonFunctionalUtilities.isInternetCallTheApi() != false{
                    DispatchQueue.main.async{
                        if self.codeLIST.count != 0{
                            NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                        }
                    }
                }
                self.session.stopRunning()
                if self.fromSideMenu == "SideMenu"{
                    self.dismiss(animated: true){
                        NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
                    }
                }else{
                    self.dismiss(animated: true){
                        NotificationCenter.default.post(name: .goToParticularVc, object: nil)
                    }
                }

    }
    @IBAction func scannedCodesButton(_ sender: Any) {
//        if self.scanQRCodeButton.currentTitle == "Upload QR Code" || self.scanQRCodeButton.currentTitle == "क्यूआर कोड अपलोड करें" || self.scanQRCodeButton.currentTitle == "QR কোড আপলোড করুন" || self.scanQRCodeButton.currentTitle == "QR కోడ్‌ని అప్‌లోడ్ చేయండి"
            if self.scanQRCodeButton.currentTitle == "Upload QR Code".localiz(){
            self.session.stopRunning()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScannedCodes_VC") as! ScannedCodes_VC
            vc.itsFrom = "Scanner"
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScannedCodes_VC") as! ScannedCodes_VC
            vc.itsFrom = "Upload"
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
        
       
    }
    
    @IBAction func scanQRCode(_ sender: Any) {
//        if self.scanQRCodeButton.currentTitle == "Upload QR Code" || self.scanQRCodeButton.currentTitle == "क्यूआर कोड अपलोड करें" || self.scanQRCodeButton.currentTitle == "QR কোড আপলোড করুন" || self.scanQRCodeButton.currentTitle == "QR కోడ్‌ని అప్‌లోడ్ చేయండి"
            if self.scanQRCodeButton.currentTitle == "Upload QR Code".localiz(){
            self.headerView.isHidden = false
            self.closeBTN.isHidden = true
            
            self.scanQRCodeButton.setImage(UIImage(named: "qr"), for: .normal)
            self.scannerView.isHidden = true
            self.uploadView.isHidden = false
            self.messageLbl.isHidden = true
            self.session.stopRunning()
            fetchDetails()
            self.isScanned = false
            self.isFrom = 0
            self.isscannedOnce = false
                
                self.enterQRCodeLabel.text = "Enter QR code in the above field and submit.".localiz()
                self.scanQRCodeButton.setTitle("Scan QR Code".localiz(), for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes".localiz()
            session.stopRunning()
        }else{
            self.messageLbl.isHidden = false
            self.scannerView.isHidden = false
            self.uploadView.isHidden = true
            self.closeBTN.isHidden = false
            self.headerView.isHidden = true
            
            self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it.".localiz()
            self.scanQRCodeButton.setTitle("Upload QR Code".localiz(), for: .normal)
            self.infoLbl.text = "Click here to see your QR Codes".localiz()
            self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
                if isComingFrom == 1{
                    NotificationCenter.default.post(name: .scanAccess, object: nil)
                }
               
                if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                    if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                        fetchDetails()
                        self.isScanned = true
                        scaned = 1
                        self.scannedStatus = false
                        self.barcodeDetector = vision.barcodeDetector()
                        if isFirsttime == true{
                            startLiveVideo()
                            self.isFirsttime = false
                            self.scaned = 1
                            self.scannedStatus = true
                        }else{
                            DispatchQueue.global().async {
                                self.session.startRunning()
                            }
                           
//                            self.restartScanning()
//                            print("Restart Again")
                            self.messageLbl.isHidden = false
                            self.headerView.isHidden = true
                            self.closeBTN.isHidden = false
                            self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
                            self.scannerView.isHidden = false
                            self.uploadView.isHidden = true
                            
                            self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it.".localiz()
                            self.scanQRCodeButton.setTitle("Upload QR Code".localiz(), for: .normal)
                            self.infoLbl.text = "Click here to see your QR Codes".localiz()
                            
                            self.scannedStatus = true
                            self.session.startRunning()
                        }

                    }else{
                        let alertVC = UIAlertController(title: "Sharon Bandhan Application need Camera permission for Scanning Codes".localiz(), message: "Allow Camera Access".localiz(), preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Allow".localiz(), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }
                        let cancelAction = UIAlertAction(title: "DisAllow".localiz(), style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                            
                        }
                        alertVC.addAction(okAction)
                        alertVC.addAction(cancelAction)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }else{
                    // Create the alert controller
                    let alertController = UIAlertController(title: "Enable Location Services".localiz(), message: "QR Code scanning requires Location Access".localiz(), preferredStyle: .alert)
                        
                        // Create the actions
                    let okAction = UIAlertAction(title: "Settings".localiz(), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            NSLog("OK Pressed")
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                            self.authorizelocationstates()
                        }
                    let cancelAction = UIAlertAction(title: "CancelKey".localiz(), style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                            NSLog("Cancel Pressed")
                        }
                        
                        // Add the actions
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        
                        // Present the controller
                        self.present(alertController, animated: true, completion: nil)
                        // Note : This function is overlap permission
                }
            
        }
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//    if string == " " {
//        return false
//    }
//
//        if textField == codeTF{
//            let maxLength = 12
//            let currentString: NSString = (codeTF.text ?? "") as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        }
//        return true
//    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")

      if string == numberFiltered {
        let currentText = codeTF.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 12
      } else {
        return false
      }
    }
    func authorizelocationstates(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentlocation = locationManager.location
            print(currentlocation)
        }
        else{
            // Note : This function is overlap permission
            locationManager.requestWhenInUseAuthorization()
            authorizelocationstates()
        }
    }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        locationManager = manager
//        // Only called when variable have location data
//        authorizelocationstates()
//    }
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

    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
            
            if let barcodeDetector = self.barcodeDetector {
                let visionImage = VisionImage(buffer: sampleBuffer)
                barcodeDetector.detect(in: visionImage) { (barcodes, error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }else{
                        if self.scannedStatus == false{
                            self.session.stopRunning()
                            return
                        }else{
                            
                            for barcode in barcodes!{
                                if self.scaned == 1{
                                    
                                    self.session.stopRunning()
                                    let scannedCodess = barcode.rawValue!.replacingOccurrences(of: " ", with: "")
                                    self.CapturedCodess = scannedCodess
                                    
                                    if scannedCodess.count == 12{
                                        let compareCodes = self.codeLIST.filter({$0.code == self.CapturedCodess})
                                        self.session.stopRunning()
                                        AudioServicesPlaySystemSound(1103)
                                        if self.codeLIST.count <= 14{
                                            if compareCodes.count == 0{
                                                print("Success")
                                                let date = Date()
                                                let formatter = DateFormatter()
                                                formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
                                                let resultdate = formatter.string(from: date)
                                                let qRCodeDBTable = ScanCodeSTORE(context: persistanceservice.context)
                                                qRCodeDBTable.code = self.CapturedCodess
                                                qRCodeDBTable.latitude = String(self.latitude)
                                                qRCodeDBTable.longitude = String(self.longitude)
                                                qRCodeDBTable.date = resultdate
                                                persistanceservice.saveContext()
                                                self.scaned = 0
                                                self.isScanned = true
                                                self.scannedStatus = false
                                                self.session.stopRunning()
                                                self.fetchDetails()
                                                self.restartScanning()
                                                self.session.stopRunning()
                                                return
                                            }else{
                                                self.scaned = 0
                                                self.Validation()
                                                return
                                            }
                                        }else{
                                            if compareCodes.count == 0{
                                                var message = ""
                                                if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                                                   message = "Offline scanning limit exceeded. Sync pending codes in Wifi/Mobile data or Clear processed codes .".localiz()
                                                }else{
                                                    message = "Online scanning limit exceeded. Sync pending codes in Wifi/Mobile data or Clear processed codes .".localiz()
                                                }
                                                
                                                let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "okKey".localiz(), style: UIAlertAction.Style.default, handler: {   UIAlertAction in
                                                    self.isScanned = true
                                                    self.session.startRunning()
                                                    NotificationCenter.default.post(name: .CodeSubmission, object: nil)
                                                }))
                                                self.present(alert, animated: true, completion: nil)
                                                return
                                            }else{
                                                
                                                self.scaned = 0
                                                self.Validation()
                                                return
                                            }
                                            
                                        }
                                        
                                    }else{
                                        let alert = UIAlertController(title: "", message: "QR Code length should be 12".localiz(), preferredStyle: UIAlertController.Style.alert)
                                        alert.addAction(UIAlertAction(title: "okKey".localiz(), style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                            self.isScanned = true
                                            self.session.startRunning()
                                            
                                        }))
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                }else{
                                    self.scaned = 1
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
}
    
    
    func Validation(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.session.stopRunning()
            DispatchQueue.main.async{
               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
               vc!.delegate = self
               vc!.titleInfo = ""
                vc!.itsComeFrom = "Scanner"
                vc!.descriptionInfo = "CodeScannedSuccess".localiz()
               vc!.modalPresentationStyle = .overCurrentContext
               vc!.modalTransitionStyle = .crossDissolve
               self.present(vc!, animated: true, completion: nil)
            }
        })

    }
    func restartScanning(){
        fetchDetails()
        if isScanned == true{
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.messageLbl.isHidden = false
                self.headerView.isHidden = true
                self.closeBTN.isHidden = false
                self.scanQRCodeButton.setImage(UIImage(named: "software-upload"), for: .normal)
                self.scannerView.isHidden = false
                self.uploadView.isHidden = true
                
                self.messageLbl.text = "Place a QR Code inside the view finder rectangle to scan it.".localiz()
                self.scanQRCodeButton.setTitle("Upload QR Code".localiz(), for: .normal)
                self.infoLbl.text = "Click here to see your QR Codes".localiz()
                self.scannedStatus = true
                self.session.startRunning()
            })
        }else{
            self.session.stopRunning()
            self.codeTF.text = ""
            self.headerView.isHidden = false
            self.closeBTN.isHidden = true
            self.enterQRCodeLabel.text = "Enter QR code in the above field and submit.".localiz()
            self.scanQRCodeButton.setTitle("Scan QR Code".localiz(), for: .normal)
            self.infoLbl.text = "Click here to see your QR Codes".localiz()
            self.scanQRCodeButton.setImage(UIImage(named: "qr"), for: .normal)
        }
       }
    
    private func startLiveVideo() {
        DispatchQueue.main.async {
            self.session.sessionPreset = AVCaptureSession.Preset.photo
            let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
            let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
            let deviceOutput = AVCaptureVideoDataOutput()
            deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
            deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
            self.session.addInput(deviceInput)
            self.session.addOutput(deviceOutput)
            let imageLayer = AVCaptureVideoPreviewLayer(session: self.session)
            imageLayer.frame = CGRect(x: 0, y: 0, width: self.scannerView.frame.size.width, height: self.scannerView.frame.size.height)
            imageLayer.videoGravity = .resizeAspectFill
            self.scannerView.layer.addSublayer(imageLayer)
            DispatchQueue.global().async {
                self.session.startRunning()
            }
            
            self.isscannedOnce = true
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
//                                        let pm = placemarks! as [CLPlacemark]
//                                        if pm.count > 0 {
//                                            let pm = placemarks![0]
//                                            print(pm.country)
//                                            print(pm.locality)
//                                            print(pm.subLocality)
//                                            print(pm.thoroughfare)
//                                            print(pm.postalCode)
//                                            print(pm.subThoroughfare)
//                                            if pm.thoroughfare != nil {
//                                                self.addressString = self.addressString + pm.thoroughfare! + ", "
//                                                self.address = pm.thoroughfare!
//                                            }
//                                            if pm.subLocality != nil {
//                                                self.addressString = self.addressString + pm.subLocality! + ", "
//                                                self.address = self.address + pm.subLocality!
//                                            }
//                                            if pm.locality != nil {
//                                                self.addressString = self.addressString + pm.locality! + ", "
//                                                self.city = pm.locality!
//                                            }
//                                            if pm.country != nil {
//                                                self.addressString = self.addressString + pm.country! + ", "
//                                                self.country = pm.country!
//                                            }
//                                            if pm.postalCode != nil {
//                                                self.addressString = self.addressString + pm.postalCode! + " "
//                                                self.pincode = pm.postalCode!
//                                            }
//
//
//                                            print(self.addressString)
                                            
                                                self.stopLoading()
//                                                self.VM.saveScannedandUploadCodesApi(parameters: self.parameterJSON!)
                                            self.codesSubmissionsApi()
                                            
//                                        }
                                    })
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        authorizelocationstates()
//        print("user latitude = \(userLocation.coordinate.latitude)")
//        print("user longitude = \(userLocation.coordinate.longitude)")

        self.latitude = "\(userLocation.coordinate.latitude)"
        self.longitude = "\(userLocation.coordinate.longitude)"

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            //let placemark = placemarks! as [CLPlacemark]
            
            let placemark = placemarks as [CLPlacemark]?
            
            if placemark?.count ?? 0 > 0{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
                print(placemark.location!)
                print(placemark.postalCode)
                
                self.city = placemark.locality ?? ""
                self.country = placemark.subAdministrativeArea ?? ""
                self.pincode = placemark.postalCode ?? ""
                
                
                self.addressString = "\(placemark.name!),\(String(describing: placemark.subLocality)),\(placemark.subAdministrativeArea!),\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
                print(self.addressString,"Addresss")
            }
        }

    }
    
    
}
//extension Array where Element: Hashable {
//    func removingDuplicates() -> [Element] {
//        var addedDict = [Element: Bool]()
//
//        return filter {
//            addedDict.updateValue(true, forKey: $0) == nil
//        }
//    }
//
//    mutating func removeDuplicates() {
//        self = self.removingDuplicates()
//    }
//}
