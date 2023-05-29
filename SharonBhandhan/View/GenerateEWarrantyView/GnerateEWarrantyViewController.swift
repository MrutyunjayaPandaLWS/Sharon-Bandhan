//
//  GnerateEWarrantyViewController.swift
//  Sharon Secure
//
//  Created by admin on 18/07/22.
//

import UIKit
import Toast_Swift
import Firebase

class GnerateEWarrantyViewController: BaseViewController, GenerateEwarrantyDelegate,UITableViewDelegate, UITableViewDataSource, Popup4Delegate, submitQRDelegate, PopUpDelegate2{
    func didTapYesButton(_ vc: Popup3ViewController) {}
    
    func DidTap(_ vc: SubmitQRCodesViewController) {
        self.dismiss(animated: true)
        self.EWarrantyViewModel.soapMessage(codeDetails: CodesArray, ActorId: userID, Address: vc.selectedaddress ?? "", AreaId: self.EWarrantyViewModel.myprofiledetails.locationID ?? "-1", CityId: self.selectedCityID, CustomerName: vc.selectedcustomerName ?? "", EmailId: vc.selectedemailid ?? "", MobileNum: vc.selectedmobilenumber ?? "", StateId: self.selectedStateID, productId: self.tempStoreCodesArray[self.indexpathrow].ProductId ?? "", count: self.tempStoreCodesArray[self.indexpathrow].codeCount ?? 0)
        self.EWarrantyViewModel.EwarrantSubmissionAPI(indexpath:self.indexpathrow)
    }
    
    func othersDidTap(_ vc: Popup4ViewController) {
        self.dismiss(animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubmitQRCodesViewController") as! SubmitQRCodesViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = self
            self.present(vc, animated: true, completion: nil)
    }
    
    func selfDidTap(_ vc: Popup4ViewController) {
        self.EWarrantyViewModel.soapMessage(codeDetails: CodesArray, ActorId: userID, Address: self.EWarrantyViewModel.myprofiledetails.Address ?? "", AreaId: self.EWarrantyViewModel.myprofiledetails.locationID ?? "-1", CityId: self.selectedCityID, CustomerName: self.EWarrantyViewModel.myprofiledetails.firstname ?? "", EmailId: self.EWarrantyViewModel.myprofiledetails.EmailId ?? "", MobileNum: self.EWarrantyViewModel.myprofiledetails.MobileNo ?? "", StateId: self.selectedStateID, productId: self.tempStoreCodesArray[self.indexpathrow].ProductId ?? "", count: self.tempStoreCodesArray[self.indexpathrow].codeCount ?? 0)
        self.EWarrantyViewModel.EwarrantSubmissionAPI(indexpath:self.indexpathrow)
    }
    

    @IBOutlet weak var generateTableView: UITableView!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var backBTNview: UIView!
    
    var tempStoreCodesArray = [GenuineCodeSaveModels]()
    var CodesArray = [GenuineCodeSaveModels]()
    var EWarrantyViewModel = GenerateEwarrantyListingViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? "-1"
    var selectedStateName = ""
    var selectedStateID = "-1"
    
    var selectedCityName = ""
    var selectedCityID = "-1"
    var indexpathrow = -1
    
    var selectedsMemberTypeName = ""
    var selectedMemberTypeID = "-1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTableView.separatorStyle = .none
        generateTableView.register(UINib(nibName: "GenerateEWarrantyTableViewCell", bundle: nil), forCellReuseIdentifier: "GenerateEWarrantyTableViewCell")
        NotificationCenter.default.addObserver(self, selector: #selector(alertPopUpMessage), name: Notification.Name("alertPopUpWarranty"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ewarrantySuccess), name: Notification.Name("generateEWarrantySuccess"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ewarrantyFailed), name: Notification.Name("generateEWarrantyFailed"), object: nil)
        self.EWarrantyViewModel.vc = self
        self.EWarrantyViewModel.ApicallingMethod(userID: userID)
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
            vc.discriptionInfo = "Are you sure want to exit without generating E-Warranty?"
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
    func GenerateBtn(_ cell: GenerateEWarrantyTableViewCell) {
        guard let tappedIndexPath = generateTableView.indexPath(for: cell) else { return }
        
        if UserDefaults.standard.string(forKey: "CUSTTYPE") == "1" || UserDefaults.standard.string(forKey: "CUSTTYPE") == "5"{
            print(tempStoreCodesArray.count)
            self.EWarrantyViewModel.soapMessage(codeDetails: CodesArray, ActorId: userID, Address: self.EWarrantyViewModel.myprofiledetails.Address ?? "", AreaId: self.EWarrantyViewModel.myprofiledetails.locationID ?? "-1", CityId: self.selectedCityID, CustomerName: self.EWarrantyViewModel.myprofiledetails.firstname ?? "", EmailId: self.EWarrantyViewModel.myprofiledetails.EmailId ?? "", MobileNum: self.EWarrantyViewModel.myprofiledetails.MobileNo ?? "", StateId: self.selectedStateID, productId: self.tempStoreCodesArray[tappedIndexPath.row].ProductId ?? "", count: self.tempStoreCodesArray[tappedIndexPath.row].codeCount ?? 0)
            self.EWarrantyViewModel.EwarrantSubmissionAPI(indexpath:tappedIndexPath.row)
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
        cell?.noofCodes.text = "\(tempStoreCodesArray[indexPath.row].codeCount ?? 0)"
        cell?.productDescriptionlabel.text = "Product Name : \(tempStoreCodesArray[indexPath.row].ProductName ?? "")"
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
