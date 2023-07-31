//
//  GnerateEWarrantyViewController.swift
//  Sharon Secure
//
//  Created by admin on 18/07/22.
//

import UIKit
import Toast_Swift
import Firebase
import LanguageManager_iOS

class GnerateEWarrantyViewController: BaseViewController, GenerateEwarrantyDelegate,UITableViewDelegate, UITableViewDataSource, Popup4Delegate, submitQRDelegate, PopUpDelegate2{
    func didTapYesButton(_ vc: Popup3ViewController) {}
    
    func DidTap(_ vc: SubmitQRCodesViewController) {
        self.dismiss(animated: true)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            eWarrentySubmission(codeDetails: CodesArray, ActorId: userID , Address: vc.selectedaddress , AreaId: "\(self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].locationId ?? -1)", CityId: self.selectedCityID, CustomerName: vc.selectedcustomerName , EmailId: vc.selectedemailid , MobileNum: vc.selectedmobilenumber , StateId: self.selectedStateID, productId: self.tempStoreCodesArray[self.indexpathrow].productId ?? 0, count: self.tempStoreCodesArray[self.indexpathrow].codeStatusWiseCount ?? 0)
        }
    }
    
    func othersDidTap(_ vc: Popup4ViewController) {
        self.dismiss(animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubmitQRCodesViewController") as? SubmitQRCodesViewController
        vc?.modalPresentationStyle = .overFullScreen
        vc?.modalTransitionStyle = .crossDissolve
        vc?.delegate = self
            self.present(vc!, animated: true, completion: nil)
    }
    
    func selfDidTap(_ vc: Popup4ViewController) {
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            eWarrentySubmission(codeDetails: CodesArray, ActorId: userID , Address: self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].address1 ?? "", AreaId: "\(self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].locationId ?? -1)", CityId: self.selectedCityID, CustomerName: self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].firstName ?? "", EmailId: self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].email ?? "", MobileNum: self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].mobile ?? "", StateId: self.selectedStateID, productId: self.tempStoreCodesArray[self.indexpathrow].productId ?? 0, count: self.tempStoreCodesArray[self.indexpathrow].codeStatusWiseCount ?? 0)
        }
    }
    

    @IBOutlet weak var noDataFoundLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var generateTableView: UITableView!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var backBTNview: UIView!
    
    var tempStoreCodesArray = [QrUsegereport1]()
    var CodesArray = [QrUsegereport1]()
    var EWarrantyViewModel = GenerateEwarrantyListingViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var selectedStateName = ""
    var selectedStateID = "-1"
    
    var selectedCityName = ""
    var selectedCityID = "-1"
    var indexpathrow = -1
    
    var selectedsMemberTypeName = ""
    var selectedMemberTypeID = "-1"
    var parameter2 = [[String : Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTableView.separatorStyle = .none
        generateTableView.register(UINib(nibName: "GenerateEWarrantyTableViewCell", bundle: nil), forCellReuseIdentifier: "GenerateEWarrantyTableViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(alertPopUpMessage), name: Notification.Name("alertPopUpWarranty"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ewarrantySuccess), name: Notification.Name("generateEWarrantySuccess"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ewarrantyFailed), name: Notification.Name("generateEWarrantyFailed"), object: nil)
        self.EWarrantyViewModel.vc = self
//        self.EWarrantyViewModel.ApicallingMethod(userID: userID as! Int)
        if MyCommonFunctionalUtilities.isInternetCallTheApi() == false{
            self.view.makeToast("No Internet".localiz(), duration: 2.0, position: .bottom)
        }else{
            profileData()
        }
        generateTableView.delegate = self
        generateTableView.dataSource = self
        self.generateTableView.reloadData()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Generate E-Warranty")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
        localization()
    }
    
    private func localization(){
        
        headerLbl.text = "E-Warrenty".localiz()
        noDataFoundLbl.text = "NoDataFoundKEY".localiz()
        
    }
    
    
    @objc func alertPopUpMessage(notification: Notification){
         self.navigationController?.popToRootViewController(animated: true)
     }
    @objc func ewarrantySuccess(notification: Notification){
        if self.tempStoreCodesArray.count == 0{
        self.navigationController?.popToRootViewController(animated: true)
        }
     }
    @objc func ewarrantyFailed(notification: Notification){
        self.navigationController?.popToRootViewController(animated: true)
     }
    override func viewDidLayoutSubviews() {
        self.backBTNview.layer.cornerRadius = self.backBTNview.frame.width / 2
    }


    @IBAction func backButton(_ sender: Any) {
        DispatchQueue.main.async{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Popup3ViewController") as! Popup3ViewController
            vc.delegate = self
            vc.titleInfo = ""
            vc.itsFrom = "GenerateWarranty"
            vc.discriptionInfo = "Are you sure want to exit without generating E-Warranty?".localiz()
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
    func GenerateBtn(_ cell: GenerateEWarrantyTableViewCell) {
        guard let tappedIndexPath = generateTableView.indexPath(for: cell) else { return }
        
        if UserDefaults.standard.string(forKey: "CUSTTYPE") == "1" || UserDefaults.standard.string(forKey: "CUSTTYPE") == "5"{
            print(tempStoreCodesArray.count)
            eWarrentySubmission(codeDetails: CodesArray, ActorId: userID, Address: self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].address1 ?? "", AreaId: "\(self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].locationId ?? -1)", CityId: self.selectedCityID, CustomerName: self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].firstName ?? "", EmailId: self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].email ?? "", MobileNum: self.EWarrantyViewModel.myprofiledetails?.getCustomerDetailsMobileAppResult?.lstCustomerJson?[0].mobile ?? "", StateId: self.selectedStateID, productId: self.tempStoreCodesArray[tappedIndexPath.row].productId ?? 0, count: self.tempStoreCodesArray[tappedIndexPath.row].codeStatusWiseCount ?? 0)
            
//            self.EWarrantyViewModel.EwarrantSubmissionAPI(indexpath:tappedIndexPath.row)
        }else{
            self.indexpathrow = tappedIndexPath.row
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Popup4ViewController") as! Popup4ViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.delegate = self
                self.present(vc, animated: true, completion: nil)
        }
    }
    
}
extension GnerateEWarrantyViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempStoreCodesArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenerateEWarrantyTableViewCell", for: indexPath) as? GenerateEWarrantyTableViewCell
        cell?.noofCodes.text = "\(tempStoreCodesArray[indexPath.row].codeStatusWiseCount ?? 0)"
        cell?.productDescriptionlabel.text = "Product Name : \(tempStoreCodesArray[indexPath.row].productName ?? "")"
        cell?.generatedfate.text = "\(Date.getCurrentDate())"

        cell?.delegate = self
        return cell!
    }
}
//extension Date {
//
// static func getCurrentDate() -> String {
//
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//
//        return dateFormatter.string(from: Date())
//
//    }
//}



