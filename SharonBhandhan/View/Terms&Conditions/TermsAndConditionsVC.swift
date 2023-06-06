//
//  TermsAndConditionsVC.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 20/04/22.
//

import UIKit
import WebKit

class TermsAndConditionsVC: BaseViewController {
    
    @IBOutlet weak var header: UILabel!
    //@IBOutlet weak var termsAndConditionsTV: UITextView!
    @IBOutlet var termsAndCondWebKit: UIWebView!
    var fromSideMenu = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.stopLoading()
            if self.header.text == "Terms & Conditions"{
                self.termsAndCondWebKit.loadRequest(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-English", ofType: "html")!) as URL) as URLRequest)
            }else if self.header.text == "नियम एवं शर्तें" {
                self.termsAndCondWebKit.loadRequest(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-Hindi", ofType: "html")!) as URL) as URLRequest)
            }else if self.header.text == "விதிமுறைகளும் நிபந்தனைகளும்" {
                self.termsAndCondWebKit.loadRequest(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-Tamil", ofType: "html")!) as URL) as URLRequest)
            }else if self.header.text == "నిబంధనలు & షరతులు" {
                self.termsAndCondWebKit.loadRequest(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-Telugu", ofType: "html")!) as URL) as URLRequest)
            }else{
                self.termsAndCondWebKit.loadRequest(NSURLRequest(url: NSURL(fileURLWithPath: Bundle.main.path(forResource: "T&C-Sharon-English", ofType: "html")!) as URL) as URLRequest)
            }
           
        }
    }
    
    func localization(){
        
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
