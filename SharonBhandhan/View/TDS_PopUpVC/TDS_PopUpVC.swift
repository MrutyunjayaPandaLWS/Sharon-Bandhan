//
//  TDS_PopUpVC.swift
//  SharonBhandhan
//
//  Created by admin on 30/06/23.
//

import UIKit
import WebKit
import LanguageManager_iOS

class TDS_PopUpVC: UIViewController ,WKNavigationDelegate{

    @IBOutlet weak var tdsWebView: WKWebView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var headerNameLbl: UILabel!
    var languageStatus =  UserDefaults.standard.string(forKey: "LanguageLocalizable") ?? "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        tdsWebView.navigationDelegate = self
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        bottomView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localization()
    }
    

    @IBAction func didTappedOkBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func localization(){
        self.okBtn.setTitle("rOKKEY".localiz(), for: .normal)
        self.headerNameLbl.text = "PAN INFORMATION".localiz()
        
                DispatchQueue.main.async {
//                    if let htmlPath = Bundle.main.path(forResource: "tds_info", ofType: "html") {
//                              do {
//                                  let htmlString = try String(contentsOfFile: htmlPath, encoding: .utf8)
//                                      self.tdsWebView.loadHTMLString(htmlString, baseURL: nil)
//                              } catch {
//                                  // Handle error loading HTML
//                              }
//                        
//                          }
                    if self.languageStatus == "1"{
                        self.tdsWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "tds_info", ofType: "html")!) as URL) as URLRequest)
                    }else if self.languageStatus == "2"{
                        self.tdsWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "tds_info-hindi", ofType: "html")!) as URL) as URLRequest)
                    }else if self.languageStatus == "3"{
                        self.tdsWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "tds_info-tamil", ofType: "html")!) as URL) as URLRequest)
                    }else if self.languageStatus == "4"{
                        self.tdsWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "tds_info-telugu", ofType: "html")!) as URL) as URLRequest)
                    }else{
                        self.tdsWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "tds_info", ofType: "html")!) as URL) as URLRequest)
                    }
                }
        
    }

//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        // Inject CSS to change the font size
//        let fontSize = 1000 // Set your desired font size here
//        let javascriptString = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(fontSize)%';"
//        webView.evaluateJavaScript(javascriptString) { (_, error) in
//            if let error = error {
//                print("Error injecting CSS: \(error.localizedDescription)")
//            }
//        }
//    }
}
