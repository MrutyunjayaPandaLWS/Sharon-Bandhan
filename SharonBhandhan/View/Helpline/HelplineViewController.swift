//
//  HelplineViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Lottie
import Firebase


class HelplineViewController: UIViewController {
    
    
    @IBOutlet weak var informationLbl: UILabel!
    @IBOutlet weak var callInfo: UILabel!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    var fromSideMenu = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // playAnimation()
        languagelocalization()
        mobileNumber.text = "+91-7845858414"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Helpline")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
//    func playAnimation(){
//        animationView = .init(name: "lf30_editor_besjzwv5")
//          animationView!.frame = animationLottieView.bounds
//          // 3. Set animation content mode
//          animationView!.contentMode = .scaleAspectFit
//          // 4. Set animation loop mode
//          animationView!.loopMode = .loop
//          // 5. Adjust animation speed
//          animationView!.animationSpeed = 0.5
//        animationLottieView.addSubview(animationView!)
//          // 6. Play animation
//          animationView!.play()
//
//    }
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.informationLbl.text = "For any questions and queries on the CenturyPly Loyalty Program. Please give a miss call on the following number"
            self.callInfo.text = "GIVE A MISSED CALL ON"
            self.header.text = "Helpline Call"

        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.informationLbl.text = "सेंचुरीप्लाई लॉयल्टी प्रोग्राम पर किसी भी प्रश्न और प्रश्न के लिए। कृपया निम्नलिखित नंबर पर मिस कॉल दें"
            self.callInfo.text = "मिस्ड कॉल ऑन करें"
            self.header.text = "हेल्पलाइन कॉल"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.informationLbl.text = "সেঞ্চুরিপ্লাই লয়্যালটি প্রোগ্রামে যেকোনো প্রশ্ন এবং প্রশ্নের জন্য। অনুগ্রহ করে নিচের নাম্বারে একটি মিস কল দিন"
            self.callInfo.text = "একটি মিসড কল দিন"
            self.header.text = "হেল্পলাইন কল"
            
        }else{
            self.informationLbl.text = "సెంచరీప్లై లాయల్టీ ప్రోగ్రామ్‌లో ఏవైనా ప్రశ్నలు మరియు ప్రశ్నల కోసం. దయచేసి కింది నంబర్‌కు మిస్ కాల్ ఇవ్వండి"
            self.callInfo.text = "మిస్డ్ కాల్ ఇవ్వండి"
            self.header.text = "హెల్ప్‌లైన్ కాల్"
        }
    }
    @IBAction func backButton(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func missedCallButton(_ sender: Any) {
        if let phoneCallURL = URL(string: "tel://\(+918955177400)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
                
            }
        }
    }
}
