//
//  EditAddressViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Firebase

protocol SendUpdatedAddressDelegate {
    func updatedAddressDetails(_ vc: EditAddressViewController)
}
class EditAddressViewController: BaseViewController, UITextFieldDelegate, SelectedItemDelegate, popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
    }
    
  
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var mobileTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var countryTF: UITextField!
    @IBOutlet var stateButton: UIButton!
    @IBOutlet var cityButton: UIButton!
    @IBOutlet var zipCodeTF: UITextField!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var defaultAddress: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var zip: UILabel!
    @IBOutlet weak var saveChanges: GradientButton!
    
    var delegate: SendUpdatedAddressDelegate?
    var selectedname = ""
    var selectedemail = ""
    var selectedmobile = ""
    var selectedState = ""
    var selectedStateID = 0
    var selectedCity = ""
    var selectedCityID = 0
    var selectedaddress = ""
    var selectedpincode = ""
    var selectedCountryId = 0
    var selectedCountry = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languagelocalization()
        print(selectedmobile,"MobileNumber")
        self.zipCodeTF.keyboardType = .numberPad
        self.mobileTF.keyboardType = .numberPad
        self.zipCodeTF.delegate = self
        self.mobileTF.delegate = self
        self.nameTF.text = selectedname
        self.mobileTF.text = selectedmobile
        self.emailTF.text = selectedemail
        self.addressTF.text = selectedaddress
        self.countryTF.text = "India"
        self.stateButton.setTitle(selectedState, for: .normal)
        self.cityButton.setTitle(selectedCity, for: .normal)
        self.zipCodeTF.text = selectedpincode
        print(self.selectedmobile, "Mobile Number")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Edit Address")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            
            self.header.text = "Edit Address"
            self.defaultAddress.text = "Default Address"
            self.country.text = "Country"
            
            self.name.text = "eaNameKEY".localizableString(loc: "en")
            self.mobile.text = "eaMobileKEY".localizableString(loc: "en")
            self.email.text = "eaEmailKEY".localizableString(loc: "en")
            self.address.text = "eaAddressKEY".localizableString(loc: "en")
            self.state.text = "eaStateKEY".localizableString(loc: "en")
            self.city.text = "eaCityKEY".localizableString(loc: "en")
            self.zip.text = "eaPinKEY".localizableString(loc: "en")
            self.saveChanges.setTitle("coProceedKEY".localizableString(loc: "en"), for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.header.text = "पता संपादित करें"
            self.defaultAddress.text = "डिफ़ॉल्ट पता"
            self.country.text = "देश"
            
            self.name.text = "eaNameKEY".localizableString(loc: "hi")
            self.mobile.text = "eaMobileKEY".localizableString(loc: "hi")
            self.email.text = "eaEmailKEY".localizableString(loc: "hi")
            self.address.text = "eaAddressKEY".localizableString(loc: "hi")
            self.state.text = "eaStateKEY".localizableString(loc: "hi")
            self.city.text = "eaCityKEY".localizableString(loc: "hi")
            self.zip.text = "eaPinKEY".localizableString(loc: "hi")
            self.saveChanges.setTitle("coProceedKEY".localizableString(loc: "hi"), for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            
            self.header.text = "முகவரியைத் திருத்தவும்"
            self.defaultAddress.text = "இயல்புநிலை முகவரி"
 
            self.country.text = "நாடு"
            
            self.name.text = "eaNameKEY".localizableString(loc: "ta-IN")
            self.mobile.text = "eaMobileKEY".localizableString(loc: "ta-IN")
            self.email.text = "eaEmailKEY".localizableString(loc: "ta-IN")
            self.address.text = "eaAddressKEY".localizableString(loc: "ta-IN")
            self.state.text = "eaStateKEY".localizableString(loc: "ta-IN")
            self.city.text = "eaCityKEY".localizableString(loc: "ta-IN")
            self.zip.text = "eaPinKEY".localizableString(loc: "ta-IN")
            self.saveChanges.setTitle("coProceedKEY".localizableString(loc: "ta-IN"), for: .normal)
        }else{
            
            self.header.text = "చిరునామాను సవరించండి"
            self.defaultAddress.text = "డిఫాల్ట్ చిరునామా"
            self.country.text = "దేశం"
            
            self.name.text = "eaNameKEY".localizableString(loc: "te")
            self.mobile.text = "eaMobileKEY".localizableString(loc: "te")
            self.email.text = "eaEmailKEY".localizableString(loc: "te")
            self.address.text = "eaAddressKEY".localizableString(loc: "te")
            self.state.text = "eaStateKEY".localizableString(loc: "te")
            self.city.text = "eaCityKEY".localizableString(loc: "te")
            self.zip.text = "eaPinKEY".localizableString(loc: "te")
            self.saveChanges.setTitle("coProceedKEY".localizableString(loc: "te"), for: .normal)
        }
    }
    
    @IBAction func selectStateBTN(_ sender: Any) {
        if self.selectedCountryId == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Select Country"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "देश चुनें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "দেশ নির্বাচন করুন"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "దేశాన్ని ఎంచుకోండి"
                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "No Internet"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "इंटरनेट नहीं है"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "কোন ইন্টারনেট নেই"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "ఇంటర్నెట్ లేదు"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DropDownVC") as? DropDownVC
                vc!.delegate = self
                vc!.isComeFrom = 1
                vc!.selectedCountryId = self.selectedCountryId
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }
        
    }
    @IBAction func selectCityBTN(_ sender: Any) {
        if self.selectedStateID == 0 || self.selectedCountryId == 0{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Select State"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "राज्य चुनें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "রাজ্য নির্বাচন কর"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "రాష్ట్రం ఎంచుకోండి"
                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "No Internet"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                        vc!.descriptionInfo = "इंटरनेट नहीं है"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "কোন ইন্টারনেট নেই"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "ఇంటర్నెట్ లేదు"
                    }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DropDownVC") as? DropDownVC
                vc!.delegate = self
                vc!.isComeFrom = 2
                vc!.selectedStateId = selectedStateID
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }
        
       
    }
    
    
    @IBAction func saveChangesButton(_ sender: Any) {

         if nameTF.text?.count == 0{
             DispatchQueue.main.async{
                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                 vc!.delegate = self
                 vc!.titleInfo = ""
                 
                 if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                     vc!.descriptionInfo = "Enter Name"
                  }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                      vc!.descriptionInfo = "नाम दर्ज करें"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                     vc!.descriptionInfo = "নাম লিখুন"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                     vc!.descriptionInfo = "పేరు నమోదు చేయండి"
                   }
                 vc!.modalPresentationStyle = .overFullScreen
                 vc!.modalTransitionStyle = .crossDissolve
                 self.present(vc!, animated: true, completion: nil)
             }
             
         }else if mobileTF.text?.count == 0 {
             DispatchQueue.main.async{
                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                 vc!.delegate = self
                 vc!.titleInfo = ""
                 
                 if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                     vc!.descriptionInfo = "Enter Mobile Number"
                  }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                      vc!.descriptionInfo = "मोबाइल नंबर डालें"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                     vc!.descriptionInfo = "মোবাইল নম্বর লিখুন"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                     vc!.descriptionInfo = "మొబైల్ నంబర్ ఎంటర్ చేయండి"
                   }
                 vc!.modalPresentationStyle = .overFullScreen
                 vc!.modalTransitionStyle = .crossDissolve
                 self.present(vc!, animated: true, completion: nil)
             }
             
         }else if mobileTF.text?.count != 10 {
             DispatchQueue.main.async{
                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                 vc!.delegate = self
                 vc!.titleInfo = ""
               
                 if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                     vc!.descriptionInfo = "Enter Valid Mobile Number"
                  }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                      vc!.descriptionInfo = "वैध मोबाइल नंबर दर्ज करें"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                     vc!.descriptionInfo = "বৈধ মোবাইল নম্বর লিখুন"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                     vc!.descriptionInfo = "చెల్లుబాటయ్యే మొబైల్ నంబర్‌ని నమోదు చేయండిr"
                   }
                 vc!.modalPresentationStyle = .overFullScreen
                 vc!.modalTransitionStyle = .crossDissolve
                 self.present(vc!, animated: true, completion: nil)
             }
             
         }
