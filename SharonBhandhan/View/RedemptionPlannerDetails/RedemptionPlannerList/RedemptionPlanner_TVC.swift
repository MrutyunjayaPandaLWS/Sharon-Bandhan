//
//  RedemptionPlanner_TVC.swift
//  centuryDemo
//
//  Created by Arkmacbook on 12/03/22.
//

import UIKit

protocol RedemptionPlannerDelegate{
    func removeProduct(_ cell: RedemptionPlanner_TVC)
    func producDetails(_ cell: RedemptionPlanner_TVC)
    func productRedeem(_ cell: RedemptionPlanner_TVC)
}

class RedemptionPlanner_TVC: UITableViewCell {

    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var desireDateHeadingLabel: UILabel!
    @IBOutlet var desireDateLabel: UILabel!
    @IBOutlet var pointsHeadingLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet weak var productDetailsBTN: UIButton!
    @IBOutlet weak var productRedeemBTN: GradientButton!
    @IBOutlet weak var removeProductBTN: UIButton!
    @IBOutlet weak var details: UIButton!
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var delegate: RedemptionPlannerDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.desireDateHeadingLabel.text = "Redemption Planner"
            self.pointsHeadingLabel.text = "Points"
            self.desireDateHeadingLabel.text = "Desired Date"
            self.details.setTitle("Details", for: .normal)
            self.productRedeemBTN.setTitle("Redeem", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.desireDateHeadingLabel.text = "मोचन योजनाकार"
            self.pointsHeadingLabel.text = "पॉइंट्स"
            self.desireDateHeadingLabel.text = "वांछित तारीख"
            self.details.setTitle("विवरण", for: .normal)
            self.productRedeemBTN.setTitle("भुनाना", for: .normal)
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.desireDateHeadingLabel.text = "রিডেম্পশন প্ল্যানার"
            self.pointsHeadingLabel.text = "পয়েন্ট"
            self.desireDateHeadingLabel.text = "কাঙ্খিত তারিখ"
            self.details.setTitle("বিস্তারিত", for: .normal)
            self.productRedeemBTN.setTitle("রিডিম", for: .normal)
        }else{
            self.desireDateHeadingLabel.text = "విముక్తి ప్లానర్"
            self.pointsHeadingLabel.text = "పాయింట్లు"
            self.desireDateHeadingLabel.text = "కోరుకున్న తేదీ"
            self.details.setTitle("వివరాలు", for: .normal)
            self.productRedeemBTN.setTitle("విమోచించు", for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    @IBAction func detailsButton(_ sender: Any) {
        self.delegate.producDetails(self)
    }
    
    @IBAction func redeemButton(_ sender: Any) {
        if self.verifiedStatus == 6 || self.verifiedStatus == 4{
            if self.checkAccountStatus == "1"{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }else{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }
            
        }else{
            self.delegate.productRedeem(self)
        }
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.delegate.removeProduct(self)
    }
}
