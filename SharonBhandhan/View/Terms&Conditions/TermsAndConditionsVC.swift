//
//  TermsAndConditionsVC.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 20/04/22.
//

import UIKit
import WebKit
import LanguageManager_iOS

class TermsAndConditionsVC: BaseViewController {
    
    @IBOutlet weak var header: UILabel!
    //@IBOutlet weak var termsAndConditionsTV: UITextView!
    @IBOutlet weak var termsAndCondWebKit: WKWebView!
    var requestAPIs = RestAPI_Requests()
    var termsAndConditionArray = [LstTermsAndCondition]()
    var fromSideMenu = ""
    var languageStatus =  UserDefaults.standard.string(forKey: "LanguageLocalizable") ?? "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            termsAndConditionApi()
        }
        localization()
    }
    
    private func localization(){
        self.header.text = "lTermsAndConditionsKEY".localiz()
//        DispatchQueue.main.async {
//            if self.languageStatus == "1"{
//                self.termsAndCondWebKit.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-English", ofType: "html")!) as URL) as URLRequest)
//            }else if self.languageStatus == "2"{
//                self.termsAndCondWebKit.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-Hindi", ofType: "html")!) as URL) as URLRequest)
//            }else if self.languageStatus == "3"{
//                self.termsAndCondWebKit.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-Tamil", ofType: "html")!) as URL) as URLRequest)
//            }else if self.languageStatus == "4"{
//                self.termsAndCondWebKit.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-Telugu", ofType: "html")!) as URL) as URLRequest)
//            }else{
//                self.termsAndCondWebKit.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-English", ofType: "html")!) as URL) as URLRequest)
//            }
//        }
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
extension UITextView {

    func centerText() {
        self.textAlignment = .justified
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

}

extension TermsAndConditionsVC{
    
    func termsAndConditionApi(){
        DispatchQueue.main.async {
        self.startLoading()
        }
        let parameters = [
            "ActionType": 1,
             "ActorId": 2
        ] as [String: Any]
        print(parameters)
        self.requestAPIs.termsAndCondition_API(parameters: parameters, completion: { result, error in
            
            if error == nil{
                if result != nil{
                    DispatchQueue.main.async {
                        self.termsAndConditionArray = result?.lstTermsAndCondition ?? []
                        if self.termsAndConditionArray.count == 0{
                            DispatchQueue.main.async{

                            }
                        }else{
                            if self.languageStatus == "1"{
                                for item in self.termsAndConditionArray{
                                    if item.language == "English"{
//                                    if item.termsAndConditionsId == 17{
                                        self.loadHTMLStringImage(htmlString: item.hTML ?? "")
                                        return
                                    }
                                }
                            }else if self.languageStatus == "2"{
                                for item in self.termsAndConditionArray{
                                    if item.language == "Hindi"{
//                                        if item.termsAndConditionsId == 18{
                                        self.loadHTMLStringImage(htmlString: item.hTML ?? "")
                                        return
                                    }
                                }
                            }else if self.languageStatus == "3"{
                                for item in self.termsAndConditionArray{
                                    if item.language == "Tamil"{
//                                        if item.termsAndConditionsId == 19{
                                        self.loadHTMLStringImage(htmlString: item.hTML ?? "")
                                        return
                                    }
                                }
                            }else if self.languageStatus == "4"{
                                for item in self.termsAndConditionArray{
                                    if item.language == "Telugu"{
//                                    if item.termsAndConditionsId == 20{
                                        
                                        self.loadHTMLStringImage(htmlString: item.hTML ?? "")
                                        return
                                    }
                                }
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.stopLoading()
                }
            }
        })
    }
    
    func loadHTMLStringImage(htmlString:String) -> Void {
           let htmlString = "\(htmlString)"
        termsAndCondWebKit.loadHTMLString(htmlString, baseURL: nil)
       }

}
