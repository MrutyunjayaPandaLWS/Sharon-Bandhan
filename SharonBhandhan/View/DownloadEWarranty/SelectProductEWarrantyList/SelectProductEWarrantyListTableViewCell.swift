//
//  SelectProductEWarrantyListTableViewCell.swift
//  CenturyPly_JSON
//
//  Created by admin on 15/03/22.
//

import UIKit
import LanguageManager_iOS

protocol quantityDelegate: AnyObject {
    func quantityDidTap(_ vc: SelectProductEWarrantyListTableViewCell)
}

class SelectProductEWarrantyListTableViewCell: UITableViewCell {

    @IBOutlet var totalQRCodeLael: UILabel!
    @IBOutlet var brandNameLabel: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var areaLabel: UILabel!
    @IBOutlet var enterQtyTF: UITextField!
    
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var productLbl: UILabel!
    @IBOutlet weak var totalQRCode: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var enterQty: UILabel!
    
    var delegate: quantityDelegate!
    var addedValue = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        self.brandLbl.text = "ewBrandKEY".localiz()
        self.productLbl.text = "ewProductKEY"
        self.totalQRCode.text = "ewTotalQRCodesKEY".localiz()
        self.enterQty.text = "ewEnterQuantityKEY".localiz()
        self.enterQtyTF.placeholder = "ewEnterQuantityKEY".localiz()
        
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.brandLbl.text = "ewBrandKEY".localiz()
//            self.productLbl.text = "ewProductKEY"
//            self.totalQRCode.text = "ewTotalQRCodesKEY".localiz()
//            self.enterQty.text = "ewEnterQuantityKEY".localiz()
//            self.enterQtyTF.placeholder = "ewEnterQuantityKEY".localiz()
//
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.brandLbl.text = "ब्रैंड"
//            self.productLbl.text = "उत्पाद"
//            self.totalQRCode.text = "कुल क्यूआर कोड"
//            self.enterQty.text = "मात्रा दर्ज करें"
//            self.enterQtyTF.placeholder = "मात्रा दर्ज करें"
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.brandLbl.text = "ব্র্যান্ড"
//            self.productLbl.text = "প্রোডাক্ট"
//            self.totalQRCode.text = "মোট QR কোড"
//            self.enterQty.text = "পরিমাণ লিখুন"
//            self.enterQtyTF.placeholder = "পরিমাণ লিখুন"
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//            self.brandLbl.text = "బ్రాండ్"
//            self.productLbl.text = "ఉత్పత్తి"
//            self.totalQRCode.text = "మొత్తం QR కోడ్"
//            self.enterQty.text = "మొత్తాన్ని నమోదు చేయండి"
//            self.enterQtyTF.placeholder = "మొత్తాన్ని నమోదు చేయండి"
//          }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func quantityDidEnd(_ sender: Any) {
        addedValue = 1
        self.delegate.quantityDidTap(self)
    }
    
}
