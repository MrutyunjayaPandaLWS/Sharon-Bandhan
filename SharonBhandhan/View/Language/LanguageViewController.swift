//
//  LanguageViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Firebase
import LanguageManager_iOS

class LanguageViewController: UIViewController {

    
    @IBOutlet var gradientView4: GradientView!
    @IBOutlet var gradientView3: GradientView!
    @IBOutlet var gradientView2: GradientView!
    @IBOutlet var gradientView1: GradientView!

    @IBOutlet var roundLetterLabel1: UIView!
    @IBOutlet var roundLetterLabel2: UIView!
    @IBOutlet var roundLetterLabel3: UIView!
    @IBOutlet var roundLetterLabel4: UIView!
    
    var storyboard1 = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Language")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    override func viewWillLayoutSubviews() {
//        self.roundLetterLabel1.layer.cornerRadius = self.roundLetterLabel1.frame.width / 2
//        self.roundLetterLabel2.layer.cornerRadius = self.roundLetterLabel2.frame.width / 2
//        self.roundLetterLabel3.layer.cornerRadius = self.roundLetterLabel3.frame.width / 2
//        self.roundLetterLabel4.layer.cornerRadius = self.roundLetterLabel4.frame.width / 2
        }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(UserDefaults.standard.string(forKey: "LanguageLocalizable"),"language status")
    }

    
    @IBAction func englishLanguage(_ sender: Any) {
        UserDefaults.standard.setValue("1", forKey: "LanguageLocalizable")
        LanguageManager.shared.setLanguage(language: .en)
//        UserDefaults.standard.synchronize()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func hindiLanguage(_ sender: Any) {
        UserDefaults.standard.setValue("2", forKey: "LanguageLocalizable")
        LanguageManager.shared.setLanguage(language: .hi)
//        UserDefaults.standard.synchronize()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func banglaLanguaga(_ sender: Any) {
        UserDefaults.standard.setValue("3", forKey: "LanguageLocalizable")
        LanguageManager.shared.setLanguage(language: .taIN)
//        UserDefaults.standard.synchronize()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func teluguLanguage(_ sender: Any) {
        UserDefaults.standard.setValue("4", forKey: "LanguageLocalizable")
        LanguageManager.shared.setLanguage(language: .te)
//        UserDefaults.standard.synchronize()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
