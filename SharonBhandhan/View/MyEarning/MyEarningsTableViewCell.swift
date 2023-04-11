//
//  MyEarningsTableViewCell.swift
//  CenturyPly_JSON
//
//  Created by admin on 14/03/22.
//

import UIKit

class MyEarningsTableViewCell: UITableViewCell {
    @IBOutlet weak var myEarnedDate: UILabel!
    
    @IBOutlet weak var giftId: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
