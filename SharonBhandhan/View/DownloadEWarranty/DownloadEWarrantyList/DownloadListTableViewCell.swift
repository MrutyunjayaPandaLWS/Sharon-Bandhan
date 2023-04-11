//
//  DownloadListTableViewCell.swift
//  CenturyPly_JSON
//
//  Created by admin on 15/03/22.
//

import UIKit
protocol eWarrantyDelegate: AnyObject {
    func downloadEWarranty(_ vc: DownloadListTableViewCell)
}

class DownloadListTableViewCell: UITableViewCell {

    @IBOutlet var customerName: UILabel!
    @IBOutlet var mobileNumberLabel: UILabel!
    @IBOutlet var generatedDate: UILabel!
    
    @IBOutlet weak var customerLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var generatedLbl: UILabel!
    @IBOutlet weak var downloadLbl: UILabel!
    var delegate: eWarrantyDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.customerLbl.text = "Customer Name"
            self.mobileLbl.text = "Mobile Number"
            self.generatedLbl.text = "Generated Date"
            self.downloadLbl.text = "Download E-Warranty"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.customerLbl.text = "ग्राहक नाम"
            self.mobileLbl.text = "मोबाइल नंबर"
            self.generatedLbl.text = "उत्पन्न तिथि"
            self.downloadLbl.text = "ई-वारंटी डाउनलोड करें"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.customerLbl.text = "গ্রাহকের নাম"
            self.mobileLbl.text = "মোবাইল নম্বর"
            self.generatedLbl.text = "তৈরি তারিখ"
            self.downloadLbl.text = "ই-ওয়ারেন্টি ডাউনলোড করুন"
        }else{
            self.customerLbl.text = "కస్టమర్ పేరు"
            self.mobileLbl.text = "మొబైల్ నంబర్"
            self.generatedLbl.text = "సృష్టించబడిన తేదీ"
            self.downloadLbl.text = "ఇ-వారెంటీని డౌన్‌లోడ్ చేయండి"
          }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func downloadButtonDidTap(_ sender: Any) {
        self.delegate.downloadEWarranty(self)
    }
    
}
