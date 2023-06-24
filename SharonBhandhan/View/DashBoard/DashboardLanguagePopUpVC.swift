//
//  DashboardLanguagePopUpVC.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 14/04/22.
//

import UIKit
import LanguageManager_iOS

class DashboardLanguagePopUpVC: UIViewController {

    var storyboard1 = UIStoryboard(name: "Main", bundle: nil)
    @IBOutlet weak var selectLanguage: UILabel!
    @IBOutlet weak var roundLetterLabel1: UIView!
    @IBOutlet weak var roundLetterLabel2: UIView!
    @IBOutlet weak var roundLetterLabel3: UIView!
    @IBOutlet weak var roundLetterLabel4: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
//        self.roundLetterLabel1.layer.cornerRadius = self.roundLetterLabel1.frame.width / 2
//        self.roundLetterLabel2.layer.cornerRadius = self.roundLetterLabel2.frame.width / 2
//        self.roundLetterLabel3.layer.cornerRadius = self.roundLetterLabel3.frame.width / 2
//        self.roundLetterLabel4.layer.cornerRadius = self.roundLetterLabel4.frame.width / 2
        }
    
    
    @IBAction func english(_ sender: Any) {
       UserDefaults.standard.set("1", forKey: "LanguageLocalizable")
        LanguageManager.shared.setLanguage(language: .en)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name("languagerefreshRequired"), object: nil)
              self.dismiss(animated: true, completion: nil)
    }
    @IBAction func hindi(_ sender: Any) {
        UserDefaults.standard.set("2", forKey: "LanguageLocalizable")
        LanguageManager.shared.setLanguage(language: .hi)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name("languagerefreshRequired"), object: nil)
            self.dismiss(animated: true, completion: nil)
    }
    @IBAction func bangla(_ sender: Any) {
        UserDefaults.standard.set("3", forKey: "LanguageLocalizable")
        LanguageManager.shared.setLanguage(language: .taIN)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name("languagerefreshRequired"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func telugu(_ sender: Any) {
        UserDefaults.standard.set("4", forKey: "LanguageLocalizable")
        LanguageManager.shared.setLanguage(language: .te)
             UserDefaults.standard.synchronize()
             NotificationCenter.default.post(name: Notification.Name("languagerefreshRequired"), object: nil)
             self.dismiss(animated: true, completion: nil)
    }
}
