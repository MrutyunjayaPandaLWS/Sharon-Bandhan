//
//  OffersTableViewCell.swift
//  CenturyPly_JSON
//
//  Created by admin on 14/03/22.
//

import UIKit

protocol OffersandPromotionsDelegate{
    
    func offersDetails(_ cell: OffersTableViewCell)
}

class OffersTableViewCell: UITableViewCell {

    @IBOutlet weak var offersImg: UIImageView!
    @IBOutlet weak var offersName: UILabel!
    @IBOutlet weak var viewBTN: UIButton!
    
    var delegate: OffersandPromotionsDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                self.viewBTN.setTitle("View", for: .normal)
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                self.viewBTN.setTitle("देखना", for: .normal)
                
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                self.viewBTN.setTitle("দেখুন", for: .normal)
            }else{
                self.viewBTN.setTitle("వీక్షించండి", for: .normal)
            }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func viewBTN(_ sender: Any) {
        self.delegate?.offersDetails(self)
    }
}
