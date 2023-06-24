//
//  UniqueFeaturesViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import WebKit
import Firebase
import LanguageManager_iOS
class UniqueFeaturesViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var header: UILabel!
    var fromSideMenu = ""
    var selectedlanguage = UserDefaults.standard.string(forKey: "LanguageLocalizable") ?? ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "ufUniqueFeaturesKEY".localiz()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localization()
    }
    
    private func localization(){
        
        if selectedlanguage == "1"{
            if let filePath = Bundle.main.url(forResource: "SB-Uniq-Cust-Eng", withExtension: "html") {
                let request = NSURLRequest(url: filePath)
                webView.load(request as URLRequest)
            }
            
        }else if selectedlanguage == "2"{
            if let filePath = Bundle.main.url(forResource: "SB-Uniq-Cust-Hindi", withExtension: "html") {
                let request = NSURLRequest(url: filePath)
                webView.load(request as URLRequest)
            }
        }else if selectedlanguage == "3"{
            if let filePath = Bundle.main.url(forResource: "SB-Uniq-Cust-Tamil", withExtension: "html") {
                let request = NSURLRequest(url: filePath)
                webView.load(request as URLRequest)
            }
        }else if selectedlanguage == "4"{
            if let filePath = Bundle.main.url(forResource: "SB-Uniq-Cust-Telungu", withExtension: "html") {
                let request = NSURLRequest(url: filePath)
                webView.load(request as URLRequest)
            }
        }else{
            if let filePath = Bundle.main.url(forResource: "SB-Uniq-Cust-Eng", withExtension: "html") {
                let request = NSURLRequest(url: filePath)
                webView.load(request as URLRequest)
            }
        }
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
