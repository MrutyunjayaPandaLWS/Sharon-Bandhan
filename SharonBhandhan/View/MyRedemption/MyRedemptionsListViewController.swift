//
//  MyRedemptionsListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Lottie
import SDWebImage
import Firebase

class MyRedemptionsListViewController: BaseViewController, popUpDelegate, FilterDelegate{
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    @IBOutlet weak var myRedemptionstableView: UITableView!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var header: UILabel!
    
    
    var VM = MyRedemptionsListViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
    var startDate = ""
    var fromSideMenu = ""
    var endDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // playAnimation()
        self.VM.VC = self
        self.myRedemptionstableView.register(UINib(nibName: "MyRedemptionsTableViewCell", bundle: nil), forCellReuseIdentifier: "MyRedemptionsTableViewCell")
        self.myRedemptionstableView.delegate = self
        self.myRedemptionstableView.dataSource = self
        self.myRedemptionstableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myRedemptionList()
        self.noDataFound.isHidden = true
        languagelocalization()
//        
//            guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//            tracker.set(kGAIScreenName, value: "My Redemption")
//
//            guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//            tracker.send(builder.build() as [NSObject : AnyObject])

    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.header.text = "My Redemptions"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.header.text = "मेरे मोचन"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.header.text = "আমার মুক্তি"
        }else{
            self.header.text = "నా విమోచనాలు"
        }
    }
    
  
    func myRedemptionList(){
        let parameters = [
            
                "ActionType": "52",
                "ActorId": "\(userID)",
                "ObjCatalogueDetails": [
                    "SelectedStatus": "-1"
                ]
            
        ] as [String: Any]
        print(parameters)
        self.VM.myRedemptionLists(parameters: parameters) { response in
            self.VM.myRedemptionList = response?.objCatalogueRedemReqList ?? []
            if self.VM.myRedemptionList.count != 0 {
                DispatchQueue.main.async {
                    self.myRedemptionstableView.isHidden = false
                    self.noDataFound.isHidden = true
                    self.myRedemptionstableView.reloadData()
                }
            }else{
                self.myRedemptionstableView.isHidden = true
                self.noDataFound.isHidden = false
            }
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
    
    @IBAction func filterButton(_ sender: Any) {
        //FilterPopUpViewController
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
        "ActionType": "52",
           "ActorId": "\(userID)",
           "ObjCatalogueDetails": [
            "JFromDate": "\(vc.selectedFromDate)",
            "JToDate": "\(vc.selectedToDate)",
               "SelectedStatus": "-1"
           ]
      ] as [String: Any]
    print(parameters)
        self.VM.myRedemptionLists(parameters: parameters) { response in
            self.VM.myRedemptionList = response?.objCatalogueRedemReqList ?? []
            if self.VM.myRedemptionList.count != 0 {
                DispatchQueue.main.async {
                    self.myRedemptionstableView.isHidden = false
                    self.noDataFound.isHidden = true
                    self.myRedemptionstableView.reloadData()
                }
            }else{
                self.myRedemptionstableView.isHidden = true
                self.noDataFound.isHidden = false
            }
        }
        
    }
    
}
extension MyRedemptionsListViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.myRedemptionList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyRedemptionsTableViewCell") as? MyRedemptionsTableViewCell
        cell?.selectionStyle = .none
        
        if self.VM.myRedemptionList[indexPath.row].catalogueType ?? "-" == ""{
            cell?.productTitle.text = "Catalogue"
        }else{
            cell?.productTitle.text = self.VM.myRedemptionList[indexPath.row].catalogueType ?? "-"
        }
        

        let redemptionDate = (self.VM.myRedemptionList[indexPath.row].jRedemptionDate ?? "-").split(separator: " ")
        let dateFormatted = convertDateFormater(String(redemptionDate[0]), fromDate: "MM/dd/yyyy", toDate: "dd/MM/yyyy")
        cell?.redemptionDate.text = "\(dateFormatted)"
        cell?.productName.text = self.VM.myRedemptionList[indexPath.row].productName ?? "-"
        cell?.tdsvalue.text = "\(Int(self.VM.myRedemptionList[indexPath.row].ApplicableTds ?? 0.0))"
        cell?.productPoints.text = "\(self.VM.myRedemptionList[indexPath.row].redeemedPoints ?? 0)"

        if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 0 || self.VM.myRedemptionList[indexPath.row].status ?? 0 == 1{
            cell?.productStatus.text = "Pending"
            cell?.productStatus.textColor = UIColor.black
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell?.productStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 2 {
            cell?.productStatus.text = "Processed"
            cell?.productStatus.textColor = UIColor.black
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell?.productStatus.borderColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 3 {
            cell?.productStatus.text = "Cancelled"
            cell?.productStatus.textColor = UIColor.black
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            cell?.productStatus.borderColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 4 {
            cell?.productStatus.text = "Delivered"
            cell?.productStatus.textColor = UIColor.black
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell?.productStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 7 {
            cell?.productStatus.text = "Returned"
            cell?.productStatus.textColor = UIColor.black
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell?.productStatus.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 8 {
            cell?.productStatus.text = "Redispatched"
            cell?.productStatus.textColor = UIColor.black
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            cell?.productStatus.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 9 {
            cell?.productStatus.text = "OnHold"
            cell?.productStatus.textColor = UIColor.black
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell?.productStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 10 {
            cell?.productStatus.text = "Dispatched"
            cell?.productStatus.textColor = UIColor.black
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell?.productStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 11 {
            cell?.productStatus.text = "Out for Delivery"
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell?.productStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell?.productStatus.textColor = UIColor.black
        }else if self.VM.myRedemptionList[indexPath.row].status ?? 0 == 12 {
            cell?.productStatus.text = "Address Verified"
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            cell?.productStatus.textColor = UIColor.black
            cell?.productStatus.borderColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }else{
            cell?.productStatus.text = "-"
            cell?.productStatus.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell?.productStatus.textColor = UIColor.black
            cell?.productStatus.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }

            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                cell?.productStatus.text = "Pending"
                cell?.productRefNo.text = "REF# \(self.VM.myRedemptionList[indexPath.row].redemptionRefno ?? "-")"
                cell?.productCateogory.text = "Category: \(self.VM.myRedemptionList[indexPath.row].categoryName ?? "-")"
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                cell?.productStatus.text = "लंबित"
                cell?.productRefNo.text = "संदर्भ# \(self.VM.myRedemptionList[indexPath.row].redemptionRefno ?? "-")"
                cell?.productCateogory.text = "श्रेणी: \(self.VM.myRedemptionList[indexPath.row].categoryName ?? "-")"
            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                cell?.productStatus.text = "বিচারাধীন"
                cell?.productRefNo.text = "রেফারেন্স# \(self.VM.myRedemptionList[indexPath.row].redemptionRefno ?? "-")"
                cell?.productCateogory.text = "ক্যাটাগরি: \(self.VM.myRedemptionList[indexPath.row].categoryName ?? "-")"
            }else{
//                cell?.productStatus.text = "పెండింగ్‌లో"
                cell?.productRefNo.text = "రిఎఫ్# \(self.VM.myRedemptionList[indexPath.row].redemptionRefno ?? "-")"
                cell?.productCateogory.text = "వర్గం: \(self.VM.myRedemptionList[indexPath.row].categoryName ?? "-")"
            }
           
        
        let receivedImage = self.VM.myRedemptionList[indexPath.row].productImage ?? ""
        let totalImgURL = productCatalogueImgURL + receivedImage
        cell?.productImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RedemptionCatalogueDetailsVC") as! RedemptionCatalogueDetailsVC
        vc.isComeFrom = "MyRedemption"
        vc.productImage = self.VM.myRedemptionList[indexPath.row].productImage ?? ""
        vc.prodRefNo = self.VM.myRedemptionList[indexPath.row].redemptionRefno ?? ""
        vc.productCategory = self.VM.myRedemptionList[indexPath.row].categoryName ?? ""
        vc.productName = self.VM.myRedemptionList[indexPath.row].productName ?? ""
        vc.productPoints = "\(self.VM.myRedemptionList[indexPath.row].redeemedPoints ?? 0)"
        vc.productDetails = self.VM.myRedemptionList[indexPath.row].productDesc ?? ""
        vc.termsandContions = self.VM.myRedemptionList[indexPath.row].termsCondition ?? ""
        vc.quantity = self.VM.myRedemptionList[indexPath.row].quantity ?? 0
        vc.tdspercentage1 = self.VM.myRedemptionList[indexPath.row].TDSPercentage ?? 0.0
        print(vc.tdspercentage1,"points")
        vc.applicabletds = self.VM.myRedemptionList[indexPath.row].ApplicableTds ?? 0.0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
}

