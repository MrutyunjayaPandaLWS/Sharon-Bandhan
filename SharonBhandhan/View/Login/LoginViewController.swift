//
//  LoginViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Firebase
import LanguageManager_iOS

class LoginViewController: BaseViewController, TermsAndConditionDelegate,UITextFieldDelegate, popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
  
    var vm = LoginViewModel()
    var boolResult:Bool = false
    var token = UserDefaults.standard.string(forKey: "UD_DEVICE_TOKEN") ?? ""
    
    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var checkMarkButton: UIButton!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var loginToContinue: UILabel!
    @IBOutlet weak var forgetBTN: UIButton!
    @IBOutlet weak var termsLbl: UILabel!
    @IBOutlet weak var privacyLbl: UILabel!
    @IBOutlet weak var loginBTN: GradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        self.userNameTF.keyboardType = .numberPad
        self.userNameTF.delegate = self
        self.checkMarkButton.setImage(UIImage(named: "uncheck1"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        languagelocalization()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Login")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
      
    }
    func languagelocalization(){
        
        self.loginToContinue.text = "Login to continue".localiz()
        self.userNameTF.placeholder = "lmobilenumberKEY".localiz()
        self.passwordTF.placeholder = "lpasswordKEY".localiz()
        self.forgetBTN.setTitle("fpForgotPasswordKEY".localiz(), for: .normal)
        self.termsLbl.text = "lTermsAndConditionsKEY".localiz()
        self.privacyLbl.text = "Privacy Policy".localiz()
        self.loginBTN.setTitle("lLoginKEY".localiz(), for: .normal)
        
    }
    
    
    @IBAction func passwordSecureButton(_ sender: Any) {
        if passwordTF.isSecureTextEntry {
            passwordTF.isSecureTextEntry = false
            self.eyeButton.setImage(UIImage(named: "view"), for: .normal)
            
        } else {
            passwordTF.isSecureTextEntry = true
            self.eyeButton.setImage(UIImage(named: "hidden"), for: .normal)
        }
    }
    @IBAction func membershipIDDidEnd(_ sender: Any) {
        if userNameTF.text?.count != 0{
            let parameters = ["ActionType":"58","Location":["UserName":"\(userNameTF.text ?? "")"]] as [String : Any]
            print(parameters)
            self.vm.membershipIDVerification(parameters: parameters) { response in
                if response?.CheckCustomerExistancyAndVerificationJsonResult ?? -1 != 1 &&  response?.CheckCustomerExistancyAndVerificationJsonResult ?? -1 != 4{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "MembershipID doesn't exists".localiz()
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                        self.userNameTF.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        self.userNameTF.text = ""
        self.passwordTF.text = ""
        self.checkMarkButton.setImage(UIImage(named: "uncheck1"), for: .normal)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func checkMark(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "Terms_ConditionsViewController") as! Terms_ConditionsViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func submitButton(_ sender: Any) {
        if userNameTF.text?.count == 0 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please Enter the Membership ID".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        } else if passwordTF.text?.count == 0 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please Enter the Password".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        } else if self.boolResult == false {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please Accept Terms and conditons".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        } else {
            if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
                self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
            }else{
                callAPI()
            }
        }
    }
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Delegate:-
    
    func declineDidTap(_ vc: Terms_ConditionsViewController) {
        self.checkMarkButton.setImage(UIImage(named: "uncheck1"), for: .normal)
    }
    
    func acceptDidTap(_ vc: Terms_ConditionsViewController) {
        if vc.boolResult == true{
            self.boolResult = true
            self.checkMarkButton.setImage(UIImage(named: "check1"), for: .normal)
            return
        }
        self.checkMarkButton.setImage(UIImage(named: "uncheck1"), for: .normal)
            self.boolResult = false
         return
    }
    
    
    func callAPI() {
        self.startLoading()
        let parameters = [
            "Password": "\(passwordTF.text ?? "")",
            "UserName": "\(userNameTF.text ?? "")",
            "UserActionType": "GetPasswordDetails",
            "Browser": "IOS",
            "LoggedDeviceName": "IOS",
            "PushID": "\(token)",
            "UserType": "Customer"
        ]
        print(parameters)
        self.vm.loginAPICall(parameters: parameters) { response in
            if response?.userList?[0].result ?? 0 != 1{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "InvalidPasswordKey".localiz()
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            }else if response?.userList?[0].isDelete == 1{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "account is verification pending".localiz()
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            }
            
            else if response?.userList?[0].isUserActive ?? 0 == 0 {
//                else if response?.userList?[0].verifiedStatus ?? 0 == 0 && response?.userList?[0].isUserActive ?? 0 == 0 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Your account is not activated! Kindly activate your account.".localiz()
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            }
            else if (response?.userList?[0].verifiedStatus ?? 0) == 2{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Your account verification is failed !".localiz()
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            }
            else if response?.userList?[0].isUserActive ?? 0 == 0 {
//                else if response?.userList?[0].verifiedStatus ?? 0 == 1 && response?.userList?[0].isUserActive ?? 0 == 0 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Your account has been deactivated! Kindly contact the administrator or contact center at +91-8955177400.".localiz()

                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            }else if response?.userList?[0].isUserActive ?? 0 != 1 {
//                else if response?.userList?[0].verifiedStatus ?? 0 == 4 && response?.userList?[0].isUserActive ?? 0 != 1 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Your account has been deactivated! Kindly contact the administrator or contact center at +91-8955177400.".localiz()
                    
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Your account has been deactivated! Kindly contact the administrator or contact center at +91-8955177400."
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "आपका खाता निष्क्रिय कर दिया गया है! कृपया व्यवस्थापक या संपर्क केंद्र से +91-8955177400 पर संपर्क करें।"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "আপনার অ্যাকাউন্ট নিষ্ক্রিয় করা হয়েছে! অনুগ্রহ করে প্রশাসক বা যোগাযোগ কেন্দ্রের সাথে +91-8955177400 এ যোগাযোগ করুন।"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "మీ ఖాతా డీయాక్టివేట్ చేయబడింది! దయచేసి నిర్వాహకుడిని లేదా సంప్రదింపు కేంద్రాన్ని +91-8955177400లో సంప్రదించండి."
//                      }
                    
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            } else {
                if response?.userList?[0].isUserActive ?? 0 == 1 || response?.userList?[0].result ?? 0 == 1{
//                    if response?.userList?[0].verifiedStatus ?? 0 == 1 && response?.userList?[0].isUserActive ?? 0 == 1 || response?.userList?[0].result ?? 0 == 1{

                        UserDefaults.standard.setValue(response?.userList?[0].userId ?? -1, forKey: "UserID")
                        UserDefaults.standard.setValue(true, forKey: "IsloggedIn?")
                        DispatchQueue.main.async {
                            if #available(iOS 13.0, *) {
                                let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
                                sceneDelegate.setHomeAsRootViewController()
                            } else {
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDelegate.setHomeAsRootViewController()
                            }
                            self.stopLoading()
                        }
                }
                   // else if response?.userList?[0].verifiedStatus ?? 0 == 4 && response?.userList?[0].isUserActive ?? 0 == 1{
//                    UserDefaults.standard.setValue(response?.userList?[0].userId ?? -1, forKey: "UserID")
//                    UserDefaults.standard.setValue(true, forKey: "IsloggedIn?")
//                    UserDefaults.standard.setValue("1", forKey: "SemiActiveAccount")
//                    DispatchQueue.main.async {
//                        if #available(iOS 13.0, *) {
//                            let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
//                            sceneDelegate.setHomeAsRootViewController()
//                        } else {
//                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                            appDelegate.setHomeAsRootViewController()
//                        }
//                        self.stopLoading()
//                    }
//                }
                else {
                    DispatchQueue.main.async{
                        self.userNameTF.text = ""
                        self.passwordTF.text = ""
                        self.checkMarkButton.setImage(UIImage(named: "uncheck1"), for: .normal)
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "Something went wrong please try again later.".localiz()
                        
//                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                            vc!.descriptionInfo = "Something went wrong please tryagain later!"
//                         }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                             vc!.descriptionInfo = "कुछ गलत हो गया है। कृपया बाद में दोबारा प्रयास करें!"
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                            vc!.descriptionInfo = "কিছু ভুল হয়েছে। পরে আবার চেষ্টা করুন!"
//                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                            vc!.descriptionInfo = "ఏదో తప్పు జరిగినది. దయచేసి కాసేపు ఆగక ప్రయత్నించండి!"
//                          }
                        
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                        self.stopLoading()
                    }
                }
            }
        }
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
