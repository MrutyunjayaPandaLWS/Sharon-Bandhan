import UIKit
import Lottie
import SDWebImage
import Alamofire
import Firebase
import Toast_Swift
class DreamGiftListingViewController: BaseViewController, AddOrRemoveGiftDelegate, popUpDelegate{

    @IBOutlet weak var animationLottieView: LottieAnimationView!
    @IBOutlet weak var dreamGifttableView: UITableView!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var header: UILabel!
    
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var selectedDreamGiftId = ""
    var selectedGiftStatusID = 0
    var dreamGiftRedemptionId = 0
    var fromSideMenu = ""
    let verifiedStatus = UserDefaults.standard.integer(forKey: "VerifiedStatus")
    var checkAccountStatus = UserDefaults.standard.string(forKey: "SemiActiveAccount") ?? ""
    var VM = DreamGiftListingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.dreamGifttableView.register(UINib(nibName: "DreamGiftTableViewCell", bundle: nil), forCellReuseIdentifier: "DreamGiftTableViewCell")
        self.dreamGifttableView.delegate = self
        self.dreamGifttableView.dataSource = self
        self.dreamGifttableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(afterRemovedProducts), name: Notification.Name.dreamGiftRemoved, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(giftAddedIntoCart), name: Notification.Name.giftAddedIntoCart, object: nil)
        
        
        
        var vc = self.storyboard?.instantiateViewController(withIdentifier: "TaxRelatedPopupViewController") as! TaxRelatedPopupViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        languagelocalization()
        dreamGiftListApi()
        

    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.header.text = "Dream Gift"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.header.text = "सपना उपहार"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.header.text = "স্বপ্নের উপহার"
        }else{
            self.header.text = "డ్రీం గిఫ్ట్"
        }
    }
    
    @objc func afterRemovedProducts(){
        dreamGiftListApi ()
        self.dreamGifttableView.reloadData()
    }
    @objc func giftAddedIntoCart(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShippingAddress_VC") as! ShippingAddress_VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    //Delegate:-
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    func redeemGift(_ cell: DreamGiftTableViewCell) {
        
        guard let tappedIndexPath = dreamGifttableView.indexPath(for: cell) else {return}
        if cell.redeemButton.tag == tappedIndexPath.row{
            if self.verifiedStatus == 6 || self.verifiedStatus == 4{
                if self.checkAccountStatus == "1"{
                    NotificationCenter.default.post(name: .verificationStatus, object: nil)
                }else{
                    NotificationCenter.default.post(name: .verificationStatus, object: nil)
                }
                
            }else if self.verifiedStatus == 1{
                print(UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable"))
                if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == -3{
                    self.view.makeToast("Your PAN Details are pending,Please contact your administrator!", duration: 2.0, position: .bottom)
                }else if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == -4{
                    self.view.makeToast("Your PAN Details are rejected,Please contact your administrator!", duration: 2.0, position: .bottom)
                }else if UserDefaults.standard.integer(forKey: "DreamGiftIsRedeemable") == 1{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ShippingAddress_VC") as! ShippingAddress_VC
                    vc.redemptionTypeId = 3
                    vc.totalPoint = self.VM.myDreamGiftListArray[tappedIndexPath.row].pointsRequired ?? 0
                    
                    vc.dreamGiftID = self.VM.myDreamGiftListArray[tappedIndexPath.row].dreamGiftId ?? 0
                    vc.giftName = self.VM.myDreamGiftListArray[tappedIndexPath.row].dreamGiftName ?? ""
                    vc.contractorName = self.VM.myDreamGiftListArray[tappedIndexPath.row].contractorName ?? ""
                    vc.giftStatusId = self.VM.myDreamGiftListArray[tappedIndexPath.row].giftStatusId ?? 0
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.view.makeToast("Insufficient point balance to redeem!", duration: 2.0, position: .bottom)
                }
              
            }
           
        }
        
    }
    
    func removeGift(_ cell: DreamGiftTableViewCell) {
        guard let tappedIndexPath = dreamGifttableView.indexPath(for: cell) else {return}
        if cell.removeGiftBTN.tag == tappedIndexPath.row{
            self.selectedDreamGiftId = "\(self.VM.myDreamGiftListArray[tappedIndexPath.row].dreamGiftId ?? 0)"
            self.selectedGiftStatusID = self.VM.myDreamGiftListArray[tappedIndexPath.row].giftStatusId ?? 0
            self.removeDreamGift()
            self.dreamGifttableView.reloadData()
        }
    }
    
    //APi:-
    
    func dreamGiftListApi(){
        self.startLoading()
        self.VM.myDreamGiftListArray.removeAll()
        let parameters = [
            "ActionType": "1",
               "ActorId": "\(userID)",
               "LoyaltyId": "\(loyaltyId)",
                "Status": "2"
        ] as [String: Any]
        print(parameters)
        self.VM.myDreamGiftLists(parameters: parameters) { response in
            self.VM.myDreamGiftListArray = response?.lstDreamGift ?? []
            
            if self.VM.myDreamGiftListArray.count != 0{
                UserDefaults.standard.set(self.VM.myDreamGiftListArray[0].is_Redeemable ?? 0, forKey: "DreamGiftIsRedeemable")
                UserDefaults.standard.synchronize()
                self.dreamGifttableView.isHidden = false
                self.noDataFound.isHidden = true
                self.dreamGifttableView.reloadData()
            }else{
                self.dreamGifttableView.isHidden = true
                self.noDataFound.isHidden = false
                self.dreamGifttableView.reloadData()

            }
            self.stopLoading()
        }
    }
    
    func removeDreamGift(){
        let parameters = [
                "ActionType": 4,
                "ActorId": "\(userID)",
                "DreamGiftId": "\(selectedDreamGiftId)",
                "GiftStatusId": 4
        ] as [String: Any]
        print(parameters)
        self.VM.removeDreamGift(parameters: parameters) { response in
            let result = response?.returnValue ?? 0
            print(result)
            if result == 1 {
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "DreamGift"
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Dream Gift has been removed successfully"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "ड्रीम गिफ्ट सफलतापूर्वक हटा दिया गया है"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "স্বপ্ন উপহার সফলভাবে সরানো হয়েছে"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "డ్రీమ్ గిఫ్ట్ విజయవంతంగా తీసివేయబడింది"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
                
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Dream Gift has been removed failed"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "ड्रीम गिफ्ट को हटा दिया गया है विफल"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "ড্রিম গিফট ব্যর্থ হয়েছে"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "డ్రీమ్ గిఫ్ట్ తీసివేయబడింది విఫలమైంది"
                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
    
 
}
extension DreamGiftListingViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myDreamGiftListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DreamGiftTableViewCell") as? DreamGiftTableViewCell
        cell?.delegate = self
        cell?.selectionStyle = .none
        
        cell?.giftName.text = self.VM.myDreamGiftListArray[indexPath.row].dreamGiftName ?? ""
        cell?.tdsvalue.text = "\(self.VM.myDreamGiftListArray[indexPath.row].tdsPoints ?? 0)"

        cell?.dreamGiftTitle.text = self.VM.myDreamGiftListArray[indexPath.row].giftType ?? ""
        let createdDate = (self.VM.myDreamGiftListArray[indexPath.row].jCreatedDate ?? "").split(separator: " ")
        let convertedFormat = convertDateFormater(String(createdDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        cell?.giftCreatedDate.text = convertedFormat
        
        let desiredDate = (self.VM.myDreamGiftListArray[indexPath.row].jDesiredDate ?? "").split(separator: " ")
//        let desiredDateFormat = convertDateFormater(String(desiredDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        cell?.desiredDate.text = "\(desiredDate[0])"//desiredDateFormat
        cell?.pointsRequired.text = "\(self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0)"
        let balance = Double(self.VM.myDreamGiftListArray[indexPath.row].pointsBalance ?? 0)
        let pointRequired = Double(self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0)
        let tdsvalue = self.VM.myDreamGiftListArray[indexPath.row].tdsPoints ?? 0
        print(Int(pointRequired + Double(tdsvalue)),"data")
        print(balance,"Balance")
//        if ((Int(pointRequired)) + Int(tdsvalue)) <= Int(balance){
//            cell?.redeemButton.isEnabled = true
//            cell?.redeemButton.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
//        }else{
//            cell?.redeemButton.isEnabled = false
//            cell?.redeemButton.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
//
//        }
        
        
        
        
        if self.VM.myDreamGiftListArray[indexPath.row].is_Redeemable ?? -2 != 1{
            cell?.redeemButton.isEnabled = false
//            cell?.redeemButton.backgroundColor = UIColor(red: 209/255, green: 209/255, blue: 214/255, alpha: 1.0)
            cell?.redeemButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
        }else{
            cell?.redeemButton.isEnabled = true
//            cell?.redeemButton.backgroundColor = UIColor(red: 189/255, green: 0/255, blue: 0/255, alpha: 1.0)
            cell?.redeemButton.backgroundColor = #colorLiteral(red: 0, green: 0.5832939148, blue: 0.2739756703, alpha: 1)
            
            }
        
        
        cell?.redeemButton.tag = indexPath.row
        cell?.removeGiftBTN.tag = indexPath.row
        print(pointRequired,"pointsReq")
        let percentage = CGFloat(balance/pointRequired)
        if pointRequired < balance{
            cell?.percentageValue.text = "100%"
            cell?.progressView.progress = Float(percentage)
            cell?.percentageLeadingSpace.constant = ((cell?.progressView.frame.width ?? 0) * CGFloat(100/100) + 40)
        }else{
            let final = CGFloat(percentage) * 100
            cell?.percentageValue.text = "\(Int(final))%"
            cell?.progressView.progress = Float(percentage)
            cell?.percentageLeadingSpace.constant = ((cell?.progressView.frame.width ?? 0) * CGFloat(percentage/100) + 50)
        }
       
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DreamGiftDetailsViewController") as! DreamGiftDetailsViewController
        vc.giftName = self.VM.myDreamGiftListArray[indexPath.row].dreamGiftName ?? ""
        vc.tdsvalue = Double(self.VM.myDreamGiftListArray[indexPath.row].tdsPoints ?? 0)
        vc.giftType = self.VM.myDreamGiftListArray[indexPath.row].giftType ?? ""
        //vc.giftImage = self.VM.myDreamGiftListArray[indexPath.row].
        let createdDate = (self.VM.myDreamGiftListArray[indexPath.row].jCreatedDate ?? "").split(separator: " ")
        let convertedFormat = convertDateFormater(String(createdDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        vc.addedDate = convertedFormat
        
        let desiredDate = (self.VM.myDreamGiftListArray[indexPath.row].jDesiredDate ?? "").split(separator: " ")
        //let desiredDateFormat = convertDateFormater(String(desiredDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        vc.expiredDate = String(desiredDate[0])
        vc.pointsRequires = "\(self.VM.myDreamGiftListArray[indexPath.row].pointsRequired ?? 0)"
        vc.avgEarningPoints = "\(self.VM.myDreamGiftListArray[indexPath.row].avgEarningPoints ?? 0)"
        vc.pointsBalance = self.VM.myDreamGiftListArray[indexPath.row].pointsBalance ?? 0
        vc.selectedDreamGiftId = "\(self.VM.myDreamGiftListArray[indexPath.row].dreamGiftId ?? 0)"
        vc.selectedGiftStatusID = self.VM.myDreamGiftListArray[indexPath.row].giftStatusId ?? 0
        vc.contractorName = self.VM.myDreamGiftListArray[indexPath.row].contractorName ?? ""
        vc.isRedeemable = self.VM.myDreamGiftListArray[indexPath.row].is_Redeemable ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
