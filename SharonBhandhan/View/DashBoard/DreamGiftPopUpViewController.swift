//
//  DreamGiftPopUpViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 14/04/22.
//

import UIKit
import SDWebImage

class DreamGiftPopUpViewController: BaseViewController {

    @IBOutlet var BannerImageView: UIImageView!
    @IBOutlet var dreamGiftNameLabel: UILabel!
    @IBOutlet var productPoints: UILabel!
    @IBOutlet var redeemablePoints: UILabel!
    @IBOutlet var pointsRequiredToRedeem: UILabel!
    @IBOutlet weak var yourDreamGift: UILabel!
    @IBOutlet weak var productPts: UILabel!
    @IBOutlet weak var redeemablePts: UILabel!
    @IBOutlet weak var ptsRequiredtoRedeem: UILabel!
    var dreamGiftArray = [ObjCatalogueDetailsForCustomer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languagelocalization()
        self.BannerImageView.sd_setImage(with: URL(string: "\(productCatalogueImgURL)\(dreamGiftArray[0].catalogueImage ?? "")"), placeholderImage: UIImage(named: "backgroundImage"))
        self.dreamGiftNameLabel.text = dreamGiftArray[0].catalogueName ?? ""
        self.productPoints.text = String(dreamGiftArray[0].pointsRequired ?? 0)
        self.redeemablePoints.text = String(dreamGiftArray[0].pointsBalance ?? 0)
        self.pointsRequiredToRedeem.text = String(dreamGiftArray[0].pointsRequiredToRedeem ?? 0)
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.yourDreamGift.text = "Your Dream Gift"
            self.productPts.text = "Product Points"
            self.redeemablePts.text = "Redeemable Points"
            self.ptsRequiredtoRedeem.text = "Points required to redeem"
        } else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.yourDreamGift.text = "आपका स्वप्न उपहार"
            self.productPts.text = "उत्पाद अंक"
            self.redeemablePts.text = "रिडीमेबल अंक"
            self.ptsRequiredtoRedeem.text = "रिडीम करने के लिए आवश्यक अंक"
        } else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4" {
            self.yourDreamGift.text = "మీ డ్రీమ్ గిఫ్ట్"
            self.productPts.text = "ఉత్పత్తి పాయింట్లు"
            self.redeemablePts.text = "రీడీమ్ చేయదగిన పాయింట్లు"
            self.ptsRequiredtoRedeem.text = "రిడీమ్ చేయడానికి అవసరమైన పాయింట్లు"
        } else {
            self.yourDreamGift.text = "আপনার স্বপ্ন উপহার"
            self.productPts.text = "পণ্য পয়েন্ট"
            self.redeemablePts.text = "রিডিমেবল পয়েন্ট"
            self.ptsRequiredtoRedeem.text = "রিডিম করার জন্য প্রয়োজনীয় পয়েন্ট"
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
