//
//  RedemptionSuccess_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 15/03/22.
//

import UIKit
import LanguageManager_iOS

class RedemptionSuccess_VC: BaseViewController {

    @IBOutlet var goToDashboard: GradientButton!
    @IBOutlet var sucessMessage: UILabel!
    var window: UIWindow?
    var nav : UINavigationController!
    override func viewDidLoad() {
        super.viewDidLoad()
        languagelocalization()
    }
    
    func languagelocalization(){
        self.sucessMessage.text = "You have redeemed your product successfully".localiz()
        self.goToDashboard.setTitle("Back To Dashboard".localiz(), for: .normal)
        
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.sucessMessage.text = "You have redeemed your product successfully"
//            self.goToDashboard.setTitle("Back To Dashboard", for: .normal)
//            
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.sucessMessage.text = "आपने अपना उत्पाद सफलतापूर्वक भुना लिया है"
//            self.goToDashboard.setTitle("डैशबोर्ड पर वापस जाएं", for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.sucessMessage.text = "আপনি সফলভাবে আপনার পণ্য রিডিম করেছেন"
//            self.goToDashboard.setTitle("ড্যাশবোর্ডে ফিরে যান", for: .normal)
//        }else{
//            self.sucessMessage.text = "మీరు మీ ఉత్పత్తిని విజయవంతంగా రీడీమ్ చేసారు"
//            self.goToDashboard.setTitle("తిరిగి డాష్‌బోర్డ్‌కి", for: .normal)
//        }
    }

    @IBAction func goToDashboard(_ sender: Any) {
        self.dismiss(animated: true){
            NotificationCenter.default.post(name: .dismissScreen, object: nil)
        }
        
    }
}
