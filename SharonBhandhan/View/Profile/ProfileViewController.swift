//
//  ProfileViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Photos
import AVFoundation
import SDWebImage
import Firebase
class ProfileViewController: BaseViewController {
  
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var zipTF: UITextField!
    @IBOutlet weak var nativeTF: UITextField!
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var zip: UILabel!
    @IBOutlet weak var nativeState: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var prefLanguage: UILabel!
    @IBOutlet weak var prefLangTF: UITextField!
    @IBOutlet weak var districtLbl: UILabel!
    @IBOutlet weak var districtTF: UITextField!
    var VM = ProfileViewModel()
    let picker = UIImagePickerController()
    var strBase64 = ""
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var strdata1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileDetails()
        mobileTF.isEnabled = false
        emailTF.isEnabled = false
        addressTF.isEnabled = false
        countryTF.isEnabled = false
        stateTF.isEnabled = false
        cityTF.isEnabled = false
        zipTF.isEnabled = false
        nativeTF.isEnabled = false
        districtTF.isEnabled = false
        prefLangTF.isEnabled = false
        languagelocalization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "My Profile")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
        picker.delegate = self

        
    }
    
    @IBAction func pandetails(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PancardViewController") as! PancardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillLayoutSubviews() {
        self.profileImg.layer.cornerRadius = self.profileImg.frame.width / 2
        self.profileImg.layer.borderColor = UIColor.white.cgColor
        self.profileImg.layer.borderWidth = 3.0
        self.profileImg.clipsToBounds = true
        
        }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.header.text = "My Account"
            self.nativeState.text = "rNativeStateKEY".localizableString(loc: "en")
            self.zip.text = "mpPinKEY".localizableString(loc: "en")
            self.city.text = "rCityKEY".localizableString(loc: "en")
            self.state.text = "rStateKEY".localizableString(loc: "en")
            self.address.text = "rAddressKEY".localizableString(loc: "en")
            self.email.text = "rEmailKEY".localizableString(loc: "en")
            self.mobile.text = "rMobileKEY".localizableString(loc: "en")
            self.districtLbl.text = "mpDistrictKEY".localizableString(loc: "en")
            self.prefLanguage.text = "mpPreferredLanguageKEY".localizableString(loc: "en")
            
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.header.text = "मेरा खाता"
            self.nativeState.text = "rNativeStateKEY".localizableString(loc: "hi")
            self.zip.text = "mpPinKEY".localizableString(loc: "hi")
            self.city.text = "rCityKEY".localizableString(loc: "hi")
            self.state.text = "rStateKEY".localizableString(loc: "hi")
            self.address.text = "rAddressKEY".localizableString(loc: "hi")
            self.email.text = "rEmailKEY".localizableString(loc: "hi")
            self.mobile.text = "rMobileKEY".localizableString(loc: "hi")
            self.districtLbl.text = "mpDistrictKEY".localizableString(loc: "hi")
            self.prefLanguage.text = "mpPreferredLanguageKEY".localizableString(loc: "hi")
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.header.text = "என் கணக்கு"
            self.nativeState.text = "rNativeStateKEY".localizableString(loc: "ta-IN")
            self.zip.text = "mpPinKEY".localizableString(loc: "ta-IN")
            self.city.text = "rCityKEY".localizableString(loc: "ta-IN")
            self.state.text = "rStateKEY".localizableString(loc: "ta-IN")
            self.address.text = "rAddressKEY".localizableString(loc: "ta-IN")
            self.email.text = "rEmailKEY".localizableString(loc: "ta-IN")
            self.mobile.text = "rMobileKEY".localizableString(loc: "ta-IN")
            self.districtLbl.text = "mpDistrictKEY".localizableString(loc: "ta-IN")
            self.prefLanguage.text = "mpPreferredLanguageKEY".localizableString(loc: "ta-IN")
            
        }else{
            self.header.text = "నా ఖాతా"
            self.nativeState.text = "rNativeStateKEY".localizableString(loc: "te")
            self.zip.text = "mpPinKEY".localizableString(loc: "te")
            self.city.text = "rCityKEY".localizableString(loc: "te")
            self.state.text = "rStateKEY".localizableString(loc: "te")
            self.address.text = "rAddressKEY".localizableString(loc: "te")
            self.email.text = "rEmailKEY".localizableString(loc: "te")
            self.mobile.text = "rMobileKEY".localizableString(loc: "te")
            self.districtLbl.text = "mpDistrictKEY".localizableString(loc: "te")
            self.prefLanguage.text = "mpPreferredLanguageKEY".localizableString(loc: "te")
        }
    }
    @IBAction func profileButton(_ sender: Any) {
        
    }
    @IBAction func profileImageUpdateBtn(_ sender: UIButton) {
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
    
    func profileDetails(){
        let parameters = [
            "ActionType": "6",
            "CustomerId": "\(userID)"
        ] as [String: Any]
        print(parameters)
        self.VM.myProifleDetails(parameters: parameters) { response in
            DispatchQueue.main.async {
                self.stopLoading()
                let profileDetails = response?.getCustomerDetailsMobileAppResult?.lstCustomerJson ?? []
                let customerImage = String(profileDetails[0].profilePicture ?? "").dropFirst()
                self.profileImg.sd_setImage(with: URL(string: customerImageURL + "\(customerImage)"), placeholderImage: UIImage(named: "icons8-test-account-96"))
                self.name.text = profileDetails[0].firstName ?? "-"
                self.mobileTF.text = profileDetails[0].mobile ?? "-"
                self.emailTF.text = profileDetails[0].email ?? "-"
                self.addressTF.text = profileDetails[0].address1 ?? "-"
                self.countryTF.text = profileDetails[0].countryName ?? "-"
                self.stateTF.text = profileDetails[0].stateName ?? "-"
                self.cityTF.text = profileDetails[0].cityName ?? "-"
                self.zipTF.text = profileDetails[0].zip ?? "-"
                self.nativeTF.text = profileDetails[0].nativeStateName ?? "-"
                self.prefLangTF.text = profileDetails[0].languageName ?? "-"
                self.districtTF.text = profileDetails[0].district ?? "-"
            }
            
        }
    }
    

    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension ProfileViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
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
            self.profileImg.image = selectedImage
            self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
            picker.dismiss(animated: true, completion: nil)
//                self.dismiss(animated: true, completion: nil)
            self.VM.imageSubmissionAPI(base64: self.strdata1)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
