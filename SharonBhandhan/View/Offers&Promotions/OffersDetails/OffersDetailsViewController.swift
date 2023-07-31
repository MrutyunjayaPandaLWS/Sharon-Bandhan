//
//  OffersDetailsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import SDWebImage
import Firebase
import WebKit
import LanguageManager_iOS

class OffersDetailsViewController: BaseViewController {
    @IBOutlet weak var offersImg: UIImageView!
    
    @IBOutlet weak var offersDescriptionTextView: UITextView!
    @IBOutlet weak var poinntsLbl: UILabel!
    @IBOutlet weak var redemblepointsTitle: UILabel!
    @IBOutlet weak var offersName: UILabel!    
    @IBOutlet weak var offersDescription: WKWebView!
    @IBOutlet weak var header: UILabel!
    
    
    var offersImage = ""
    var shortDesc = ""
    var longDesc = ""
    var offerName = ""
    var promotionId = 0
    var promotionValid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.offersName.text = offerName
        offersDescriptionTextView.isEditable = false
        
        let plainText = convertHTMLToPlainText(htmlString: self.longDesc)
        print(plainText)
        offersDescriptionTextView.text = plainText
        
        self.offersDescription.loadHTMLString(self.longDesc, baseURL: nil)
        let receivedImage = (offersImage).dropFirst(2)
        print(receivedImage, "receivedURL")
        offersDescription.isHidden =  true
        let totalImgURL = PROMO_IMG + receivedImage
        offersImg.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        languagelocalization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Offers and Promotion Details")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
        poinntsLbl.text = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? "0"

        
    }
    func languagelocalization(){
        self.header.text = "opOffersAndMarketingKEY".localiz()
        
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.header.text = "opOffersAndMarketingKEY".localiz()
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.header.text = "ऑफ़र और प्रचार"
//
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.header.text = "অফার এবং প্রচার"
//        }else{
//            self.header.text = "ఆఫర్‌లు & ప్రమోషన్‌లు"
//        }
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func convertHTMLToPlainText(htmlString: String) -> String {
        if let attributedString = NSAttributedString(htmlString: htmlString) {
            return attributedString.string
        } else {
            return ""
        }
    }
    
}
extension NSAttributedString {
    convenience init?(htmlString: String) {
        guard let data = htmlString.data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        try? self.init(data: data, options: options, documentAttributes: nil)
    }
}





