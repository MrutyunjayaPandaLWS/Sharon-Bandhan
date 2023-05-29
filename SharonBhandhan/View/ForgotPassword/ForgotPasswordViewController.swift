//
//  ForgotPasswordViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Firebase

class ForgotPasswordViewController: BaseViewController, UITextFieldDelegate, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
        if self.isSuccess == 1 {
            self.navigationController?.popViewController(animated: true)
        }
    }
    

    @IBOutlet var userNameTF: UITextField!
    @IBOutlet weak var forgetPwdTitle: UILabel!
    @IBOutlet weak var submitBTN: GradientButton!
    @IBOutlet weak var backToLogin: UILabel!
    var vm = ForgotPasswordViewModel()
    var isSuccess = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        languagelocalization()
        userNameTF.delegate = self
        self.userNameTF.keyboardType = .numberPad
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Forgot Password")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            forgetPwdTitle.text = "fpForgotPasswordKEY".localizableString(loc: "en")
            userNameTF.placeholder = "fpEnterYourRegisterdMobileNumberKEY".localizableString(loc: "en")
            submitBTN.setTitle("fpSubmitKEY".localizableString(loc: "en"), for: .normal)
            backToLogin.text = "back To Login"
            
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            forgetPwdTitle.text = "fpForgotPasswordKEY".localizableString(loc: "hi")
            userNameTF.placeholder = "fpEnterYourRegisterdMobileNumberKEY".localizableString(loc: "hi")
            submitBTN.setTitle("fpSubmitKEY".localizableString(loc: "hi"), for: .normal)
            
            backToLogin.text = "लॉगिन पर वापस जाएं"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            forgetPwdTitle.text = "fpForgotPasswordKEY".localizableString(loc: "bn")
            userNameTF.placeholder = "fpEnterYourRegisterdMobileNumberKEY".localizableString(loc: "bn")
            submitBTN.setTitle("fpSubmitKEY".localizableString(loc: "bn"), for: .normal)
            backToLogin.text = "প্রবেশ করতে পেছান"
        }else{
            forgetPwdTitle.text = "fpForgotPasswordKEY".localizableString(loc: "te")
            userNameTF.placeholder = "fpEnterYourRegisterdMobileNumberKEY".localizableString(loc: "te")
            submitBTN.setTitle("fpSubmitKEY".localizableString(loc: "te"), for: .normal)
            backToLogin.text = "తిరిగి లాగిన్‌కి"
        }
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if userNameTF.text?.count == 0 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Please Enter Membership ID"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "कृपया सदस्यता आईडी दर्ज करें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "সদস্যতা আইডি লিখুন দয়া করে"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "దయచేసి సభ్యత్వ IDని నమోదు చేయండి"
                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        } else {
            let parameters = ["UserName":"\(self.userNameTF.text ?? "")"]
            self.vm.forgotPasswordAPI(parameters: parameters) { response in
                if response?.forgotPasswordMobileAppResult ?? false == true {
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        self.isSuccess = 1
                        
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            vc!.descriptionInfo = "New password sent to the registered mobile number!"
                         }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                             vc!.descriptionInfo = "पंजीकृत मोबाइल नंबर पर भेजा गया नया पासवर्ड!"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            vc!.descriptionInfo = "নিবন্ধিত মোবাইল নম্বরে পাঠানো নতুন পাসওয়ার্ড!"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                            vc!.descriptionInfo = "రిజిస్టర్డ్ మొబైల్ నంబర్‌కు కొత్త పాస్‌వర్డ్ పంపబడింది!"
                          }
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                } else {
                    self.userNameTF.text = ""
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        self.isSuccess = 0
                       
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            vc!.descriptionInfo = "Something went erong Please try again later!"
                         }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                             vc!.descriptionInfo = "कुछ गलत हो गया है। कृपया बाद में दोबारा प्रयास करें!"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            vc!.descriptionInfo = "কিছু ভুল হয়েছে। পরে আবার চেষ্টা করুন!"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                            vc!.descriptionInfo = "ఏదో తప్పు జరిగినది. దయచేసి కాసేపు ఆగక ప్రయత్నించండి!"
                          }
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func membershipIdDidEnd(_ sender: Any) {
        let parameters = ["ActionType":"58","Location":["UserName":"\(userNameTF.text ?? "")"]] as [String : Any]
        self.vm.membershipIDVerification(parameters: parameters) { response in
            if response?.CheckCustomerExistancyAndVerificationJsonResult ?? -1 != 1 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    self.isSuccess = 0
                    
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "MembershipID doesn't exists"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "सदस्यता आईडी मौजूद नहीं है"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "সদস্যতা আইডি বিদ্যমান নেই"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "సభ్యత్వ ID ఉనికిలో లేదు"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.userNameTF.text = ""
                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")

      if string == numberFiltered {
        let currentText = userNameTF.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 10
      } else {
        return false
      }
    }
}
