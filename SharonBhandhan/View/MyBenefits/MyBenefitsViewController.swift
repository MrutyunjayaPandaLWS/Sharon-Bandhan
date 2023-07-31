//
//  MyBenefitsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Firebase
import LanguageManager_iOS

class MyBenefitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    

    @IBOutlet weak var myBenefitTV: UITableView!
    @IBOutlet weak var header: UILabel!
    var fromSideMenu = ""
    var imageName = ["Group 6548","Group 6549","Group 6550","Group 6551","Group 6552","Group 6553"]
    var descriptionName = ["Receive Benefits Upon Joining","Earn Points for your purchase","Redeem Reward points for Attractive Gift Items","Redemption Planner - Journey to Redeem your Dream Products","Interactive Mobile App & Website","Become a SharonBandhan Member and Be a Winner"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.header.text = "mbMyBenefitsKEY".localiz()
        self.myBenefitTV.dataSource = self
        self.myBenefitTV.delegate = self
        self.myBenefitTV.register(UINib(nibName: "MyBenefitTVC", bundle: nil), forCellReuseIdentifier: "MyBenefitTVC")
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.header.text = "mbMyBenefitsKEY".localiz()
////           self.benefitsImage.image = UIImage(named: "hin")
//        }else  if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//           self.header.text = "मेरेलाभ"
////           self.benefitsImage.image = UIImage(named: "hin")
//
//        }else  if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//           self.header.text = "నాప్రయోజనాలు"
////           self.benefitsImage.image = UIImage(named: "tel")
//
//        }else{
//           self.header.text = "আমার লাভ"
////           self.benefitsImage.image = UIImage(named: "ban")
//
//           }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "My Benefits")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    @IBAction func backButton(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptionName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyBenefitTVC", for: indexPath) as! MyBenefitTVC
        cell.logo.image = UIImage(named: imageName[indexPath.row])
        cell.descriptionLbl.text = descriptionName[indexPath.row].localiz()
        return  cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
