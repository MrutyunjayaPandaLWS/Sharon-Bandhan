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
            self.header.text = "আমার অ্যাকাউন্ট"
            self.nativeState.text = "rNativeStateKEY".localizableString(loc: "bn")
            self.zip.text = "mpPinKEY".localizableString(loc: "bn")
            self.city.text = "rCityKEY".localizableString(loc: "bn")
            self.state.text = "rStateKEY".localizableString(loc: "bn")
            self.address.text = "rAddressKEY".localizableString(loc: "bn")
            self.email.text = "rEmailKEY".localizableString(loc: "bn")
            self.mobile.text = "rMobileKEY".localizableString(loc: "bn")
            self.districtLbl.text = "mpDistrictKEY".localizableString(loc: "bn")
            self.prefLanguage.text = "mpPreferredLanguageKEY".localizableString(loc: "bn")
            
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
                self.profileImg.sd_setImage(with: URL(string: PROMO_IMG + "\(customerImage)"), placeholderImage: UIImage(named: "icons8-test-account-96"))
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