//        else if emailTF.text?.count == 0{
//             DispatchQueue.main.async{
//                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                 vc!.delegate = self
//                 vc!.titleInfo = ""
//                 vc!.descriptionInfo = "Enter EmailID"
//                 vc!.modalPresentationStyle = .overFullScreen
//                 vc!.modalTransitionStyle = .crossDissolve
//                 self.present(vc!, animated: true, completion: nil)
//             }
//             
//         }
//        else  if !isValidEmail(emailTF.text ?? "") {
//             DispatchQueue.main.async{
//                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                 vc!.delegate = self
//                 vc!.titleInfo = ""
//                 vc!.descriptionInfo = "Enter Valid EmailID"
//                 vc!.modalPresentationStyle = .overCurrentContext
//                 vc!.modalTransitionStyle = .crossDissolve
//                 self.present(vc!, animated: true, completion: nil)
//                 }
//             }
        else if addressTF.text?.count == 0{
             DispatchQueue.main.async{
                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                 vc!.delegate = self
                 vc!.titleInfo = ""
            
                 if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                     vc!.descriptionInfo = "Enter Address"
                  }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                      vc!.descriptionInfo = "पता दर्ज करें"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                     vc!.descriptionInfo = "ঠিকানা লিখুন"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                     vc!.descriptionInfo = "చిరునామా నమోదు చేయండి"
                   }
                 vc!.modalPresentationStyle = .overFullScreen
                 vc!.modalTransitionStyle = .crossDissolve
                 self.present(vc!, animated: true, completion: nil)
             }
             
        }else if stateButton.currentTitle == "Select State" || stateButton.currentTitle == "" || stateButton.currentTitle == nil{
             DispatchQueue.main.async{
                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                 vc!.delegate = self
                 vc!.titleInfo = ""
                 
                 
                 if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                     vc!.descriptionInfo = "Select State"
                  }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                      vc!.descriptionInfo = "राज्य चुनें"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                     vc!.descriptionInfo = "রাজ্য নির্বাচন করুন৷"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                     vc!.descriptionInfo = "స్టేట్‌ని ఎంచుకోండి"
                   }
                 vc!.modalPresentationStyle = .overFullScreen
                 vc!.modalTransitionStyle = .crossDissolve
                 self.present(vc!, animated: true, completion: nil)
             }
             
        }else if cityButton.currentTitle == "Select City" || self.cityButton.currentTitle == "" || self.cityButton.currentTitle == nil{
             DispatchQueue.main.async{
                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                 vc!.delegate = self
                 vc!.titleInfo = ""
                 
                 if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                     vc!.descriptionInfo = "Select City"
                  }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                      vc!.descriptionInfo = "शहर चुनें"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                     vc!.descriptionInfo = "শহর নির্বাচন করুন"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                     vc!.descriptionInfo = "సిటీని ఎంచుకోండి"
                   }
                 vc!.modalPresentationStyle = .overFullScreen
                 vc!.modalTransitionStyle = .crossDissolve
                 self.present(vc!, animated: true, completion: nil)
             }
             
         }else if zipCodeTF.text?.count == 0{
             DispatchQueue.main.async{
                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                 vc!.delegate = self
                 vc!.titleInfo = ""
               
                 if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                     vc!.descriptionInfo = "Enter Pin"
                  }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                      vc!.descriptionInfo = "पिन डालें"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                     vc!.descriptionInfo = "পিন লিখুন"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                     vc!.descriptionInfo = "పిన్ ఎంటర్ చేయండి"
                   }
                 vc!.modalPresentationStyle = .overFullScreen
                 vc!.modalTransitionStyle = .crossDissolve
                 self.present(vc!, animated: true, completion: nil)
             }
             
         }else if zipCodeTF.text?.count != 6{
             DispatchQueue.main.async{
                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                 vc!.delegate = self
                 vc!.titleInfo = ""
               
                 if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                     vc!.descriptionInfo = "Enter Valid Zip"
                  }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                      vc!.descriptionInfo = "मान्य ज़िप दर्ज करें"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                     vc!.descriptionInfo = "বৈধ জিপ লিখুন"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                     vc!.descriptionInfo = "చెల్లుబాటయ్యే జిప్‌ని నమోదు చేయండి"
                   }
                 vc!.modalPresentationStyle = .overFullScreen
                 vc!.modalTransitionStyle = .crossDissolve
                 self.present(vc!, animated: true, completion: nil)
             }
             
         }else{
           print(self.addressTF.text ?? "")
             print(self.mobileTF.text ?? "")
             print(self.emailTF.text ?? "")
             print(self.selectedCity)
             print(self.selectedState)
             print(self.zipCodeTF.text ?? "")
             print(self.emailTF.text ?? "")

             self.selectedname = self.nameTF.text ?? ""
             self.selectedmobile = self.mobileTF.text ?? ""
             self.selectedemail = self.emailTF.text ?? ""
             self.selectedpincode = self.zipCodeTF.text ?? ""
             self.selectedaddress = self.addressTF.text ?? ""
            self.delegate!.updatedAddressDetails(self)
             self.navigationController?.popViewController(animated: true)
         }
     
        
     }
 

    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let maxLength = 10
