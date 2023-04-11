//
//  UniqueFeaturesViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import WebKit
import Firebase
class UniqueFeaturesViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var header: UILabel!
    var fromSideMenu = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = Bundle.main.url(forResource: "uniqueFeatures", withExtension: "html") {
            let request = NSURLRequest(url: filePath)
            webView.load(request as URLRequest)
        }
        
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            header.text = "Unique features"
              }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                  header.text = "नियमएवंशर्तें"
              }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                  header.text = "ఏకైకలక్షణాలు"
              }else{
                  header.text = "অনন্য বৈশিষ্ট"
              }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Unique Features")
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
