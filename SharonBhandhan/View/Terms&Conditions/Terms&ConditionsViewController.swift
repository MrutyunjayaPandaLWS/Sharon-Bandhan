//
//  Terms&ConditionsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Firebase
import WebKit
import LanguageManager_iOS
protocol TermsAndConditionDelegate: class {
    func acceptDidTap(_ vc: Terms_ConditionsViewController)
}

class Terms_ConditionsViewController: BaseViewController, PrivacyPolicyDelegate {
    
    func acceptDidTap(_ vc: PrivacyPolicyViewController) {
        self.boolResult = vc.boolResult
        self.delegate?.acceptDidTap(self)
    }
    
   
    @IBOutlet weak var termsAndCondWebView: WKWebView!
    
    @IBOutlet var termsAndConditionsTV: UITextView!
    @IBOutlet weak var header: GradientButton!
    
    @IBOutlet weak var decline: GradientButton!
    @IBOutlet weak var accept: GradientButton!
    
    var languageStatus =  UserDefaults.standard.string(forKey: "LanguageLocalizable") ?? "0"
    var delegate: TermsAndConditionDelegate!
    var boolResult:Bool?
    var requestAPIs = RestAPI_Requests()
    var termsAndConditionArray = [LstTermsAndCondition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localization()
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            termsAndConditionApi()
        }
       // termsAndConditionsTV.textAlignment = .justified
       // languagelocalization()
//        DispatchQueue.main.async {
//            self.stopLoading()
//            self.termsAndCondWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "century-proclub-t&c", ofType: "html")!) as URL) as URLRequest)
//        }
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Terms and Conditions")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    private func localization(){
        self.header.setTitle("lTermsAndConditionsKEY".localiz(), for: .normal)
        self.decline.setTitle("lDeclineKEY".localiz(), for: .normal)
        self.accept.setTitle("lAcceptKEY".localiz(), for: .normal)
        
//        DispatchQueue.main.async {
//            if self.languageStatus == "1"{
//                self.termsAndCondWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-English", ofType: "html")!) as URL) as URLRequest)
//            }else if self.languageStatus == "2"{
//                self.termsAndCondWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-Hindi", ofType: "html")!) as URL) as URLRequest)
//            }else if self.languageStatus == "3"{
//                self.termsAndCondWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-Tamil", ofType: "html")!) as URL) as URLRequest)
//            }else if self.languageStatus == "4"{
//                self.termsAndCondWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-Telugu", ofType: "html")!) as URL) as URLRequest)
//            }else{
//                self.termsAndCondWebView.load(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-English", ofType: "html")!) as URL) as URLRequest)
//            }
//        }
    }
   
    
    @IBAction func declineButton(_ sender: Any) {
        self.boolResult = false
        self.delegate?.acceptDidTap(self)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func acceptButton(_ sender: Any) {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
//        vc.delegate = self
//        self.navigationController?.pushViewController(vc, animated: true)
        
        self.boolResult = true
        self.delegate?.acceptDidTap(self)
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: LoginViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
}

extension Terms_ConditionsViewController{
    
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
                        }else{
                            if self.languageStatus == "1"{
                                for item in self.termsAndConditionArray{
                                    if item.language == "English"{
//                                        if item.termsAndConditionsId == 17{
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
//                                    if item.termsAndConditionsId == 19{
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
        termsAndCondWebView.loadHTMLString(htmlString, baseURL: nil)
       }

}
