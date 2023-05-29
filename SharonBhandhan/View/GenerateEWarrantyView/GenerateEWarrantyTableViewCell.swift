//
//  GenerateEWarrantyTableViewCell.swift
//  Sharon Secure
//
//  Created by admin on 16/07/22.
//

import UIKit

protocol GenerateEwarrantyDelegate : class {
func GenerateBtn(_ cell: GenerateEWarrantyTableViewCell)
}

class GenerateEWarrantyTableViewCell: UITableViewCell {

    @IBOutlet weak var generateewareanty: UIButton!
    @IBOutlet weak var generatedfate: UILabel!
    @IBOutlet weak var noofCodes: UILabel!
    @IBOutlet weak var productDescriptionlabel: UILabel!
    
    var delegate:GenerateEwarrantyDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func genertaeEButton(_ sender: Any) {
        self.delegate?.GenerateBtn(self)

    }
}
