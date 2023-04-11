//
//  CP_NeedCameraAccess_VC.swift
//  Sharon Secure
//
//  Created by Arokia IT on 9/9/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import Toast_Swift

class CP_NeedCameraAccess_VC: SP_Base_VC {
    var selectedindex = 0
    @IBOutlet weak var backBTNview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewDidLayoutSubviews() {
        self.backBTNview.layer.cornerRadius = self.backBTNview.frame.width / 2
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func grantAccess(_ sender: Any) {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CP_Scanner_VC") as? CP_Scanner_VC
                vc?.selectedindex = self.selectedindex

            self.navigationController?.pushViewController(vc!, animated: true)
            }
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                if granted == true {
                    DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CP_Scanner_VC") as? CP_Scanner_VC
                        vc?.selectedindex = self.selectedindex

                    self.navigationController?.pushViewController(vc!, animated: true)
                    }
                } else {
                    DispatchQueue.main.async{
                    self.alertToEncourageCameraAccessInitially()
                    }
                }
            })
        }
    }
    func alertToEncourageCameraAccessInitially() {
        let alert = UIAlertController(
            title: "IMPORTANT",
            message: "Camera access required for Scanning QR Codes",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .cancel, handler: { (alert) -> Void in
            UIApplication.shared.openURL(URL(string: UIApplication.openSettingsURLString)!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