//        let otpLength = 6
//        if textField == mobileTF{
//            let currentString: NSString = (mobileTF.text ?? "") as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        }else if textField == zipCodeTF{
//            let currentString: NSString = (zipCodeTF.text ?? "") as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= otpLength
//        }
//        return true
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")
      if string == numberFiltered {
          if textField == mobileTF{
              let currentText = mobileTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 10
          }else if textField == zipCodeTF {
              let currentText = zipCodeTF.text ?? ""
              guard let stringRange = Range(range, in: currentText) else { return false }
              let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
              return updatedText.count <= 6
          }
      
      } else {
        return false
      }
        return false
    }
    func isValidPhone(testStr:String) -> Bool {
        let phoneRegEx = "^[6-9]\\d{9}$"
        let phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneNumber.evaluate(with: testStr)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    //Delegate:-
    
    func didSelectedItem(_ vc: DropDownVC) {
        print(vc.selectedTitle)
        print(vc.selectedId)
        if vc.isComeFrom == 1{
            self.stateButton.setTitle(vc.selectedTitle, for: .normal)
            self.selectedState = vc.selectedTitle
            self.selectedStateID = Int(vc.selectedId) ?? 0
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                self.cityButton.setTitle("Select City", for: .normal)
             }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                 self.cityButton.setTitle("शहर चुनें", for: .normal)
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                self.cityButton.setTitle("শহর নির্বাচন করুন", for: .normal)
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                self.cityButton.setTitle("సిటీని ఎంచుకోండి", for: .normal)
              }
           
        }else if vc.isComeFrom == 2{
            self.cityButton.setTitle(vc.selectedTitle, for: .normal)
            self.selectedCity = vc.selectedTitle
            self.selectedCityID = Int(vc.selectedId) ?? 0
        }
    }
    
    
}