extension GnerateEWarrantyViewController{
    func eWarrentySubmission(codeDetails:[QrUsegereport1], ActorId:String,Address:String,AreaId:String,CityId:String,CustomerName:String,EmailId:String,MobileNum:String,StateId:String,productId:Int,count: Int){
        for data1 in codeDetails{
            if data1.productId == productId{
                let singleImageDict = [
                    "BrandId" : data1.brandId ?? "",
                    "EWarrantyQty": data1.codeStatusWiseCount ?? 0,
                    "ProductId": data1.productId ?? 0,
                    "ScannedCode": data1.scratchCode ?? ""
                ] as [String : Any]
                self.parameter2.append(singleImageDict as [String : Any])
            }
        }
        
        let parameter : [String : Any] = [
                "ActionType": 1,
                "ActorId": ActorId,
                "Address": "\(Address)",
                "CityId": CityId,
                "CustomerName": "\(CustomerName)",
                "emailed": "\(EmailId)",
                "MobileNum": "\(MobileNum)",
                "StateId": "\(StateId)",
                "lstEWarranty": self.parameter2
            

        ]
        print(parameter,"e-warrwnty submission")
        self.EWarrantyViewModel.EwarrantSubmissionAPI(indexpath:self.indexpathrow,parameter: parameter)
    }
    
    func profileData(){
        let parameters = [
            "ActionType": "6",
            "CustomerId": "\(userID)"
        ] as [String: Any]
        
        self.EWarrantyViewModel.myProifleDetails(parameters: parameters)
    }
    
}

