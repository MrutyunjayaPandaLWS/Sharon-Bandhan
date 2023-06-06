//
//  Products_TVC.swift
//  centuryDemo
//
//  Created by Arkmacbook on 10/03/22.
//

import UIKit
protocol AddedToCartOrPlannerDelegate{
    func addToCart(_ cell: Products_TVC)
    func addToPlanner(_ cell: Products_TVC)
}

class Products_TVC: UITableViewCell{
    

    @IBOutlet var productImage: UIImageView!
    @IBOutlet var categoryTypeLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var pointsHeadingLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet weak var addToPlanner: GradientButton!
    @IBOutlet weak var addedToPlanner: GradientButton!
    @IBOutlet weak var addedToCart: GradientButton!
    var verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")

    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    
    var delegate: AddedToCartOrPlannerDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        languagelocalization()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.addToCartButton.setTitle("view".localizableString(loc: "en"), for: .normal)
            self.addedToCart.setTitle("rcAddedToCartKEY".localizableString(loc: "en"), for: .normal)
            self.addToPlanner.setTitle("Add To Planner", for: .normal)
            self.addedToPlanner.setTitle("Added To Planner", for: .normal)
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.addToCartButton.setTitle("view".localizableString(loc: "hi"), for: .normal)
            self.addedToCart.setTitle("rcAddedToCartKEY".localizableString(loc: "hi"), for: .normal)
            self.addToPlanner.setTitle("प्लानर में जोड़ें", for: .normal)
            self.addedToPlanner.setTitle("नियोजक में जोड़ा गया", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.addToCartButton.setTitle("view".localizableString(loc: "ta-IN"), for: .normal)
            self.addedToCart.setTitle("rcAddedToCartKEY".localizableString(loc: "ta-IN"), for: .normal)
            self.addToPlanner.setTitle("திட்டமிடுபவருக்குச் சேர்க்கவும்", for: .normal)
            self.addedToPlanner.setTitle("பிளானரில் சேர்க்கப்பட்டது", for: .normal)
            
        }else{
            self.addToCartButton.setTitle("view".localizableString(loc: "te"), for: .normal)
            self.addedToCart.setTitle("rcAddedToCartKEY".localizableString(loc: "te"), for: .normal)
            self.addToPlanner.setTitle("ప్లానర్‌కి జోడించు", for: .normal)
            self.addedToPlanner.setTitle("ప్లానర్‌కి చేర్చబడింది", for: .normal)
        }
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        
        if self.verifiedStatus == 6 || self.verifiedStatus == 4{
            if self.checkAccountStatus == "1"{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }else{
                NotificationCenter.default.post(name: .verificationStatus, object: nil)
            }
            
        }else{
           self.delegate.addToCart(self)
       }
        
    }
    @IBAction func addToPlanners(_ sender: Any) {
    
//        if self.verifiedStatus == 6 || self.verifiedStatus == 4{
//            if self.checkAccountStatus == "1"{
//                NotificationCenter.default.post(name: .verificationStatus, object: nil)
//            }else{
//                NotificationCenter.default.post(name: .verificationStatus, object: nil)
//            }
//
//        }else{
        self.delegate.addToPlanner(self)
//    }
    }
}
