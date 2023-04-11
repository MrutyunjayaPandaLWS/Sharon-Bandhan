//
//  PancardViewController.swift
//  CenturyPly_JSON
//
//  Created by admin on 26/10/22.
//

import UIKit
import Photos
import AVFoundation
import Firebase
import LanguageManager_iOS
class PancardViewController: BaseViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var panNumberLbl: UILabel!
    @IBOutlet weak var myProfile: UILabel!
    @IBOutlet weak var myPanDetails: UILabel!
    @IBOutlet weak var kindlyUploadLbl: UILabel!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var successmeassage: UILabel!
    @IBOutlet weak var SuccessshadowView: UIView!
    @IBOutlet weak var borderview: UILabel!
    @IBOutlet weak var saveButton: GradientButton!
    @IBOutlet weak var panImage: UIImageView!
    @IBOutlet weak var panattachmet: UIButton!
    @IBOutlet weak var panattachment: UIButton!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var nameofPerson: UILabel!
    @IBOutlet weak var pannumber: UILabel!
    @IBOutlet weak var validateButtonn: GradientButton!
    @IBOutlet weak var panNumberTF: UITextField!
    
    @IBOutlet var imagePanCons: NSLayoutConstraint!
    var vm = PancardViewModel()
    var iscomefrom = -1
    let picker = UIImagePickerController()
    var strdata1 = ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    var stopSendingData = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        if self.iscomefrom == 1{
            self.panstack.isHidden = true
        }
        panNumberTF.keyboardType = .asciiCapable
        self.validateButtonn.setTitle("Verify", for: .normal)
        self.panNumberTF.delegate = self
        self.dobLabel.isHidden = true
        self.nameofPerson.isHidden = true
        self.panattachmet.isHidden = true
        self.panattachment.isHidden = true
        self.pannumber.isHidden = true
        self.validateButtonn.isHidden = false
        self.panImage.isHidden = true
        self.saveButton.isHidden = true
        self.borderview.isHidden = true
        self.picker.delegate = self
        self.languagelocalization()
        
        let parameterJSON = [
               "ActorId":"\(userID)",
               "ActionType":"4",
               "LoyaltyId":"\(loyaltyId)"
        ]
        print(parameterJSON)
        self.vm.pancarddetailsApi(parameters: parameterJSON)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Pancard Details")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.panNumberTF.text = self.panNumberTF.text?.uppercased()
        if textField == panNumberTF{
            let currentCharacterCount = panNumberTF.text?.count ?? 0
                   if (range.length + range.location > currentCharacterCount){
                       return false
                   }
                   let newLength = currentCharacterCount + string.count - range.length
                   return newLength <= 10
        }
        return true
    }
    
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.headerTitle.text = "PanVerification".localizableString(loc: "en")
            self.successmeassage.text = "customerPANDetails".localizableString(loc: "en")
            self.myPanDetails.text = "myPanDetails".localizableString(loc: "en")
            self.myProfile.text = "myProfile".localizableString(loc: "en")
            self.saveButton.setTitle("Save".localizableString(loc: "en"), for: .normal)
            self.panattachment.setTitle("PANAttachment".localizableString(loc: "en"), for: .normal)
            self.validateButtonn.setTitle("Validate".localizableString(loc: "en"), for: .normal)
            self.panNumberTF.placeholder = "enterPanNum".localizableString(loc: "en")
            self.panNumberLbl.text = "PANnumbeer".localizableString(loc: "en")
            self.kindlyUploadLbl.text = "kindlyUploadDetails".localizableString(loc: "en")
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.headerTitle.text = "PanVerification".localizableString(loc: "hi")
            self.successmeassage.text = "customerPANDetails".localizableString(loc: "hi")
            self.myPanDetails.text = "myPanDetails".localizableString(loc: "hi")
            self.myProfile.text = "myProfile".localizableString(loc: "hi")
            self.saveButton.setTitle("Save".localizableString(loc: "hi"), for: .normal)
            self.panattachment.setTitle("PANAttachment".localizableString(loc: "hi"), for: .normal)
            self.validateButtonn.setTitle("Validate".localizableString(loc: "hi"), for: .normal)
            self.panNumberTF.placeholder = "enterPanNum".localizableString(loc: "hi")
            self.panNumberLbl.text = "PANnumbeer".localizableString(loc: "hi")
            self.kindlyUploadLbl.text = "kindlyUploadDetails".localizableString(loc: "hi")
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.headerTitle.text = "PanVerification".localizableString(loc: "bn")
            self.successmeassage.text = "customerPANDetails".localizableString(loc: "bn")
            self.myPanDetails.text = "myPanDetails".localizableString(loc: "bn")
            self.myProfile.text = "myProfile".localizableString(loc: "bn")
            self.saveButton.setTitle("Save".localizableString(loc: "bn"), for: .normal)
            self.panattachment.setTitle("PANAttachment".localizableString(loc: "bn"), for: .normal)
            self.validateButtonn.setTitle("Validate".localizableString(loc: "bn"), for: .normal)
            self.panNumberTF.placeholder = "enterPanNum".localizableString(loc: "bn")
            self.panNumberLbl.text = "PANnumbeer".localizableString(loc: "bn")
            self.kindlyUploadLbl.text = "kindlyUploadDetails".localizableString(loc: "bn")
        }else{
            
            self.headerTitle.text = "PanVerification".localizableString(loc: "te")
            self.successmeassage.text = "customerPANDetails".localizableString(loc: "te")
            self.myPanDetails.text = "myPanDetails".localizableString(loc: "te")
            self.myProfile.text = "myProfile".localizableString(loc: "te")
            self.saveButton.setTitle("Save".localizableString(loc: "te"), for: .normal)
            self.panattachment.setTitle("PANAttachment".localizableString(loc: "te"), for: .normal)
            self.validateButtonn.setTitle("Validate".localizableString(loc: "te"), for: .normal)
            self.panNumberTF.placeholder = "enterPanNum".localizableString(loc: "te")
            self.panNumberLbl.text = "PANnumbeer".localizableString(loc: "te")
            self.kindlyUploadLbl.text = "kindlyUploadDetails".localizableString(loc: "te")
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if self.imagePanCons.constant == 120{
            let parameter = [
                "ActionType": "3",
                "PanNumber": "\(self.vm.resultData?.objPanDetailsRetrieverequest?.panNumber ?? "")",
                "FirstName": "\(self.vm.resultData?.objPanDetailsRetrieverequest?.firstName ?? "")",
                "DateOfBirth": "\(self.vm.resultData?.objPanDetailsRetrieverequest?.dateOfBirth ?? "")",
                "IsPanValid" : "\(self.vm.resultData?.objPanDetailsRetrieverequest?.isPanValid ?? -1)",
                "PanImage": "\(self.strdata1)",
                "LoyaltyId": "\(self.loyaltyId)"
            ]
            print(parameter)
            self.vm.pancardSaveApi(parameters: parameter)
        }else{
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                alertTypeWithoutAction(alertheading: "", alertMessage: "Pan attachment required", buttonTitle: "Ok")
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                alertTypeWithoutAction(alertheading: "", alertMessage: "पैन अटैचमेंट आवश्यक है", buttonTitle: "ठीक")
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                alertTypeWithoutAction(alertheading: "", alertMessage: "প্যান সংযুক্তি প্রয়োজন", buttonTitle: "ওকে")
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                alertTypeWithoutAction(alertheading: "", alertMessage: "పాన్ అటాచ్మెంట్ అవసరం", buttonTitle: "సరే")
            }
//            let alertController = UIAlertController(title: "", message: "Do you want to submit without PAN attachment?", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
//                UIAlertAction in
//                NSLog("OK Pressed")
//
//                let parameter = [
//                    "ActionType": "3",
//                    "PanNumber": "\(self.vm.resultData?.objPanDetailsRetrieverequest?.panNumber ?? "")",
//                    "FirstName": "\(self.vm.resultData?.objPanDetailsRetrieverequest?.firstName ?? "")",
//                    "DateOfBirth": "\(self.vm.resultData?.objPanDetailsRetrieverequest?.dateOfBirth ?? "")",
//                    "IsPanValid" : "\(self.vm.resultData?.objPanDetailsRetrieverequest?.isPanValid ?? -1)",
//                    "PanImage": "\(self.strdata1)",
//                    "LoyaltyId": "\(self.loyaltyId)"
//                ]
//                print(parameter)
//                self.vm.pancardSaveApi(parameters: parameter)
//            }
//            let cancelAct = UIAlertAction(title: "No", style: UIAlertAction.Style.default) {
//                UIAlertAction in
//                self.dismiss(animated: true)
//            }
//            alertController.addAction(okAction)
//            alertController.addAction(cancelAct)
//            // Present the controller
//            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if panNumberTF.text?.count ?? 0 < 10 {
            self.dobLabel.isHidden = true
            self.nameofPerson.isHidden = true
            self.panattachmet.isHidden = true
            self.panattachment.isHidden = true
            self.pannumber.isHidden = true
            self.panImage.isHidden = true
            self.saveButton.isHidden = true
            self.borderview.isHidden = true
            self.validateButtonn.isEnabled = true
        }
    }
    
    @IBAction func panNumberTFAct(_ sender: Any) {
        
        if panNumberTF.text?.count ?? 0 < 10 {
            self.dobLabel.isHidden = true
            self.nameofPerson.isHidden = true
            self.panattachmet.isHidden = true
            self.panattachment.isHidden = true
            self.pannumber.isHidden = true
            self.panImage.isHidden = true
            self.saveButton.isHidden = true
            self.borderview.isHidden = true
            self.validateButtonn.isEnabled = true
        }
    }
