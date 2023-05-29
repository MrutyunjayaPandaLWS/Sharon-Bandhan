//
//  CustomerQueryListingViewController.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 25/04/2022.
//

import UIKit
import CoreData
import UserNotifications
import Firebase

class CustomerQueryListingViewController: BaseViewController,UNUserNotificationCenterDelegate{
  
    
  
    @IBOutlet weak var lodgequery: UILabel!
    @IBOutlet weak var querylistingTableview: UITableView!
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var nodatafoundLbl: UILabel!
    
    var CustomerTicketIDchatvc = "-100"
    var CustomerTicketID = ""
    var catalogueList = ""
    var codeDataToShow = [String]()
    var storyboard1 = UIStoryboard(name: "Main", bundle: nil)
    var topicselectedID:String = ""
    var isfromStatus = 0
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let VM = LodgeListViewModel()
    var helpTopicListingArray = [ObjHelpTopicList]()
    var fromSideMenu = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.nodatafoundLbl.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {

//            topview.backgroundColor = UIColor.red
            topview.isHidden = false
            self.querylistingTableview.isHidden = false
            queryListApi()
            querylistingTableview.delegate = self
            querylistingTableview.dataSource = self
            querylistingTableview.separatorStyle = .none
            languagelocalization()
//        
//            guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//            tracker.set(kGAIScreenName, value: "Customer Query")
//
//            guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//            tracker.send(builder.build() as [NSObject : AnyObject])

    }
    
    
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?){
        print(isfromStatus, "From Status")
        if isfromStatus != 1{
            let touch = touchscreen.first
            if touch?.view != self.presentingViewController{
//                self.topview.backgroundColor = UIColor.red
                self.querylistingTableview.isHidden = false
                self.topview.isHidden = false
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.lodgequery.text = "Lodge Query"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.lodgequery.text = "लॉज क्वेरी"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.lodgequery.text = "লজ প্রশ্ন"
        }else{
            self.lodgequery.text = "లాడ్జ్ ప్రశ్న"
        }
    }
    
        
    @IBAction func customerNewticketbutton(_ sender: Any) {
//         self.topview.backgroundColor = UIColor.red
        let centerviewcontroller = self.storyboard1.instantiateViewController(withIdentifier: "CreateNewQueryViewController") as! CreateNewQueryViewController
        centerviewcontroller.isFrom = 3
         self.navigationController?.pushViewController(centerviewcontroller, animated: true)

    }
    
    @IBAction func backbutton(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func closebutton(_ sender: Any) {
    }
      
    func queryListApi(){
        let parameters = [
            "ActionType": "1",
            "ActorId": "\(userID)",
            "HelpTopicID": "-1",
            "TicketStatusId": "-1"
        ] as [String: Any]
        print(parameters)
        self.VM.queryListingApi(parameters: parameters) { response in
            self.VM.queryListingArray = response?.objCustomerAllQueryJsonList ?? []
            DispatchQueue.main.async {
                if self.VM.queryListingArray.count != 0 {
                    self.nodatafoundLbl.isHidden = true
                    self.querylistingTableview.isHidden = false
                    self.querylistingTableview.reloadData()
                    NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification1033(notification:)), name: Notification.Name("NotificationIdentifier103-3"), object: nil)

                }else{
                    self.querylistingTableview.isHidden = true
                    self.nodatafoundLbl.isHidden = false
                }
                    //self.nodatafoundLbl.isHidden = false
                self.stopLoading()
            }
            
        }
        
    }
    
 
    
}
extension CustomerQueryListingViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if VM.queryListingArray.count == 0{
            nodatafoundLbl.isHidden = false
        }else{
            nodatafoundLbl.isHidden = true
        }
            return VM.queryListingArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "querylistingTableViewCell", for: indexPath) as! querylistingTableViewCell
            cell.querystatus.text = VM.queryListingArray[indexPath.section].ticketStatus ?? ""
            cell.selectionStyle = .none
            cell.querycode.text = VM.queryListingArray[indexPath.section].customerTicketRefNo ?? ""
            cell.querydetails.text = "  \(VM.queryListingArray[indexPath.section].helpTopic ?? "")"
            let querydateAndTime = VM.queryListingArray[indexPath.section].jCreatedDate ?? ""
            let querydateAndTimeArray = querydateAndTime.components(separatedBy: " ")
            cell.querydate.text = querydateAndTimeArray[0]
            cell.querytime.text = querydateAndTimeArray[1]
            if CustomerTicketID == CustomerTicketIDchatvc{
                let centerviewcontroller = self.storyboard1.instantiateViewController(withIdentifier: "ChatListViewController") as! ChatListViewController
                print(VM.queryListingArray[indexPath.section].customerTicketID!)
                centerviewcontroller.CustomerTicketIDchatvc = "\(VM.queryListingArray[indexPath.section].customerTicketID ?? 0)"
                centerviewcontroller.helptopicid = "\(VM.queryListingArray[indexPath.section].helpTopicID ?? 0)"
                centerviewcontroller.querysummary = VM.queryListingArray[indexPath.section].querySummary ?? ""
                centerviewcontroller.helptopicdetails = VM.queryListingArray[indexPath.section].helpTopic ?? ""
                centerviewcontroller.querydetails = "  \(VM.queryListingArray[indexPath.section].queryDetails ?? "")"
                self.navigationController?.pushViewController(centerviewcontroller, animated: true)
            }
            return cell
       
       
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 170
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let centerviewcontroller = self.storyboard1.instantiateViewController(withIdentifier: "ChatListViewController") as! ChatListViewController
            print(VM.queryListingArray[indexPath.section].customerTicketID ?? 0)
            centerviewcontroller.CustomerTicketIDchatvc = "\(VM.queryListingArray[indexPath.section].customerTicketID ?? 0)"
            centerviewcontroller.helptopicid = "\(VM.queryListingArray[indexPath.section].helpTopicID ?? 0)"
            centerviewcontroller.querysummary = VM.queryListingArray[indexPath.section].querySummary ?? ""
            centerviewcontroller.helptopicdetails = VM.queryListingArray[indexPath.section].helpTopic ?? ""
            centerviewcontroller.querydetails = VM.queryListingArray[indexPath.section].queryDetails ?? ""
            self.navigationController?.pushViewController(centerviewcontroller, animated: true)
    }
    @objc func methodOfReceivedNotification1033(notification: Notification) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatListViewController") as? ChatListViewController
        vc?.CustomerTicketIDchatvc = UserDefaults.standard.string(forKey: "pushSpecificID") ?? "-1"
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
