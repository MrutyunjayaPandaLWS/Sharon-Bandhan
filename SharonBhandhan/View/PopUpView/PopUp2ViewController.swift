//
//  PopUp2ViewController.swift
//  Sharon Secure
//
//  Created by admin on 18/07/22.
//

import UIKit
import Toast_Swift
protocol PopUpDelegate: AnyObject{
    func popUpAlertDidTap(_ vc: PopUp2ViewController)
}
class PopUp2ViewController: BaseViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var textmessage: UILabel!
    var itsFrom = ""
    var titleInfo = ""
    var descriptionInfo = ""
    var delegate: PopUpDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.closeButton.isHidden = true
        self.textmessage.text = self.descriptionInfo
    }
    @IBAction func closeButton(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButton(_ sender: Any) {
        if self.itsFrom == "NewPassWord"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("forgetPassword"), object: nil)
            }
        }else if self.itsFrom == "ProfileImageUpdated"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("ProfileImageUpdated"), object: nil)
            }
        }else if self.itsFrom == "ProfileUpdate"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("ProfileUpdated"), object: nil)
            }
        }else if self.itsFrom == "feedBackSubmission"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .feedBackSubmission, object: nil)
            }
        }else if self.itsFrom == "RegistrationModels"{
            self.dismiss(animated: true){
                self.navigationController?.popToRootViewController(animated: true)
                NotificationCenter.default.post(name: Notification.Name("GOTOLOGIN"), object: nil)
            }
        }else if self.itsFrom == "RegistrationFailed"{
            self.dismiss(animated: true){
                self.navigationController?.popToRootViewController(animated: true)
            }
        }else if self.itsFrom == "PasswordChanged"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("PasswordChanged"), object: nil)
            }
        }else if self.itsFrom == "ValidateQRCode"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("InvalidQRCode"), object: nil)
            }
        }else if self.itsFrom == "ScannerAlertPopUp"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("alertMessagePopuP"), object: nil)
            }
        }else if self.itsFrom == "MaxLimit"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("maxiLimitReached"), object: nil)
            }
        }else if self.itsFrom == "MaxUploadLimit"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("maxiUploadLimiReached"), object: nil)
            }
        }else if self.itsFrom == "EwarrantySuccess"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("generateEWarrantySuccess"), object: nil)
            }
        }else if self.itsFrom == "EwarrantyFailed"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("generateEWarrantyFailed"), object: nil)
            }
        }else if self.itsFrom == "DocumentSuccess"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("uploadDocView"), object: nil)
            }
        }else if self.itsFrom == "AccountDeactivated"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("AccountDeactivated"), object: nil)
            }
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
        self.delegate.popUpAlertDidTap(self)
       
    }
    deinit{
        print("All memory has been deallocated by system")
    }
}
