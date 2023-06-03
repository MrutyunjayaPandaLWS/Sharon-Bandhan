//
//  CP_Scanner_VC.swift
//  Sharon Secure
//
//  Created by Arokia IT on 9/9/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class CP_Scanner_VC: BaseViewController,AVCaptureMetadataOutputObjectsDelegate, UNUserNotificationCenterDelegate, closeCodesDelegate, UITextFieldDelegate, PopUpDelegate, PopUpDelegate2{
    func popUpAlertDidTap2(_ vc: PopUp2ViewController) {}
    
    
    func didTapYesButton(_ vc: Popup3ViewController) {}
    
    @IBOutlet weak var scanoruploadLabel: UILabel!
    //@IBOutlet weak var scanImage12: UIImageView!
    @IBOutlet var generateEWarrantyBottom: UIButton!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet weak var dateofMfg: UILabel!
    @IBOutlet var shadowView: UIView!
    @IBOutlet var codetableView: UITableView!
    @IBOutlet var codeDetails: UILabel!
    @IBOutlet var scannerImage: UIImageView!
   // @IBOutlet var cameraView: UIView!
    @IBOutlet var productname: UILabel!
    @IBOutlet var plantName: UILabel!
    @IBOutlet var thickness: UILabel!
    @IBOutlet var size: UILabel!
    @IBOutlet var uniqueCode: UILabel!
    @IBOutlet var scanAgain: UIButton!
    @IBOutlet var generateEwarranty: UIButton!
    @IBOutlet var codeTF: UITextField!
    @IBOutlet var uploadCodeView: UIView!
    @IBOutlet var scanCodeView: UIView!
    @IBOutlet weak var backBtnView: UIView!
    
    var scannerVM = ScannerViewModel()
    let userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    let captureMetadataOutput = AVCaptureMetadataOutput()
    var isscannedOnce = true
    var selectedindex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateEWarrantyBottom.isHidden = true
        self.codetableView.delegate = self
        self.codetableView.dataSource = self
        self.scannerVM.vc = self
        self.codeTF.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(alertPopUpMessage), name: Notification.Name("alertPopUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(popUpMessageInvalidCode), name: Notification.Name("InvalidQRCode"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alertMsgPopUp), name: Notification.Name("alertMessagePopuP"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(scannedCodeLimit), name: Notification.Name("maxiLimitReached"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(maxUploadLimit), name: Notification.Name("maxiUploadLimiReached"), object: nil)
        InitialSetups()

        DispatchQueue.main.async {
       

            if self.selectedindex == 1{
                if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                  //  self.scanImage12.isHidden = true
                    self.startLiveVideo()
                } else {
                    AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                        if granted {
                  //          self.scanImage12.isHidden = true
                          //  self.scannerImage.isHidden = false
                            self.startLiveVideo()
                        } else {
                            //self.scanImage12.isHidden = false
                          //  self.scannerImage.isHidden = true
                            DispatchQueue.main.async {
                                UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
                            }
                        }
                    })
                }
                self.scanoruploadLabel.text = "Scan QR Code"
                self.scanAgain.setTitle("SCAN AGAIN", for: .normal)
                self.scannerImage.isHidden = false
                //self.scanImage12.isHidden = true
                self.scanCodeView.isHidden = false
                self.uploadCodeView.isHidden = true
                DispatchQueue.main.async {
                    self.captureSession.startRunning()
                }
                
            } else if self.selectedindex == 2 {
                self.scanoruploadLabel.text = "Upload Code"
                self.scanAgain.setTitle("UPLOAD AGAIN", for: .normal)
                self.scannerImage.isHidden = true
             //   self.scanImage12.isHidden = false
                self.captureSession.stopRunning()
                self.uploadCodeView.isHidden = false
                self.scanCodeView.isHidden = true
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "QR/Scanner")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.backBtnView.layer.cornerRadius = self.backBtnView.frame.width / 2
        self.scannerImage.layer.zPosition = 2
    }
    
    @objc func alertPopUpMessage(notification: Notification){
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func popUpMessageInvalidCode(notification: Notification){
        self.isscannedOnce = true
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            self.captureSession.startRunning()
        })
    }
    @objc func alertMsgPopUp(notification: Notification){
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            self.captureSession.startRunning()
        })
    }
    @objc func scannedCodeLimit(notification: Notification){
        self.isscannedOnce = true
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            self.captureSession.startRunning()
        })
        self.shadowView.isHidden = true
    }
    @objc func maxUploadLimit(notification: Notification){
        self.isscannedOnce = true
//                                                self.session.startRunning()
        self.shadowView.isHidden = true
    }


    @IBAction func uploadCodeButton(_ sender: Any) {
        if codeTF.text ?? "" == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please Enter code"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if codeTF.text!.count <= 11{
            self.alertValidationfor12digits(code: codeTF.text ?? "")
        }else{
            var list3 = [QrUsegereport1]()
            list3 = self.scannerVM.tempStoreCodesArray
            //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
            if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                print(list3.count)
                if list3.count >= 10{
                    if self.selectedindex == 1 {
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "Your daily uploading limit exceeded"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                        self.isscannedOnce = true
                        self.captureSession.startRunning()
                        self.shadowView.isHidden = true
                        
                    } else if self.selectedindex == 2 {
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "Your daily uploading limit exceeded"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                        self.isscannedOnce = true
//                                    self.session.startRunning()
                        self.shadowView.isHidden = true
                        
                    }

                }else{
                    list3 = self.scannerVM.tempStoreCodesArray.filter{ ($0.scratchCode == codeTF.text) }
                    print(list3.count)
                    if list3.count == 0 {
                        DispatchQueue.main.async {
                            self.captureSession.stopRunning()
                        }
                        self.codeGenuineAPI(code: codeTF.text ?? "")
                    } else {
                        if self.selectedindex == 1 {
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "Code is already scanned"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
                            self.isscannedOnce = true
                            self.captureSession.startRunning()
                            self.shadowView.isHidden = true
                            
                        } else if self.selectedindex == 2 {
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "Code is already uploaded"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                            }
                            self.isscannedOnce = true
        //                    self.session.startRunning()
                            self.shadowView.isHidden = true
                            
                        }
                    }

                }
                
            }else{
                list3 = self.scannerVM.tempStoreCodesArray.filter{ ($0.scratchCode == codeTF.text) }
                if list3.count == 0 {
                    DispatchQueue.main.async {
                        self.captureSession.stopRunning()
                    }
                    self.codeGenuineAPI(code: codeTF.text ?? "")
                } else {
                    if self.selectedindex == 1 {
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "Code is already scanned"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                        self.isscannedOnce = true
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                            self.captureSession.startRunning()
                        })
                        self.shadowView.isHidden = true
                        
                    } else if self.selectedindex == 2 {
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.descriptionInfo = "Code is already uploaded"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                        self.isscannedOnce = true
    //                    self.session.startRunning()
                        self.shadowView.isHidden = true
                        
                    }
                }

            }
            
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
            let charsLimit = 12
            let startingLength = codeTF.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            return newLength <= charsLimit
    }
    
    @IBAction func scanAgain(_ sender: Any) {
        self.scannerVM.codeGenuineResponse?.plantCode = ""
        self.scannerVM.codeGenuineResponse?.plantName = ""
        self.scannerVM.codeGenuineResponse?.qrUsegereport?[0].printDate = ""
        self.scannerVM.codeGenuineResponse?.qrUsegereport?[0].productId = 0
        self.scannerVM.codeGenuineResponse?.qrUsegereport?[0].productName = ""
        self.scannerVM.codeGenuineResponse?.returnMessage = ""
        self.scannerVM.codeGenuineResponse?.qrUsegereport?[0].scratchCode = ""
        self.scannerVM.codeGenuineResponse?.qrUsegereport?[0].thickness = ""
        self.scannerVM.codeGenuineResponse?.qrUsegereport?[0].size = ""
        self.scannerVM.codeGenuineResponse?.qrUsegereport?[0].brandId = 0
        self.scannerVM.codeGenuineResponse?.qrUsegereport?[0].memberName = ""
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
            self.isscannedOnce = true
            self.captureSession.startRunning()
            self.shadowView.isHidden = true
        })
    }
    
    @IBAction func generateEWarrantyBottom(_ sender: Any) {
        //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
        if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" {
            self.generateEwarranty.isHidden = true
            self.generateEWarrantyBottom.isHidden = true
            
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GnerateEWarrantyViewController") as? GnerateEWarrantyViewController
            self.captureSession.stopRunning()
            vc!.tempStoreCodesArray = scannerVM.validStoreCodesArray
            vc!.CodesArray = scannerVM.GenuineCodesArray
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func generateEwarranty(_ sender: Any) {
       //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
        if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" {
            self.generateEwarranty.isHidden = true
            self.generateEWarrantyBottom.isHidden = true
            
        }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "GnerateEWarrantyViewController") as? GnerateEWarrantyViewController
            self.captureSession.stopRunning()
            vc!.tempStoreCodesArray = scannerVM.validStoreCodesArray
            vc!.CodesArray = scannerVM.GenuineCodesArray
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.shadowView.isHidden = true
        if self.selectedindex == 1{
            self.isscannedOnce = true
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                self.captureSession.startRunning()
            })
        }else{
            self.isscannedOnce = true
            self.captureSession.stopRunning()
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        if self.scannerVM.tempStoreCodesArray.count == 0{
            self.navigationController?.popViewController(animated: true)
        }else{
                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
            if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" {
            self.navigationController?.popViewController(animated: true)

                }else{
                    let filteredArray = self.scannerVM.tempStoreCodesArray.filter { $0.status == "1"}
                    let filteredAnotherArray = self.scannerVM.tempStoreCodesArray.filter { $0.status == "4"}
                    if filteredArray.count != 0 || filteredAnotherArray.count != 0 {
                        DispatchQueue.main.async{
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Popup3ViewController") as? Popup3ViewController
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.itsFrom = "Scanner"
                            vc!.discriptionInfo = "Are you sure want to exit without generating E-Warranty?"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.present(vc!, animated: true, completion: nil)
                        }
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
      
            }
    }
    
    func InitialSetups(){
        print(UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1", "- Customer Type")
        //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"  || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"
        if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
            self.generateEwarranty.isHidden = true
        }else{
            self.generateEwarranty.isHidden = false
        }
       
    }
    
    func startLiveVideo() {
        DispatchQueue.main.async {
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
            guard let captureDevice = AVCaptureDevice.default(for: .video) else {
                print("Failed to get the camera device")
                return
            }

            do {
                // Get an instance of the AVCaptureDeviceInput class using the previous device object.
                let input = try AVCaptureDeviceInput(device: captureDevice)
                self.captureSession.addInput(input)
                self.captureSession.addOutput(self.captureMetadataOutput)
                self.captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                self.captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
                
                self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                self.videoPreviewLayer?.frame = self.scanCodeView.layer.bounds
                self.scanCodeView.layer.addSublayer(self.videoPreviewLayer!)
                self.captureSession.startRunning()
                self.isscannedOnce = true

            } catch {
                // If any error occurs, simply print it out and don't continue any more.
                print(error)
                return
            }
        }
    }
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            print("NO QR CODE DETECTED")

            return
        }

        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds

            if metadataObj.stringValue != nil {
                print(metadataObj.stringValue)
                if self.isscannedOnce == true{
                    self.isscannedOnce = false
                self.captureSession.stopRunning()
                    if metadataObj.stringValue!.count <= 11{
                    self.alertValidationfor12digits(code: metadataObj.stringValue!)
                }else{
                    var list3 = [QrUsegereport1]()
                    list3 = self.scannerVM.tempStoreCodesArray
                    if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" {
                    //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                        if list3.count >= 10{
                            if self.selectedindex == 1{
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.descriptionInfo = "Your daily Scanning limit exceeded"
                                    vc!.modalPresentationStyle = .overCurrentContext
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.present(vc!, animated: true, completion: nil)
                                }
                                self.isscannedOnce = true
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                                    self.captureSession.startRunning()
                                })
                                self.shadowView.isHidden = true
                                
                            } else if self.selectedindex == 2{
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.descriptionInfo = "Your daily Scanning limit exceeded"
                                    vc!.modalPresentationStyle = .overCurrentContext
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.present(vc!, animated: true, completion: nil)
                                }
                                self.isscannedOnce = true
                                   // self.session.startRunning()
                                self.shadowView.isHidden = true
                                
                            }

                        }else{
                            list3 = self.scannerVM.tempStoreCodesArray.filter{ ($0.scratchCode == metadataObj.stringValue!) }
                            if list3.count == 0 {
                                DispatchQueue.main.async {
                                    self.captureSession.stopRunning()
                                }
                                self.codeGenuineAPI(code: metadataObj.stringValue ?? "")
                            } else {
                                if self.selectedindex == 1 {
                                    DispatchQueue.main.async{
                                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                        vc!.delegate = self
                                        vc!.titleInfo = ""
                                        vc!.descriptionInfo = "Code is already scanned"
                                        vc!.modalPresentationStyle = .overCurrentContext
                                        vc!.modalTransitionStyle = .crossDissolve
                                        self.present(vc!, animated: true, completion: nil)
                                    }
                                    self.isscannedOnce = true
                                    DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                                        self.captureSession.startRunning()
                                    })
                                    self.shadowView.isHidden = true
                                    
                                } else if self.selectedindex == 2{
                                    DispatchQueue.main.async{
                                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                        vc!.delegate = self
                                        vc!.titleInfo = ""
                                        vc!.descriptionInfo = "Code is already uploaded"
                                        vc!.modalPresentationStyle = .overCurrentContext
                                        vc!.modalTransitionStyle = .crossDissolve
                                        self.present(vc!, animated: true, completion: nil)
                                    }
                                    self.isscannedOnce = true
//                                    self.session.startRunning()
                                    self.shadowView.isHidden = true
                                    
                                }
                            }
                        }
                    }else{
                        list3 = self.scannerVM.tempStoreCodesArray.filter{ ($0.scratchCode == metadataObj.stringValue!) }
                        if list3.count == 0 {
                            DispatchQueue.main.async {
                                self.captureSession.stopRunning()
                            }
                            self.codeGenuineAPI(code: metadataObj.stringValue ?? "")
                        } else {
                            if self.selectedindex == 1{
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.descriptionInfo = "Code is already scanned"
                                    vc!.modalPresentationStyle = .overCurrentContext
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.present(vc!, animated: true, completion: nil)
                                }
                                self.isscannedOnce = true
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                                    self.captureSession.startRunning()
                                })
                                self.shadowView.isHidden = true
                                
                            } else if self.selectedindex == 2{
                                DispatchQueue.main.async{
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                    vc!.delegate = self
                                    vc!.titleInfo = ""
                                    vc!.descriptionInfo = "Code is already uploaded"
                                    vc!.modalPresentationStyle = .overCurrentContext
                                    vc!.modalTransitionStyle = .crossDissolve
                                    self.present(vc!, animated: true, completion: nil)
                                }
                                self.isscannedOnce = true
//                                    self.session.startRunning()
                                self.shadowView.isHidden = true
                                
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.captureSession.stopRunning()
                    }
                  
                }
                }else{
                    DispatchQueue.main.async {
                        self.captureSession.stopRunning()
                    }
                    return
                }
            }
        }
    }
 
    
    func alertValidationfor12digits(code:String){
        
        DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
            vc!.delegate = self
            vc!.titleInfo = ""
            vc!.itsFrom = "ValidateQRCode"
            vc!.descriptionInfo = "Invalid QR code ! QR code should be 12 character"
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    func alertWithAction(title:String, message: String){
        print(UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" , "Customer Type")
        print(title , "Title")
        print(message , "Message")
        var customerType = UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1"
        if customerType != "-1" {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                vc!.delegate = self
                vc!.itsFrom = "ScannerAlertPopUp"
                vc!.titleInfo = title
                vc!.descriptionInfo = message
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }
        
    }
}


extension CP_Scanner_VC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scannerVM.tempStoreCodesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CP_CodesScanned_TVC", for: indexPath) as? CP_CodesScanned_TVC
        cell!.delegate = self
        cell!.datelabel.text = Date.getCurrentDate()
        print(self.scannerVM.tempStoreCodesArray[indexPath.row].status ?? "", "Ddsafsadfasdfasdf")
        if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "-1"{
            cell?.genuineProductLabel.text = "Not a Sharon Ply Genuine Product"
            cell?.statusLabel.text = "Failed"
            cell?.statusImage.image = UIImage(named: "cross")
            cell?.statusLabel.textColor = UIColor.red

        }else if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "-2"{
            if self.scannerVM.checkMessage != "Kindly check download menu for the e-warranty" {
                cell?.genuineProductLabel.text = "This code is already scanned and E - warranty generated by \(self.scannerVM.tempStoreCodesArray[indexPath.row].memberName ?? "")"
                cell?.statusLabel.text = "Failed"
                cell?.statusImage.image = UIImage(named: "cross")
                cell?.statusLabel.textColor = UIColor.red
                
            } else {
                cell?.genuineProductLabel.text = "Sharon Ply Genuine Product "
                cell?.statusLabel.text = "Successful"
                cell?.statusImage.image = UIImage(named: "checked")

            }
        } else if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "3"{
            cell?.genuineProductLabel.text = self.scannerVM.message
            cell?.statusLabel.text = "Successful"
            cell?.statusImage.image = UIImage(named: "checked")

        }else if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "-3"{
            cell?.genuineProductLabel.text = "You are not entitled to this product."
            cell?.statusLabel.text = "Failed"
            cell?.statusImage.image = UIImage(named: "cross")
            cell?.statusLabel.textColor = UIColor.red

        } else if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "5"{
            cell?.genuineProductLabel.text = self.scannerVM.message2
            cell?.statusLabel.text = "Successful"
            cell?.statusImage.image = UIImage(named: "checked")
        }else{
            cell?.genuineProductLabel.text = "Sharon Ply Genuine Product "
            cell?.statusLabel.text = "Successful"
            cell?.statusImage.image = UIImage(named: "checked")

        }
        cell?.productName.text = "Code : \(self.scannerVM.tempStoreCodesArray[indexPath.row].scratchCode ?? "")"
//        let split = self.scannerVM.tempStoreCodesArray[indexPath.row].ScratchCode ?? ""
//               let qrsplit = split.components(separatedBy: "//")
//               cell?.productName.text = "Code :\(qrsplit[1])"
        print("Entered Code is:",self.scannerVM.tempStoreCodesArray[indexPath.row].scratchCode ?? "")
        return cell!
    }
    
    func closeBtn(_ cell: CP_CodesScanned_TVC) {
        guard let tappedIndexPath = codetableView.indexPath(for: cell) else { return }
        for itm in self.scannerVM.validStoreCodesArray{
            if self.scannerVM.tempStoreCodesArray[tappedIndexPath.row].productId ?? 0 == itm.productId ?? 0{
                print(itm.codeStatusWiseCount,"CodesCocunt")
                if itm.codeStatusWiseCount == 1{
                    print("ONLY 1 ITEM")
                    self.scannerVM.validStoreCodesArray = self.scannerVM.validStoreCodesArray.filter{$0.productId != itm.productId}
                }else{
                    print("MORE THAN 1 ITEM")
                    
//                    guard data.qrUsegereport?.count != 0 else{
//                        print("data is not comming")
//                        return
//
//                    }

                    for data in self.scannerVM.validStoreCodesArray.enumerated(){
                        if data.element.productId == itm.productId{
                            self.scannerVM.validStoreCodesArray[data.offset].codeStatusWiseCount! += 1
                        }
                    }
                    
//                    self.scannerVM.validStoreCodesArray.filter({$0.productId == itm.productId})[0].codeStatusWiseCount = (self.scannerVM.validStoreCodesArray.filter({$0.productId == itm.productId}).first?.codeStatusWiseCount)! - 1
                }
            }
        }
        self.scannerVM.tempStoreCodesArray.remove(at: tappedIndexPath.row)
        self.codetableView.reloadData()
        if self.scannerVM.validStoreCodesArray.count == 0{
            
            //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
            if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                self.generateEwarranty.isHidden = true
                self.generateEWarrantyBottom.isHidden = true
                
            }else{
                self.generateEwarranty.isHidden = true
                self.generateEWarrantyBottom.isHidden = true
            }
          
        }else{
            //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
            if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
            self.generateEwarranty.isHidden = true
                self.generateEWarrantyBottom.isHidden = true
                
            }else{
                self.generateEwarranty.isHidden = false
                self.generateEWarrantyBottom.isHidden = false
            }
           
        }
        if self.scannerVM.tempStoreCodesArray.count == 0{
            self.codeDetails.isHidden = true
        }else{
            self.codeDetails.isHidden = false
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.scannerVM.tempStoreCodesArray[indexPath.row].status ?? "-1" != "-1"{
            self.productname.text = self.scannerVM.tempStoreCodesArray[indexPath.row].productName ?? ""
//            self.plantName.text = self.scannerVM.tempStoreCodesArray[indexPath.row].PlantName ?? ""
            self.thickness.text = self.scannerVM.tempStoreCodesArray[indexPath.row].thickness ?? ""
            self.size.text = self.scannerVM.tempStoreCodesArray[indexPath.row].size ?? ""
            self.uniqueCode.text = self.scannerVM.tempStoreCodesArray[indexPath.row].scratchCode ?? ""
            if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "1"{
                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                self.generateEwarranty.isHidden = true
                }else{
                    self.generateEwarranty.isHidden = false
                }
                DispatchQueue.main.async {
                    self.captureSession.stopRunning()
                }
                self.statusLabel.text = "Sharon Ply Genuine Product "
            } else if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "-2"{
                DispatchQueue.main.async {
                    self.captureSession.stopRunning()
                }
                if self.scannerVM.checkMessage != "Kindly check download menu for the e-warranty" {
                    self.statusLabel.text = "This code is already scanned and E - warranty generated by \(self.scannerVM.tempStoreCodesArray[indexPath.row].memberName ?? "")"
                } else {
                    self.statusLabel.text = "Sharon Ply Genuine Product "
                }
            } else if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "3" {
                    return
            }else if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "-3" {
                self.statusLabel.text = "not entitled to Product "
                return
        } else if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "5" {
                    return
            } else if self.scannerVM.tempStoreCodesArray[indexPath.row].status == "4" {
                DispatchQueue.main.async {
                    self.captureSession.stopRunning()
                }
                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                self.generateEwarranty.isHidden = true
                }else{
                    self.generateEwarranty.isHidden = false
                }
                self.statusLabel.text = "Sharon Ply Genuine Product "
            } else {
                self.generateEwarranty.isHidden = true
                self.statusLabel.text = "Sharon Ply Genuine Product "
            }
        
            self.shadowView.isHidden = false
        }else{
            DispatchQueue.main.async{
                self.stopLoading()
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.itsFrom = ""
                vc!.descriptionInfo = "Not a Sharon Ply Genuine Product"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }
    }
}


extension CP_Scanner_VC{
    func codeGenuineAPI(code: String){
        let parameter : [String : Any] = [
                "ActionType": 3,
                "ActorId": "\(userID)",
                "SCRATCH_CODE": code
        ]
        
        self.scannerVM.codeGenuineAPI(code: code, parameter: parameter)
    }
}
