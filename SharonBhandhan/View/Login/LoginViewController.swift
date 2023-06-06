//
//  LoginViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Firebase

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
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.loginToContinue.text = "Login to continue"
            self.userNameTF.placeholder = "lmobilenumberKEY".localizableString(loc: "en")
            self.passwordTF.placeholder = "lpasswordKEY".localizableString(loc: "en")
            self.forgetBTN.setTitle("fpForgotPasswordKEY".localizableString(loc: "en"), for: .normal)
            self.termsLbl.text = "lTermsAndConditionsKEY".localizableString(loc: "en")
            self.privacyLbl.text = "Privacy Policy"
            self.loginBTN.setTitle("lLoginKEY".localizableString(loc: "en"), for: .normal)
            
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.loginToContinue.text = "जारी रखने के लिए लॉगिन करें"
            self.userNameTF.placeholder = "lmobilenumberKEY".localizableString(loc: "hi")
            self.passwordTF.placeholder = "lpasswordKEY".localizableString(loc: "hi")
            self.forgetBTN.setTitle("fpForgotPasswordKEY".localizableString(loc: "hi"), for: .normal)
            self.termsLbl.text = "lTermsAndConditionsKEY".localizableString(loc: "hi")
            self.privacyLbl.text = "गोपनीयता नीति"
            self.loginBTN.setTitle("lLoginKEY".localizableString(loc: "hi"), for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.loginToContinue.text = "தொடர உள்நுழைக"
            self.userNameTF.placeholder = "lmobilenumberKEY".localizableString(loc: "ta-IN")
            self.passwordTF.placeholder = "lpasswordKEY".localizableString(loc: "ta-IN")
            self.forgetBTN.setTitle("fpForgotPasswordKEY".localizableString(loc: "ta-IN"), for: .normal)
            self.termsLbl.text = "lTermsAndConditionsKEY".localizableString(loc: "ta-IN")
            self.privacyLbl.text = "தனியுரிமைக் கொள்கை"
            self.loginBTN.setTitle("lLoginKEY".localizableString(loc: "ta-IN"), for: .normal)
        }else{
            self.loginToContinue.text = "కొనసాగించడానికి లాగిన్ చేయండి"
            self.userNameTF.placeholder = "lmobilenumberKEY".localizableString(loc: "te")
            self.passwordTF.placeholder = "lpasswordKEY".localizableString(loc: "te")
            self.forgetBTN.setTitle("fpForgotPasswordKEY".localizableString(loc: "te"), for: .normal)
            self.termsLbl.text = "lTermsAndConditionsKEY".localizableString(loc: "te")
            self.privacyLbl.text = "గోప్యతా విధానం"
            self.loginBTN.setTitle("lLoginKEY".localizableString(loc: "te"), for: .normal)
        }
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
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            vc!.descriptionInfo = "MembershipID doesn't exists"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            vc!.descriptionInfo = "सदस्यता आईडी मौजूद नहीं है"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            vc!.descriptionInfo = "உறுப்பினர் ஐடி இல்லை"
                        }else{
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
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Please Enter the Membership ID"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "कृपया सदस्यता आईडी दर्ज करें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "உறுப்பினர் ஐடியை உள்ளிடவும்"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "దయచేసి సభ్యత్వ IDని నమోదు చేయండి"
                  }
                
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        } else if passwordTF.text?.count == 0 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Please Enter the Password"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "कृपया पासवर्ड दर्ज करें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "கடவுச்சொல்லை உள்ளிடவும்"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "దయచేసి పాస్‌వర్డ్‌ను నమోదు చేయండి"
                  }
               
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        } else if self.boolResult == false {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Please Accept Terms and conditons"

                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "कृपया नियम और शर्तें स्वीकार करें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "விதிமுறைகள் மற்றும் நிபந்தனைகளை ஏற்கவும்"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "దయచేసి నిబంధనలు మరియు షరతులను అంగీకరించండి"
                  }
               
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        } else {
            callAPI()
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
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Password is invalid!"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "पासवर्ड गलत है!"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "கடவுச்சொல் தவறானது!"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "పాస్వర్డ్ చెల్లదు!"
                      }
                    
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
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Your account is verification pending! Kindly contact your administrator."
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "आपका खाता सत्यापन लंबित है! कृपया अपने व्यवस्थापक से संपर्क करें।"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "உங்கள் கணக்கு சரிபார்ப்பு நிலுவையில் உள்ளது! தயவுசெய்து உங்கள் நிர்வாகியைத் தொடர்பு கொள்ளவும்."
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "మీ ఖాతా ధృవీకరణ పెండింగ్‌లో ఉంది! దయచేసి మీ నిర్వాహకుడిని సంప్రదించండి."
                      }
                   
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            }
            
