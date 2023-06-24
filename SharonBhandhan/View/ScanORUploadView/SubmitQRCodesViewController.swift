//
//  SubmitQRCodesViewController.swift
//  Sharon Secure
//
//  Created by admin on 18/07/22.
//

import UIKit
import Toast_Swift
import LanguageManager_iOS

protocol submitQRDelegate: class {
    func DidTap(_ vc: SubmitQRCodesViewController)
}
class SubmitQRCodesViewController: BaseViewController, UITextFieldDelegate, PopUpDelegate {
    func popUpAlertDidTap2(_ vc: PopUp2ViewController) {}
    
    
    @IBOutlet weak var addressTitleLbl: UILabel!
    @IBOutlet weak var emailTitleLbl: UILabel!
    @IBOutlet weak var mobileNumberTitleLbl: UILabel!
    @IBOutlet weak var customerNameTitleLbl: UILabel!
    @IBOutlet weak var customerDetailsTitleLbl: UILabel!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var currentAddress: UITextField!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var customername: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    weak var delegate:submitQRDelegate?
    
    var selectedaddress = ""
    var selectedemailid = ""
    var selectedmobilenumber = ""
    var selectedcustomerName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mobileNumber.delegate = self
        self.customername.delegate = self
        localization()
    }
    
    private func localization(){
        customerDetailsTitleLbl.text = "Enter Customer Details".localiz()
        customerNameTitleLbl.text = "ewCustomerNameKEY".localiz()
        customername.placeholder = "Enter Customer Name".localiz()
        mobileNumberTitleLbl.text = "Customer Mobile Number".localiz()
        mobileNumber.placeholder = "Enter the Mobile Number".localiz()
        emailTitleLbl.text = "Cutomer Email".localiz()
        emailID.placeholder = "Enter the email address".localiz()
        addressTitleLbl.text = "Customer Address".localiz()
        currentAddress.placeholder = "Enter the address details".localiz()
        submitBtn.setTitle("fpSubmitKEY".localiz(), for: .normal)
        
    }
    
    @IBAction func mobileNumber(_ sender: Any) {
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileNumber{
            let charsLimit = 10
            let startingLength = mobileNumber.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            let cs = CharacterSet(charactersIn: "1234567890").inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (newLength <= charsLimit) && (string == filtered)
        }
        if textField == customername {
            let cs = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ").inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return ((string == filtered))
        }
        return true
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    @IBAction func submitButton(_ sender: Any) {
        if customername.text ?? "" == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Customer Name".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            return
        }
        if customername.text!.trimmingCharacters(in: .whitespaces) == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter valid First Name".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            return
        }
        if mobileNumber.text ?? "" == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "fEnterMobileNumberKEY".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            return
        }
        if mobileNumber.text!.count != 10{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "EnterValidNumberKey".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            return
        }
        if emailID.text ?? "" == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter EmailID".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            return
        }
        if self.isValidEmail(emailID.text ?? "") == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter valid EmailID".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            return
        }
        if currentAddress.text ?? "" == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Enter Address".localiz()
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            return
        }else{
        self.selectedaddress = self.currentAddress.text ?? ""
        self.selectedemailid = self.emailID.text ?? ""
        self.selectedmobilenumber = self.mobileNumber.text ?? ""
        self.selectedcustomerName = self.customername.text ?? ""
        self.delegate?.DidTap(self)
        }
    }
    
   
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
