//
//  ForgotPasswordViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Firebase
import LanguageManager_iOS

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
        
        forgetPwdTitle.text = "fpForgotPasswordKEY".localiz()
        userNameTF.placeholder = "fpEnterYourRegisterdMobileNumberKEY".localiz()
        submitBTN.setTitle("fpSubmitKEY".localiz(), for: .normal)
        backToLogin.text = "back To Login".localiz()
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if userNameTF.text?.count == 0 {
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Please Enter Membership ID".localiz()

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
                        vc!.descriptionInfo = "New password sent to the registered mobile number!".localiz()
 
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
                        vc!.descriptionInfo = "Something went wrong please try again later.".localiz()

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
                    vc!.descriptionInfo = "MembershipID doesn't exists".localiz()
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
