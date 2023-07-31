//
//  MyEarningsViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Lottie
import Firebase
import LanguageManager_iOS

class MyEarningsViewController: BaseViewController, FilterDelegate {
    
    
    
    @IBOutlet weak var animationLottieView: LottieAnimationView!
    @IBOutlet weak var EarningstableView: UITableView!
    
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var myEarning: UILabel!
    var fromSideMenu = ""
    var startDate = ""
    var endDate = ""
    var VM = MyEarningsViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
       // playAnimation()
        self.VM.VC = self
        self.EarningstableView.register(UINib(nibName: "MyEarningsTableViewCell", bundle: nil), forCellReuseIdentifier: "MyEarningsTableViewCell")
        noDataFound.isHidden = true
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            myEarningListApi()
        }
        self.EarningstableView.delegate = self
        self.EarningstableView.dataSource = self
        
        languagelocalization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "My Earning")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    
    func languagelocalization(){
        self.myEarning.text = "meMyEarning".localiz()
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            self.myEarning.text = "meMyEarning".localiz()
//
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            self.myEarning.text = "मेरी कमाई"
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            self.myEarning.text = "আমার উপার্জন"
//        }else{
//            self.myEarning.text = "నా సంపాదన"
//        }
    }
    
//    func playAnimation(){
//        animationView = .init(name: "lf30_editor_jh47f7lt")
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
    
    
    
    
    func myEarningListApi(){
        let parameters = [
            "ActorId": userID,
            "IsActive": "true",
            "MerchantId": "1"
            
        ] as [String: Any]
        print(parameters)
        self.VM.myEarningListAPi(parameters: parameters) { response in
            self.VM.myEarningListArray = response?.lstRewardTransJsonDetails ?? []
            print(self.VM.myEarningListArray.count)
            if self.VM.myEarningListArray.count != 0 {
                DispatchQueue.main.async {
                    self.EarningstableView.isHidden = false
                    self.EarningstableView.reloadData()
                }
            }else{
                self.EarningstableView.isHidden = true
            }
        }
    }
    @IBAction func filterButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FilterPopUpViewController") as! FilterPopUpViewController
        vc.delegate = self
        vc.selectedFromDate = self.startDate
        vc.selectedToDate = self.endDate
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func selectedDateRange(_ vc: FilterPopUpViewController) {
        self.startDate = vc.selectedFromDate
        self.endDate = vc.selectedToDate
        let parameters = [
            "ActorId": "\(userID)",
            "IsActive": "true",
            "JFromDate": "\(vc.selectedFromDate)",
            "JToDate": "\(vc.selectedToDate)",
            "MerchantId": "1"
        ] as [String: Any]
        print(parameters)
        self.VM.myEarningListAPi(parameters: parameters) { response in
            self.VM.myEarningListArray = response?.lstRewardTransJsonDetails ?? []
            print(self.VM.myEarningListArray.count)
            if self.VM.myEarningListArray.count != 0 {
                DispatchQueue.main.async {
                    self.EarningstableView.isHidden = false
                    self.noDataFound.isHidden = true
                    self.EarningstableView.reloadData()
                }
            }else{
                self.EarningstableView.isHidden = true
                self.noDataFound.isHidden = false
            }
        }
    }
    
    @IBAction func backBTN(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
                  NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
                  self.navigationController?.popViewController(animated: true)
              }else{
                  self.navigationController?.popViewController(animated: true)
              }
    }
    
}
extension MyEarningsViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.VM.myEarningListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyEarningsTableViewCell") as? MyEarningsTableViewCell
        let receivedDate = (self.VM.myEarningListArray[indexPath.row].jTranDate ?? "").split(separator: " ")
        let dateFormatted = convertDateFormater(String(receivedDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        cell?.myEarnedDate.text = "\(dateFormatted)"
        if self.VM.myEarningListArray[indexPath.row].invoiceNo ?? "" == "--"{
            cell?.giftId.text = "Reward Adjusted".localiz()
            
//            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                cell?.giftId.text = "Reward Adjusted"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                cell?.giftId.text = "इनाम समायोजित"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                cell?.giftId.text = "পুরষ্কার সামঞ্জস্য করা হয়েছে"
//            }else{
//                cell?.giftId.text = "రివార్డ్ సర్దుబాటు చేయబడింది"
//            }
            
        }else {
            cell?.giftId.text = self.VM.myEarningListArray[indexPath.row].invoiceNo ?? ""
        }
        
        cell?.pointsLbl.text = "\(self.VM.myEarningListArray[indexPath.row].rewardPoints ?? 0)"
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
