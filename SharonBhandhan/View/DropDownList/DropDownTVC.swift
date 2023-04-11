//
//  DropDownTVC.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 19/04/2022.
//

import UIKit

class DropDownTVC: UITableViewCell {

    @IBOutlet weak var selectedItem: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
