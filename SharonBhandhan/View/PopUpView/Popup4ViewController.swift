//
//  Popup4ViewController.swift
//  Sharon Secure
//
//  Created by admin on 18/07/22.
//

import UIKit
import Toast_Swift
protocol Popup4Delegate: class {
    func othersDidTap(_ vc: Popup4ViewController)
    func selfDidTap(_ vc: Popup4ViewController)
}
class Popup4ViewController: BaseViewController {

    @IBOutlet weak var textmessage: UILabel!
    @IBOutlet weak var closeButtn: UIButton!
    
    var delegate:Popup4Delegate?
    var selectedITEM = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func noButton(_ sender: Any) {
        self.selectedITEM = "Others"
        self.delegate?.othersDidTap(self)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func yesbutton(_ sender: Any) {
        self.selectedITEM = "Self"
        self.delegate?.selfDidTap(self)

    }
    
}
