//
//  MyBenefitsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Firebase
import LanguageManager_iOS

class MyBenefitsViewController: UIViewController {

    @IBOutlet weak var header: UILabel!
    var fromSideMenu = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.header.text = "mbMyBenefitsKEY".localiz()
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.header.text = "mbMyBenefitsKEY".localiz()
////           self.benefitsImage.image = UIImage(named: "hin")
//        }else  if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//           self.header.text = "मेरेलाभ"
////           self.benefitsImage.image = UIImage(named: "hin")
//
//        }else  if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//           self.header.text = "నాప్రయోజనాలు"
////           self.benefitsImage.image = UIImage(named: "tel")
//
//        }else{
//           self.header.text = "আমার লাভ"
////           self.benefitsImage.image = UIImage(named: "ban")
//
//           }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "My Benefits")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    @IBAction func backButton(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
