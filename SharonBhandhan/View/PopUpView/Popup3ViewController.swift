//
//  Popup3ViewController.swift
//  Sharon Secure
//
//  Created by admin on 18/07/22.
//

import UIKit
import Toast_Swift
protocol PopUpDelegate2: NSObject{
    func didTapYesButton(_ vc: Popup3ViewController)
}

class Popup3ViewController: BaseViewController {

    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var nobutton: UIButton!
    @IBOutlet weak var textMessage: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var itsFrom = ""
    var titleInfo = ""
    var discriptionInfo = ""
    var delegate:PopUpDelegate2!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.closeButton.isHidden = true
        if itsFrom == "Scanner"{
            self.textMessage.text = self.discriptionInfo
        }else if itsFrom == "GenerateWarranty"{
            self.textMessage.text = self.discriptionInfo
        }
      
        // Do any additional setup after loading the view.
    }
    @IBAction func yesbutton(_ sender: Any) {
        if itsFrom == "Scanner"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("alertPopUp"), object: nil)
            }
        }else if itsFrom == "GenerateWarranty"{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: Notification.Name("alertPopUpWarranty"), object: nil)
            }
        }else{
            self.dismiss(animated: true, completion: nil)
        }
        self.delegate!.didTapYesButton(self)
       
    }
    
    @IBAction func nobutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBUTTON(_ sender: Any) {
     //   self.dismiss(animated: true, completion: nil)
    }
    
    deinit{
        print("All memory has been deallocated by system")
    }
}
