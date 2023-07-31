//
//  PopupAlertOne_VC.swift
//  Quba Safalta
//
//  Created by Arokia-M3 on 12/03/21.
//

import UIKit
import LanguageManager_iOS

protocol popUpDelegate : AnyObject {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC)
}
class PopupAlertOne_VC: BaseViewController {

   
    @IBOutlet var ok: GradientButton!
    @IBOutlet var descriptionn: UILabel!
    var titleInfo = ""
    var descriptionInfo = ""
    weak var delegate:popUpDelegate?
    var itsComeFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionn.text = descriptionInfo
        self.ok.setTitle("rOKKEY".localiz(), for: .normal)
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.ok.setTitle("OK", for: .normal)
//
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.ok.setTitle("ठीक है", for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.ok.setTitle("ওকে", for: .normal)
//        }else{
//            self.ok.setTitle("సరే", for: .normal)
//
//        }
       
    }
    
    @IBAction func OK(_ sender: Any) {
        if itsComeFrom == "DreamGift"{
            print("Called")
            
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .dreamGiftRemoved, object: nil)
            }
        }else if itsComeFrom == "QuerySubmission"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .querySubmission, object: nil)
            }
        }else if itsComeFrom == "Scanner"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .restartScan, object: nil)
            }
           
        }else if itsComeFrom == "AddToCart"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .giftAddedIntoCart, object: nil)
            }
        }else if itsComeFrom == "enteredCount"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .checkProductsCount, object: nil)
            }
        }else if itsComeFrom == "AccountVerification"{
            self.dismiss(animated: true){
                self.itsComeFrom = "AccountVerification"
            }
           
        }else if itsComeFrom == "DreamGiftDetails"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .removeDreamGiftDetails, object: nil)

            }
        }else if itsComeFrom == "DownloadEWarranty"{
            self.dismiss(animated: true){
                
                NotificationCenter.default.post(name: .downloadEwarrantyList, object: nil)
                self.navigationController?.popViewController(animated: true)
            }
           
        }else if itsComeFrom == "AccountDeleted"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .removeDreamGiftDetails, object: nil)

            }
        }else if itsComeFrom == "DeactivateAccount"{
            self.dismiss(animated: true){
               
                NotificationCenter.default.post(name: .deactivatedAcc, object: nil)

            }
        }else if itsComeFrom == "AccounthasbeenDeleted"{
            self.dismiss(animated: true){
              
                NotificationCenter.default.post(name: .deleteAccount, object: nil)
            }
        }else if itsComeFrom == "RedemptionFailed"{
            self.delegate?.popupAlertDidTap(self)
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .dismissScreen, object: nil)
                
            }
        }else{
            delegate?.popupAlertDidTap(self)
            self.dismiss(animated: true, completion: nil)
        }
 
        
        
    }
  
    deinit{
        print("All memory has been deallocated by system")
    }

}
