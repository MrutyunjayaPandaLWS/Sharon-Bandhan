//
//  SideMenuViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Lottie
import SlideMenuControllerSwift
import CoreData
class SideMenuViewController: BaseViewController, popUpDelegate {
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var customerNameLabel: UILabel!
    @IBOutlet weak var sidemenutableView: UITableView!
    @IBOutlet var tierImageView: UIImageView!
    @IBOutlet var tierNameLabel: UILabel!
    @IBOutlet var membershipID: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var memberSince: UILabel!
    @IBOutlet var versionNumber: UILabel!
    @IBOutlet var bottomView: GradientView!
    @IBOutlet weak var membershipIdTitle: UILabel!
    @IBOutlet weak var ptsTitle: UILabel!
    @IBOutlet weak var myAccount: UIButton!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var deleteAccBtn: GradientButton!
    
    var vm = SideMenuViewModel()
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    var requestAPIs = RestAPI_Requests()
    
    var sideMenuListArray =  [MenuMaster]()
    var parameters: JSON?
                                 
    var sideMenuListArray1 = ["Home","Scan QR Code","Upload QR Code","Generate E-warranty","My dream gift","Redemption catelogue","My Earning","My Redemption","Redemption Planner" ,"Offers and Promotions","My Benefits","Unique Features","Lodge Query","Helpline Call","Terms and condition"]
//    var sideMenyImagesArray = ["home 2", "qr 2", "uploadalt 2", "time-interval 2", "certificatealt 2", "gift 2", "bxs-coin-stack 2", "reademailalt 2", "calendar3-fill 2", "bxs-offer 2", "thumbs-up-solid 2", "social-buffer 2", "query 2", "headset 2", "document-text-sharp 2"]
    var sideMenuListImageArray = ["home 2","qr 2","uploadalt 2","certificatealt 2","gift 2","card-giftcard 2","bxs-coin-stack 2","reademailalt 2","calendar3-fill 2","bxs-offer 2","thumbs-up-solid 2","social-buffer 2","query 2","headset 2","document-text-sharp 2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
     
        NotificationCenter.default.addObserver(self, selector: #selector(deletedAccount), name: Notification.Name.deleteAccount, object: nil)
        self.sidemenutableView.register(UINib(nibName: "SidemenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SidemenuTableViewCell")
        self.sidemenutableView.delegate = self
        self.sidemenutableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(closingSideMenu), name: Notification.Name.sideMenuClosing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deletedAccount), name: Notification.Name.deleteAccount, object: nil)
        
    }
    override func viewWillLayoutSubviews() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        self.profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profileImageView.layer.borderWidth = 1.0
        self.profileImageView.clipsToBounds = true
        }

    override func viewDidLayoutSubviews() {
        bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        deleteAccBtn.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dashboardAPI()
        menuListApi()
        languagelocalization()
    }
    override func viewDidAppear(_ animated: Bool) {
     
    }
    
    @objc func closingSideMenu(){
        self.closeLeft()

    }
    @objc func deletedAccount(){
        
        UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
        clearTable()
        clearTable1()
        clearTable2()
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        if #available(iOS 13.0, *) {
            let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate
            sceneDelegate?.setInitialViewAsRootViewController()

        } else {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.setInitialViewAsRootViewController()
        }
     
    }
    
    
    @IBAction func myAccount(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func missedCall(_ sender: Any) {
        if let phoneCallURL = URL(string: "tel://\(+918955177400)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
                
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.setValue(false, forKey: "IsloggedIn?")
        clearTable()
        clearTable1()
        clearTable2()
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                let sceneDelegate = self.view.window!.windowScene!.delegate as! SceneDelegate
                sceneDelegate.setInitialViewAsRootViewController()
            } else {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setInitialViewAsRootViewController()
            }
        }
    }
    
    @IBAction func deleteAccountBTN(_ sender: Any) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "No Internet. Please check your internet connection"
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "", message: "Are you sure you really want to delete your account?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
            self.parameters = [
                "ActionType": 1,
                "userid":"\(self.userID)"
            ] as [String : Any]
            print(self.parameters!)
                self.vm.deleteAccount(parameters: self.parameters!) { response in
                    DispatchQueue.main.async {
                        print(response?.returnMessage ?? "-1")
                        if response?.returnMessage ?? "-1" == "1"{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.itsComeFrom = "AccounthasbeenDeleted"
                                vc!.descriptionInfo = "Account deleted successfully"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                                }
                        }else{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.itsComeFrom = "AccounthasbeenDeleted"
                                vc!.descriptionInfo = "Something went wrong please try again later!"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.present(vc!, animated: true, completion: nil)
                                }
                        }
                      self.stopLoading()
                        }
                }
        }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        }
    }
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.versionNumber.text = "v 9.7"
            self.membershipIdTitle.text = "Membership ID"
            self.ptsTitle.text = "Points"
            self.myAccount.setTitle("My Account", for: .normal)
            self.logout.setTitle("Logout", for: .normal)
            self.messageLbl.text = "GIVE A MISSED CALL ON"
            self.deleteAccBtn.setTitle("Delete Account", for: .normal)
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.membershipIdTitle.text = "सदस्यता आईडी"
            self.ptsTitle.text = "अंक"
            self.myAccount.setTitle("मेरा खाता", for: .normal)
            self.logout.setTitle("लॉग आउट", for: .normal)
            self.messageLbl.text = "मिस्ड कॉल ऑन करें"
            self.versionNumber.text = "वी 9.7"
            self.deleteAccBtn.setTitle("खाता हटा दो", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.membershipIdTitle.text = "সদস্যতা আইডি"
            self.ptsTitle.text = "পয়েন্ট"
            self.myAccount.setTitle("আমার একাউন্ট", for: .normal)
            self.logout.setTitle("প্রস্থান", for: .normal)
            self.messageLbl.text = "একটি মিসড কল দিন"
            self.versionNumber.text = "ভি 9.7"
            self.deleteAccBtn.setTitle("অ্যাকাউন্ট মুছুন", for: .normal)
        }else{
            self.membershipIdTitle.text = "మెంబర్‌షిప్ ఐడి"
            self.ptsTitle.text = "పాయింట్లు"
            self.myAccount.setTitle("నా ఖాతా", for: .normal)
            self.logout.setTitle("లాగ్అవుట్", for: .normal)
            self.messageLbl.text = "మిస్డ్ కాల్ ఇవ్వండి"
            self.versionNumber.text = "వి 9.7"
            self.deleteAccBtn.setTitle("ఖాతాను తొలగించు", for: .normal)
        }
    }
    
    func clearTable(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ScanCodeSTORE")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    func clearTable1(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UploadedCodes")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    func clearTable2(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SendUploadedCodes")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    
    
    //Api:-
    
    func dashboardAPI() {
        let parameters = [
            "ActorId":"\(userID)"
        ]
        self.vm.dashboardAPICall(parameters: parameters) { response in
            DispatchQueue.main.async {
                self.customerNameLabel.text = response?.lstCustomerFeedBackJsonApi?[0].firstName ?? ""
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    self.memberSince.text = "Member Since: \(response?.objCustomerDashboardList?[0].memberSince ?? "")"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                    self.memberSince.text = "से सदस्ये: \(response?.objCustomerDashboardList?[0].memberSince ?? "")"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    self.memberSince.text = "যেহেতু সদস্য: \(response?.objCustomerDashboardList?[0].memberSince ?? "")"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    self.memberSince.text = "నుండి సభ్యుడు: \(response?.objCustomerDashboardList?[0].memberSince ?? "")"
                }
                let customerImage = String(response?.lstCustomerFeedBackJsonApi?[0].customerImage ?? "").dropFirst()
                self.profileImageView.sd_setImage(with: URL(string: PROMO_IMG + "\(customerImage)"), placeholderImage: UIImage(named: "icons8-test-account-96"))
                self.tierNameLabel.text = response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? ""
                if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Bronze" {
                    self.tierImageView.image = UIImage(named: "grade1")
                } else if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Gold" {
                    self.tierImageView.image = UIImage(named: "grade2")
                } else if response?.lstCustomerFeedBackJsonApi?[0].customerGrade ?? "" == "Silver" {
                    self.tierImageView.image = UIImage(named: "grade3")
                } else {
                    self.tierImageView.image = UIImage(named: "grade3")
                }
                self.membershipID.text = response?.lstCustomerFeedBackJsonApi?[0].loyaltyId ?? ""
                self.pointsLabel.text = String(response?.objCustomerDashboardList?[0].redeemablePointsBalance ?? 0)
                self.stopLoading()
            }
        }
    }
    
    func menuListApi(){
        let parameters = [
            "ActorId": userID,
             "MenuSourceId": 3,
             "UserType": "CUSTOMER"
        ] as [String:Any]
        self.vm.menuList(parameters: parameters) { response in
            let tempData = response?.menuMaster ?? []
            self.vm.menuListArray.removeAll()
            for item in tempData{
                if item.idMenu != 423{
                    self.vm.menuListArray.append(item)
                }
            }
                print(self.vm.menuListArray.count, "Menu Listing Count")
                if self.vm.menuListArray.count != 0 {
//                    self.sidemenutableView.isHidden = false
                    
                }else{
//                    self.sidemenutableView.isHidden = true
                }
            self.sidemenutableView.reloadData()
        }
        
    }
    
}
extension SideMenuViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.vm.menuListArray.count
        if self.vm.menuListArray.count == 0{
            return sideMenuListArray1.count
        }else{
            return self.vm.menuListArray.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SidemenuTableViewCell") as? SidemenuTableViewCell
        
        if self.vm.menuListArray.count == 0{
            cell?.sideMenuLabel.text = sideMenuListArray1[indexPath.row]
            cell?.sideMenuImageView.image = UIImage(named: sideMenuListImageArray[indexPath.row])
        }else{
                    if self.vm.menuListArray[indexPath.row].idMenu ?? 0  == 397{
                        //Home
                        cell?.sideMenuImageView.image = UIImage(named: "home 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Home"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "गृह"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "বাড়ি"
                        }else{
                            cell?.sideMenuLabel.text = "హోమ్"
                        }
            
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 398{
                        //Scan QR Code
                        cell?.sideMenuImageView.image = UIImage(named: "qr 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Scan QR Code"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "स्कैन क्यू आर कोड"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "QR কোড স্ক্যান করুন"
                        }else{
                            cell?.sideMenuLabel.text = "QR కోడ్‌ని స్కాన్ చేయండి"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 399{
                        //Upload Code
                        cell?.sideMenuImageView.image = UIImage(named: "uploadalt 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Upload Code"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "अपलोड कोड"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "আপলোড কোড"
                        }else{
                            cell?.sideMenuLabel.text = "అప్‌లోడ్ కోడ్"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 400{
                        //Code Status
                        cell?.sideMenuImageView.image = UIImage(named: "time-interval 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Code Status"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "कोड स्थिति"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "কোড স্ট্যাটাস"
                        }else{
                            cell?.sideMenuLabel.text = "కోడ్ స్థితి"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 401{
                        //Generate E Warranty
                        cell?.sideMenuImageView.image = UIImage(named: "certificatealt 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Generate E-warranty Certificate"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "ई-वारंटी प्रमाणपत्र जेनरेट करें"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "ই-ওয়ারেন্টি শংসাপত্র তৈরি করুন"
                        }else{
                            cell?.sideMenuLabel.text = "ఇ-వారంటీ సర్టిఫికెట్‌ని రూపొందించండి"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 402{
                        // My Dream Gift
                        cell?.sideMenuImageView.image = UIImage(named: "gift 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "My Dream Gift"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "माई ड्रीम गिफ्ट"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "আমার স্বপ্ন উপহার"
                        }else{
                            cell?.sideMenuLabel.text = "నా డ్రీమ్ గిఫ్ట్"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 404{
                        // Redemption Catalogue
                        cell?.sideMenuImageView.image = UIImage(named: "bxs-coin-stack 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Redemption Catalogue"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "मोचन कैटलॉग"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "রিডেম্পশন ক্যাটালগ"
                        }else{
                            cell?.sideMenuLabel.text = "విముక్తి కేటలాగ్"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 405{
                        // Redemption Planner
                        cell?.sideMenuImageView.image = UIImage(named: "calendar3-fill 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Redemption Planner"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "मोचन योजनाकार"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "রিডেম্পশন প্ল্যানার"
                        }else{
                            cell?.sideMenuLabel.text = "విముక్తి ప్లానర్"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 406{
                        // My Earning
                        cell?.sideMenuImageView.image = UIImage(named: "bxs-coin-stack 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "My Earning"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "मेरी कमाई"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "আমার উপার্জন"
                        }else{
                            cell?.sideMenuLabel.text = "నా ఎర్నింగ్"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 407{
                        // My Redemptions
                        cell?.sideMenuImageView.image = UIImage(named: "reademailalt 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "My Redemptions"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "मेरे मोचन"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "আমার রিডেম্পশন"
                        }else{
                            cell?.sideMenuLabel.text = "నా విముక్తి"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 408{
                        // Offers and Promotions
                        cell?.sideMenuImageView.image = UIImage(named: "bxs-offer 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Offers and Promotions"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "प्रस्ताव और प्रचार"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "অফার এবং প্রচার"
                        }else{
                            cell?.sideMenuLabel.text = "ఆఫర్‌లు మరియు ప్రమోషన్‌లు"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 409{
                        // My Benefits
                        cell?.sideMenuImageView.image = UIImage(named: "thumbs-up-solid 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "My Benefits"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "मेरे लाभ"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "আমার উপকারিতা"
                        }else{
                            cell?.sideMenuLabel.text = "నా ప్రయోజనాలు"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 410{
                        // Unique Features
                        cell?.sideMenuImageView.image = UIImage(named: "social-buffer 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Unique Features"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "अद्वितीय विशेषताएं"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "অনন্য বৈশিষ্ট্য"
                        }else{
                            cell?.sideMenuLabel.text = "విశిష్ట ఫీచర్లు"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 411{
                        // Lodge Query
                        cell?.sideMenuImageView.image = UIImage(named: "query 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Lodge Query"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "लॉज क्वेरी"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "লজ কোয়েরি"
                        }else{
                            cell?.sideMenuLabel.text = "లాడ్జ్ క్వెరీ"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 412{
                        // HelpLine
                        cell?.sideMenuImageView.image = UIImage(named: "headset 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Helpline Call"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "हेल्पलाइन कॉल"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "হেল্পলাইন কল"
                        }else{
                            cell?.sideMenuLabel.text = "హెల్ప్‌లైన్ కాల్"
                        }
                    }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 413{
                        // Terms and Conditions
                        cell?.sideMenuImageView.image = UIImage(named: "document-text-sharp 2")
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            cell?.sideMenuLabel.text = "Terms & Conditions"
            
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            cell?.sideMenuLabel.text = "नियम एवं शर्तें"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            cell?.sideMenuLabel.text = "নিয়ম ও শর্তাবলী"
                        }else{
                            cell?.sideMenuLabel.text = "నిబంధనలు & షరతులు"
                        }
                    }
        }
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.vm.menuListArray.count == 0{
            if sideMenuListArray1[indexPath.row] == "Home"{
                self.slideMenuController()?.closeLeft()
            }else if sideMenuListArray1[indexPath.row] == "Scan QR Code"{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
                vc.itsFrom = "ScanCode"
                vc.fromSideMenu = "SideMenu"
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }else if sideMenuListArray1[indexPath.row] == "Upload QR Code"{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
                vc.itsFrom = "UploadCode"
                vc.fromSideMenu = "SideMenu"
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }else if sideMenuListArray1[indexPath.row] == ""{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeStatusListVC") as! CodeStatusListVC
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sideMenuListArray1[indexPath.row] == "Generate E-warranty"{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DownloadEWarrantyListViewController") as! DownloadEWarrantyListViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sideMenuListArray1[indexPath.row] == "My dream gift"{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DreamGiftListingViewController") as! DreamGiftListingViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sideMenuListArray1[indexPath.row] == "Redemption catelogue"{
            //Redemption Catalogue"
                
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionCatalogueVC") as! RedemptionCatalogueVC
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sideMenuListArray1[indexPath.row] == "Redemption Planner"{
                //Redemption Planner"
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionPlanner_VC") as! RedemptionPlanner_VC
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if sideMenuListArray1[indexPath.row] == "My Earning"{
                //"My Earning"
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyEarningsViewController") as! MyEarningsViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sideMenuListArray1[indexPath.row] == "My Redemption"{
                //"My Redemptions"
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyRedemptionsListViewController") as! MyRedemptionsListViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if sideMenuListArray1[indexPath.row] == "Offers and Promotions"{
                
                //"Offers and Promotions"
                
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OffersListViewController") as! OffersListViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if sideMenuListArray1[indexPath.row] == "My Benefits"{
                // My Benefits
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyBenefitsViewController") as! MyBenefitsViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if sideMenuListArray1[indexPath.row] == "Unique Features"{
                // Unique Features
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UniqueFeaturesViewController") as! UniqueFeaturesViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sideMenuListArray1[indexPath.row] == "Lodge Query"{
                // Lodge Query
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerQueryListingViewController") as! CustomerQueryListingViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sideMenuListArray1[indexPath.row] == "Helpline Call"{
                // HelpLine
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelplineViewController") as! HelplineViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if sideMenuListArray1[indexPath.row] == "Terms and condition"{
                // Terms and Conditions
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TermsAndConditionsVC") as! TermsAndConditionsVC
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            if self.vm.menuListArray[indexPath.row].idMenu ?? 0  == 397{
                self.slideMenuController()?.closeLeft()
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 398{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
                vc.itsFrom = "ScanCode"
                vc.fromSideMenu = "SideMenu"
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 399{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
                vc.itsFrom = "UploadCode"
                vc.fromSideMenu = "SideMenu"
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 400{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeStatusListVC") as! CodeStatusListVC
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 401{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DownloadEWarrantyListViewController") as! DownloadEWarrantyListViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 402{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DreamGiftListingViewController") as! DreamGiftListingViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 404{
            //Redemption Catalogue"
                
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionCatalogueVC") as! RedemptionCatalogueVC
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 405{
                //Redemption Planner"
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionPlanner_VC") as! RedemptionPlanner_VC
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 406{
                //"My Earning"
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyEarningsViewController") as! MyEarningsViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 407{
                //"My Redemptions"
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyRedemptionsListViewController") as! MyRedemptionsListViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 408{
                
                //"Offers and Promotions"
                
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OffersListViewController") as! OffersListViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 409{
                // My Benefits
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyBenefitsViewController") as! MyBenefitsViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 410{
                // Unique Features
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UniqueFeaturesViewController") as! UniqueFeaturesViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 411{
                // Lodge Query
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerQueryListingViewController") as! CustomerQueryListingViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 412{
                // HelpLine
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelplineViewController") as! HelplineViewController
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }else if self.vm.menuListArray[indexPath.row].idMenu ?? 0 == 413{
                // Terms and Conditions
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TermsAndConditionsVC") as! TermsAndConditionsVC
                vc.fromSideMenu = "SideMenu"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
        
//        if indexPath.row == 0 {
//            self.slideMenuController()?.closeLeft()
//        } else if indexPath.row == 1 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
//            vc.itsFrom = "ScanCode"
//            vc.fromSideMenu = "SideMenu"
//            vc.modalTransitionStyle = .crossDissolve
//            vc.modalPresentationStyle = .overFullScreen
//            self.present(vc, animated: true, completion: nil)
//        } else if indexPath.row == 2 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanOrUpload_VC") as! ScanOrUpload_VC
//            vc.itsFrom = "UploadCode"
//            vc.fromSideMenu = "SideMenu"
//            vc.modalTransitionStyle = .crossDissolve
//            vc.modalPresentationStyle = .overFullScreen
//            self.present(vc, animated: true, completion: nil)
//        } else if indexPath.row == 3 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CodeStatusListVC") as! CodeStatusListVC
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.row == 4 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DownloadEWarrantyListViewController") as! DownloadEWarrantyListViewController
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.row == 5 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DreamGiftListingViewController") as! DreamGiftListingViewController
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else if indexPath.row == 6 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionCatalogueVC") as! RedemptionCatalogueVC
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.row == 7 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionPlanner_VC") as! RedemptionPlanner_VC
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        }else if indexPath.row == 8 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyEarningsViewController") as! MyEarningsViewController
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.row == 9 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyRedemptionsListViewController") as! MyRedemptionsListViewController
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        }  else if indexPath.row == 10 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OffersListViewController") as! OffersListViewController
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.row == 11 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyBenefitsViewController") as! MyBenefitsViewController
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.row == 12 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UniqueFeaturesViewController") as! UniqueFeaturesViewController
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.row == 13 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CustomerQueryListingViewController") as! CustomerQueryListingViewController
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else if indexPath.row == 14 {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HelplineViewController") as! HelplineViewController
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TermsAndConditionsVC") as! TermsAndConditionsVC
//            vc.fromSideMenu = "SideMenu"
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
}
