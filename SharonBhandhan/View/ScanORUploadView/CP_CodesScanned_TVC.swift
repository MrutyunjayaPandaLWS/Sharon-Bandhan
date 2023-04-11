//
//  CP_CodesScanned_TVC.swift
//  Sharon Secure
//
//  Created by Arokia IT on 9/9/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
protocol closeCodesDelegate : class {
func closeBtn(_ cell: CP_CodesScanned_TVC)

}
class CP_CodesScanned_TVC: UITableViewCell {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var genuineProductLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var closeButton: UIButton!
    var delegate:closeCodesDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func closeButton(_ sender: Any) {
        delegate!.closeBtn(self)
    }
    
}