//               else if response?.userList?[0].verifiedStatus ?? 0 == 0 && response?.userList?[0].isUserActive ?? 0 == 1{
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Welcome to the century proclub , our sales executive will contact you to activate your account !'"
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "सेंचुरी प्रोक्लब में आपका स्वागत है, हमारे सेल्स एग्जीक्यूटिव आपके खाते को सक्रिय करने के लिए आपसे संपर्क करेंगे!'"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "সেঞ্চুরি প্রক্লাবে স্বাগতম, আমাদের সেলস এক্সিকিউটিভ আপনার অ্যাকাউন্ট সক্রিয় করতে আপনার সাথে যোগাযোগ করবেন!"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "సెంచరీ ప్రోక్లబ్‌కు స్వాగతం , మీ ఖాతాను యాక్టివేట్ చేయడానికి మా సేల్స్ ఎగ్జిక్యూటివ్ మిమ్మల్ని సంప్రదిస్తారు !"
//                      }
//                   
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                    self.stopLoading()
//                }
//            }
            else if response?.userList?[0].isUserActive ?? 0 == 0 {
//                else if response?.userList?[0].verifiedStatus ?? 0 == 0 && response?.userList?[0].isUserActive ?? 0 == 0 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Your account is not activated! Kindly activate your account."
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "आपका खाता सक्रिय नहीं किया गया है! कृपया अपना खाता सक्रिय करें।"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "உங்கள் கணக்கு செயல்படுத்தப்படவில்லை! தயவுசெய்து உங்கள் கணக்கை செயல்படுத்தவும்."
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "మీ ఖాతా యాక్టివేట్ కాలేదు! దయచేసి మీ ఖాతాను సక్రియం చేయండి."
                      }
                    
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    self.stopLoading()
                }
            }
//            else if response?.userList?[0].verifiedStatus ?? 0 != 1 && response?.userList?[0].isUserActive ?? 0 != 1 {
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Your account is not activated! Kindly activate your account."
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "आपका खाता सक्रिय नहीं किया गया है! कृपया अपना खाता सक्रिय करें।"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "আপনার অ্যাকাউন্ট সক্রিয় করা হয় না! অনুগ্রহ করে আপনার অ্যাকাউন্ট সক্রিয় করুন."
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "మీ ఖాతా యాక్టివేట్ కాలేదు! దయచేసి మీ ఖాతాను సక్రియం చేయండి."
//                      }
//
//
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                    self.stopLoading()
//                }
//            }
            else if response?.userList?[0].isUserActive ?? 0 == 0 {
//                else if response?.userList?[0].verifiedStatus ?? 0 == 1 && response?.userList?[0].isUserActive ?? 0 == 0 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Your account has been deactivated! Kindly contact the administrator or contact center at +91-8955177400."
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "आपका खाता निष्क्रिय कर दिया गया है! कृपया व्यवस्थापक या संपर्क केंद्र से +91-8955177400 पर संपर्क करें।"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "আপনার অ্যাকাউন্ট নিষ্ক্রিয় করা হয়েছে! অনুগ্রহ করে প্রশাসক বা যোগাযোগ কেন্দ্রের সাথে +91-8955177400 এ যোগাযোগ করুন।"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "మీ ఖాతా డీయాక్టివేట్ చేయబడింది! దయచేసి నిర్వాహకుడిని లేదా సంప్రదింపు కేంద్రాన్ని +91-8955177400లో సంప్రదించండి."
                      }
                    
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
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Your account has been deactivated! Kindly contact the administrator or contact center at +91-8955177400."
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "आपका खाता निष्क्रिय कर दिया गया है! कृपया व्यवस्थापक या संपर्क केंद्र से +91-8955177400 पर संपर्क करें।"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "আপনার অ্যাকাউন্ট নিষ্ক্রিয় করা হয়েছে! অনুগ্রহ করে প্রশাসক বা যোগাযোগ কেন্দ্রের সাথে +91-8955177400 এ যোগাযোগ করুন।"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "మీ ఖాతా డీయాక్టివేట్ చేయబడింది! దయచేసి నిర్వాహకుడిని లేదా సంప్రదింపు కేంద్రాన్ని +91-8955177400లో సంప్రదించండి."
                      }
                    
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
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            vc!.descriptionInfo = "Something went wrong please tryagain later!"
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
