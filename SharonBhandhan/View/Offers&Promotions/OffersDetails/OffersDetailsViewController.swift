//
//  OffersDetailsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import SDWebImage
import Firebase

class OffersDetailsViewController: BaseViewController {
    @IBOutlet weak var offersImg: UIImageView!
    
    @IBOutlet weak var poinntsLbl: UILabel!
    @IBOutlet weak var redemblepointsTitle: UILabel!
    @IBOutlet weak var offersName: UILabel!
    @IBOutlet weak var offersDescription: UIWebView!
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
        self.offersDescription.loadHTMLString(self.longDesc, baseURL: nil)
        let receivedImage = (offersImage).dropFirst(2)
        print(receivedImage, "receivedURL")
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
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.header.text = "Offers & Promotions"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.header.text = "ऑफ़र और प्रचार"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.header.text = "অফার এবং প্রচার"
        }else{
            self.header.text = "ఆఫర్‌లు & ప్రమోషన్‌లు"
        }
    }
    
    @IBAction func backBTN(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