//    @IBAction func panNumber(_ sender: Any) {
//        self.panNumberTF.text = self.panNumberTF.text?.uppercased()
//        if panNumberTF.text?.count == 10{
////            let parameter = [
////                "PanNumber":"\(self.panNumberTF.text ?? "")"
////            ]
////            self.vm.pancardVerifyApi(parameters: parameter)
//            self.validateButtonn.isHidden = false
//
//        }else{
//            alertTypeWithoutAction(alertheading: "", alertMessage: "Enter Valid Pan Number", buttonTitle: "Ok")
//        }
//    }
    @IBOutlet weak var panstack: UIStackView!
    
    @IBAction func profile(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func pandetails(_ sender: Any) {
        
    }
    @IBAction func validateButton(_ sender: Any) {
        //            self.validateButtonn.setTitle("Verified", for: .normal)
        //            self.validateButtonn.backgroundColor = UIColor.gray
        if panNumberTF.text?.count == 10{
            let parameter = [
                "PanNumber":"\(self.panNumberTF.text ?? "")"
            ]
            print(parameter,"PanNumber")
            self.vm.pancardVerifyApi(parameters: parameter)
        }else{
            alertTypeWithoutAction(alertheading: "", alertMessage: "Please Enter Valid Pan Number", buttonTitle: "Ok")
        }
        //self.validateButtonn.isEnabled = false
        
    }
    @IBAction func panattachmentButton(_ sender: Any) {
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
    
    func alertTypeWithoutAction(alertheading: String, alertMessage: String, buttonTitle: String){
           let alert = UIAlertController(title: alertheading, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
           self.present(alert, animated: true, completion: nil)
       }
    
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
                            let alertVC = UIAlertController(title: "Need Camera access", message: "Allow", preferredStyle: .alert)
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
                    let alertVC = UIAlertController(title: "Need Camera access", message: "", preferredStyle: .alert)
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
            self.imagePanCons.constant = 120
            let imageData = selectedImage.resized(withPercentage: 0.1)
            let imageData1: NSData = imageData!.pngData()! as NSData
            self.panImage.image = selectedImage
            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
            self.stopSendingData = "CameraAndImage"
            picker.dismiss(animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
   
    
}
