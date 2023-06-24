//
//  DOBVC.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 16/04/2022.
//

import UIKit
import LanguageManager_iOS

protocol DateSelectedDelegate {
    func acceptDate(_ vc: DOBVC)
    func declineDate(_ vc: DOBVC)
}

class DOBVC: UIViewController {
    
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var datepicker: UIDatePicker!
    var isComeFrom = ""
    var selectedDate = ""
    var delegate: DateSelectedDelegate!
    let date = Date()
    let nameFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        datepicker.maximumDate = date
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cancel.setTitle("lDeclineKEY".localiz(), for: .normal)
        self.confirm.setTitle("lAcceptKEY".localiz(), for: .normal)
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.cancel.setTitle("Decline", for: .normal)
//            self.confirm.setTitle("Accept", for: .normal)
//            
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.cancel.setTitle("मना करना", for: .normal)
//            self.confirm.setTitle("स्वीकार करना", for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.cancel.setTitle("প্রত্যাখ্যান", for: .normal)
//            self.confirm.setTitle("গ্রহণ করুন", for: .normal)
//        }else{
//            self.cancel.setTitle("తిరస్కరించు", for: .normal)
//            self.confirm.setTitle("అంగీకరించు", for: .normal)
//        }
        
    }
    
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            self.dismiss(animated: true, completion: nil)

        }
    }
    @IBAction func confirm(_ sender: Any) {
        if isComeFrom == "1"{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            selectedDate = formatter.string(from: datepicker.date)
            self.delegate.acceptDate(self)
        }else if isComeFrom == "2"{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            selectedDate = formatter.string(from: datepicker.date)
            self.delegate.acceptDate(self)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
