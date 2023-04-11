//
//  MyRedemptionsTableViewCell.swift
//  CenturyPly_JSON
//
//  Created by admin on 14/03/22.
//

import UIKit

class MyRedemptionsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var tdsvalue: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var redemptionDate: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productRefNo: UILabel!
    @IBOutlet weak var productCateogory: UILabel!
    @IBOutlet weak var productPoints: UILabel!
    @IBOutlet weak var productStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        productTitle.roundCorners(corners: [.bottomRight], radius: 20)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
