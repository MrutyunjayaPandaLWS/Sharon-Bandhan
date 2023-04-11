//
//  DownloadEWarrantyListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//  DownloadListTableViewCell

import UIKit
import Lottie
import SafariServices
import PDFKit
import Alamofire
import Firebase

class DownloadEWarrantyListViewController: BaseViewController, eWarrantyDelegate, UIDocumentInteractionControllerDelegate, popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    

    @IBOutlet weak var animationLottieView: LottieAnimationView!
    @IBOutlet weak var ewarrantytableView: UITableView!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var header: UILabel!
    
    var vm = DownloadEWarrantyListViewModel()
    var E_warrantyListArray = [LstEWarranty]()
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    var ewarrantyID = ""
    var productId = ""
    var productName = ""
    var fromSideMenu = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        noDataFound.isHidden = true
        self.ewarrantytableView.register(UINib(nibName: "DownloadListTableViewCell", bundle: nil), forCellReuseIdentifier: "DownloadListTableViewCell")

        self.ewarrantytableView.delegate = self
        self.ewarrantytableView.dataSource = self
        self.e_warrantyAPICall()
        languagelocalization()
        NotificationCenter.default.addObserver(self, selector: #selector(downloadEWarrantiesList), name: Notification.Name.downloadEwarrantyList, object: nil)
        self.lottieAnimation(animationView: self.animationLottieView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Download E-Warranty")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    @objc func downloadEWarrantiesList(){
        self.e_warrantyAPICall()
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.header.text = "E-Warranty"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.header.text = "ई-वारंटी"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.header.text = "ই-ওয়ারেন্টি"
        }else{
            self.header.text = "ఇ-వారంటీ"
        }
    }
    func e_warrantyAPICall() {
        let parameters = ["ActionType":2,"CustomerID": userID]
        self.vm.e_warrantyListAPi(parameters: parameters) { response in
            self.E_warrantyListArray = response?.lstEWarranty ?? []
            DispatchQueue.main.async {
                if self.E_warrantyListArray.count != 0 {
                    self.noDataFound.isHidden = true
                    self.ewarrantytableView.isHidden = false
                    self.ewarrantytableView.reloadData()
                }else{
                    self.noDataFound.isHidden = false
                    self.ewarrantytableView.isHidden = true
                }
                
                self.stopLoading()
            }
        }
    }
    
    func downloadEWarranty(_ vc: DownloadListTableViewCell) {
        guard let tappedIndexPath = ewarrantytableView.indexPath(for: vc) else{return}
        self.ewarrantyID = "\(self.E_warrantyListArray[tappedIndexPath.row].eWarrantyID ?? 0)"
        self.productId = "\(self.E_warrantyListArray[tappedIndexPath.row].productId ?? 0)"
        self.productName = self.E_warrantyListArray[tappedIndexPath.row].productName ?? ""
        downloadEWarrantyApiCall()
//        self.ewarrantytableView.reloadData()
    }
    
    func downloadEWarrantyApiCall(){
        let parameters = [
            "ActionType": "1",
            "EWarrantyId": "\(self.ewarrantyID)",
            "ProductId": "\(self.productId)"
        ] as [String: Any]
        print(parameters)
        self.vm.downloadEwarranty(parameters: parameters) { response in
            DispatchQueue.main.async {
            let warrantyDetails = response?.base64Image ?? ""
            if warrantyDetails != ""{
                self.pdf(data1: warrantyDetails , productName: self.productName)
            }else{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "No Attachment found to download E-Warranty"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "ई-वारंटी डाउनलोड करने के लिए कोई अटैचमेंट नहीं मिला"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "ই-ওয়্যারেন্টি ডাউনলোড করার জন্য কোন সংযুক্তি পাওয়া যায়নি"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "E-వారంటీని డౌన్‌లోడ్ చేయడానికి జోడింపు కనుగొనబడలేదు"
                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
                self.stopLoading()
            }
        }
    }
    func pdf(data1:String, productName:String){
        
        guard let  data = Data(base64Encoded: data1) else {
            print("unable to convert base 64 string to data")
            return
        }
        let dateFormatter : DateFormatter = DateFormatter()
        //  dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("EWarrantyCertificate_\(productName)_\(dateString).pdf")
        try! data.write(to: fileURL)
        let controller = UIDocumentInteractionController(url: fileURL)
        controller.delegate = self
        controller.presentPreview(animated: true)
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    
    @IBAction func addWarranryButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SelectProductEWarrantyListViewController") as! SelectProductEWarrantyListViewController
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
    
}
extension DownloadEWarrantyListViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.E_warrantyListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadListTableViewCell") as? DownloadListTableViewCell
        cell?.delegate = self
        cell?.customerName.text = self.E_warrantyListArray[indexPath.row].customerName ?? ""
        cell?.mobileNumberLabel.text = self.E_warrantyListArray[indexPath.row].mobileNum ?? ""
        cell?.generatedDate.text = self.E_warrantyListArray[indexPath.row].eWarrantyDate ?? ""
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
