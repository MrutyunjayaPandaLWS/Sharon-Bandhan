//
//  SelectProductEWarrantyListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Lottie
import Firebase
import LanguageManager_iOS

class SelectProductEWarrantyListViewController: BaseViewController, DateSelectedDelegate, quantityDelegate, popUpDelegate {
   
    
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet var fromdateButton: UIButton!
    @IBOutlet weak var animationLottieView: LottieAnimationView!
    @IBOutlet var toDateButton: UIButton!
    @IBOutlet weak var addE_warrantyTableView: UITableView!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noDataFound: UILabel!
    @IBOutlet weak var filterBTN: GradientButton!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    var vm = SelectProductEWarrantyListViewModel()
    var addE_warrantyListArray = [LstEWarranty]()
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    var selectedFromDate = ""
    var selectedToDate = ""
    var isQtyAdded = 0
    var enteredValue = ""
    
    var selectedAreaName = ""
    var selectedCityName = ""
    var selectedAreaID = -1
    var selectedCityID = -1
    var brandId = -1
    var eWarrantyQty = -1
    var productId = -1
    var productName = ""
    var brandName = ""
    var filteredDataArray = [FilteredData]()
    var areaDetails = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // playAnimation()
        self.vm.VC = self
        infoLbl.isHidden = true
        self.addE_warrantyTableView.register(UINib(nibName: "SelectProductEWarrantyListTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectProductEWarrantyListTableViewCell")
        noDataFound.isHidden = true
        self.addE_warrantyTableView.delegate = self
        self.addE_warrantyTableView.dataSource = self
        let currentDate = Date()
        print(currentDate)
        let date = "\(currentDate)".components(separatedBy: " ")
        print(date)
        self.selectedFromDate = "\(date[0])"
        self.selectedToDate = "\(date[0])"
        self.fromdateButton.setTitle(selectedFromDate, for: .normal)
        self.toDateButton.setTitle(selectedToDate, for: .normal)
        self.nextButton.isHidden = true
        self.filterView.isHidden = false
        self.nextButtonHeightConstraint.constant = 0
        apiCalling()
        languagelocalization()
        NotificationCenter.default.addObserver(self, selector: #selector(checkEnteredCount), name: Notification.Name.checkProductsCount, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//            guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//            tracker.set(kGAIScreenName, value: "Select Product E-Warranty")
//
//            guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//            tracker.send(builder.build() as [NSObject : AnyObject])

        self.filterView.isHidden = false
    }
    
    @objc func checkEnteredCount(){
        
        self.nextButton.isHidden = false
        self.nextButtonHeightConstraint.constant = 40
        self.filterView.isHidden = true

    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func fromDate(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DOBVC") as? DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "1"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func toDate(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DOBVC") as? DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "2"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func filterButton(_ sender: Any) {
        
//        if fromdateButton.currentTitle == "mrFromDateKEY" || fromdateButton.currentTitle == "की तिथि से" || fromdateButton.currentTitle == "তারিখ হইতে" || fromdateButton.currentTitle == "తేదీ నుండి"
            if fromdateButton.currentTitle == "mrFromDateKEY".localiz(){
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "PlzSelectFromDateKey".localiz()
//                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                    vc!.descriptionInfo = "Select From Date"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                    vc!.descriptionInfo = "दिनांक से चुनें"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                    vc!.descriptionInfo = "তারিখ থেকে নির্বাচন করুন"
//                }else{
//                    vc!.descriptionInfo = "తేదీ నుండి ఎంచుకోండి"
//                }
                
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            }else if toDateButton.currentTitle == "mrToDateKEY".localiz(){
//                 || toDateButton.currentTitle == "तारीख तक" || toDateButton.currentTitle == "এখন পর্যন্ত" || toDateButton.currentTitle == "ఇప్పటి వరకు"
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "SelectToDateKey".localiz()
//                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                    vc!.descriptionInfo = "Select To Date"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                    vc!.descriptionInfo = "तिथि करने के लिए चुनें"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                    vc!.descriptionInfo = "টু ডেট নির্বাচন করুন"
//                }else{
//                    vc!.descriptionInfo = "తేదీని ఎంచుకోండి"
//                }
               
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            if selectedFromDate > selectedToDate{
                DispatchQueue.main.async{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
            vc!.delegate = self
            vc!.titleInfo = ""
            vc!.descriptionInfo = "ToDateGreaterFromDateKey".localiz()
//            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                vc!.descriptionInfo = "ToDateGreaterFromDateKey".localiz()
//             }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                 vc!.descriptionInfo = "आज तक की तारीख से बड़ी होनी चाहिए।"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                vc!.descriptionInfo = "তারিখ থেকে তারিখ থেকে বড় হওয়া উচিত।"
//            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                vc!.descriptionInfo = "తేదీ నుండి తేదీ కంటే ఎక్కువగా ఉండాలి."
//              }
            vc!.modalPresentationStyle = .overCurrentContext
            vc!.modalTransitionStyle = .crossDissolve
            self.present(vc!, animated: true, completion: nil)
        }
            }else {
                apiCalling()
            }
        
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubmitEWarrantyViewController") as! SubmitEWarrantyViewController
        print(filteredDataArray.count, "Fiasodjflasjfajs")
//        if filteredDataArray.count != 0 {
//            vc.selectedAreaName = self.filteredDataArray[0].selectedAreaName
//            vc.selectedCityName = self.filteredDataArray[0].selectedCityName
//            vc.selectedAreaID = self.filteredDataArray[0].selectedAreaID
//            vc.selectedCityID = self.filteredDataArray[0].selectedCityID
//            vc.brandId = self.filteredDataArray[0].brandId
//            vc.eWarrantyQty = self.filteredDataArray[0].eWarrantyQty
//            vc.productId = self.filteredDataArray[0].productId
//            vc.productName = self.filteredDataArray[0].productName
//            vc.brandName = self.filteredDataArray[0].brandName
            
            
        vc.areaDetails = self.areaDetails
            vc.selectedAreaName = self.selectedAreaName
            vc.selectedCityName = self.selectedCityName
            vc.selectedAreaID = self.selectedAreaID
            vc.selectedCityID = self.selectedCityID
            vc.brandId = self.brandId
            vc.eWarrantyQty = self.eWarrantyQty
            vc.productId = self.productId
            vc.productName = self.productName
            vc.brandName = self.brandName
            print(self.brandId, "Filtered Brand ID")
            print(self.eWarrantyQty, "Enter QTY Value")
            print(self.productId, " Product ID")
     //   }
//        print(self.brandId, "Filtered Brand ID")
//        print(self.eWarrantyQty, "Enter QTY Value")
//        print(self.productId, " Product ID")
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func languagelocalization(){
        header.text = "Add E-Warranty".localiz()
        filterBTN.setTitle("FilterKey".localiz(), for: .normal)
        fromdateButton.setTitle("mrFromDateKEY".localiz(), for: .normal)
        toDateButton.setTitle("mrToDateKEY".localiz(), for: .normal)
        infoLbl.text = "Select date range to check your E-Warranty".localiz()
        nextButton.setTitle("ewNextKEY".localiz(), for: .normal)
        
//        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//            header.text = "Add E-Warranty"
//            filterBTN.setTitle("Filter", for: .normal)
//            fromdateButton.setTitle("From Date", for: .normal)
//            toDateButton.setTitle("To Date", for: .normal)
//            infoLbl.text = "Select date range to check your E-Warranty"
//            nextButton.setTitle("Next", for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//            header.text = "ई-वारंटी जोड़ें"
//            filterBTN.setTitle("फ़िल्टर", for: .normal)
//            fromdateButton.setTitle("की तिथि से", for: .normal)
//            toDateButton.setTitle("तारीख तक", for: .normal)
//            infoLbl.text = "अपनी ई-वारंटी जांचने के लिए दिनांक सीमा चुनें"
//            nextButton.setTitle("अगला", for: .normal)
//        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//            header.text = "ই-ওয়ারেন্টি যোগ করুন"
//            filterBTN.setTitle("ছাঁকনি", for: .normal)
//            fromdateButton.setTitle("তারিখ হইতে", for: .normal)
//            toDateButton.setTitle("এখন পর্যন্ত", for: .normal)
//            infoLbl.text = "আপনার ই-ওয়ারেন্টি চেক করতে তারিখের সীমা নির্বাচন করুন"
//            nextButton.setTitle("পরের", for: .normal)
//        }else{
//            header.text = "ఇ-వారెంటీని జోడించండి"
//            filterBTN.setTitle("ఫిల్టర్ చేయండి", for: .normal)
//            fromdateButton.setTitle("తేదీ నుండి", for: .normal)
//            toDateButton.setTitle("ఇప్పటి వరకు", for: .normal)
//            infoLbl.text = "మీ E-వారెంటీని తనిఖీ చేయడానికి తేదీ పరిధిని ఎంచుకోండి"
//            nextButton.setTitle("తదుపరి", for: .normal)
//        }
    }
    
    //Delegate:-
    
    func quantityDidTap(_ vc: SelectProductEWarrantyListTableViewCell) {
    
        guard let tappedIndexPath = addE_warrantyTableView.indexPath(for: vc) else { return }
        if self.addE_warrantyListArray.count > 1{
            if vc.enterQtyTF.text?.count != 0 {
                if Int(vc.enterQtyTF.text!) ?? 0 <= self.addE_warrantyListArray[tappedIndexPath.row].eWarrantyQty ?? 0{
                    self.enteredValue = vc.enterQtyTF.text!
                    
                }
                let filterArray = self.addE_warrantyListArray.filter{$0.textAdded == 1}
                print(filterArray.count, "Filter Array Count")
                if filterArray.count == 0{
                    isQtyAdded = 1
                }else{
                    isQtyAdded += 1
                    print("Else Part")
//                    if filterArray.count == 1{
//                        //
//                    }else{
//                        isQtyAdded += 1
//                    }
                    
                }
                
               
//                if vc.enterQtyTF.text!.count > 1 {
//                    isQtyAdded = 1
//                }else if vc.addedValue == 1{
//                    if self.addE_warrantyListArray[tappedIndexPath.row].textAdded == 1{
//                        isQtyAdded = 1
//                    }else{
//                        isQtyAdded += 1
//                    }
//                }
                print(self.isQtyAdded, "AddedValues")
                if self.isQtyAdded > 1 {
                    vc.enterQtyTF.text = ""
                    isQtyAdded = 0
                    self.addE_warrantyListArray[tappedIndexPath.row].textAdded = 0
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "enteredCount"
                    vc!.descriptionInfo = "Only 1 product we can add".localiz()
                    
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Only 1 product we can add"
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "केवल 1 उत्पाद हम जोड़ सकते हैं"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "আমরা শুধুমাত্র 1 পণ্য যোগ করতে পারেন"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "మేము జోడించగల 1 ఉత్పత్తి మాత్రమే"
//                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                   
                } else if Int( vc.enterQtyTF.text ?? "") ?? 0 > self.addE_warrantyListArray[tappedIndexPath.row].eWarrantyQty ?? 0 {
                    isQtyAdded = 0
                    self.addE_warrantyListArray[tappedIndexPath.row].textAdded = 0
//                    vc.enterQtyTF.text = self.enteredValue
//                    print(self.enteredValue, "entereasfdf")
                    vc.enterQtyTF.text = ""
                    
                    
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Quantity should not exceed.".localiz()
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Quantity should not exceed."
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "मात्रा अधिक नहीं होनी चाहिए।"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "পরিমাণের বেশি হওয়া উচিত নয়।"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "పరిమాణం మించకూడదు."
//                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                    
                } else if Int(vc.enterQtyTF.text ?? "0") ?? 0 == 0 {
                    self.addE_warrantyListArray[tappedIndexPath.row].textAdded = 0
                    isQtyAdded = 0
                    vc.enterQtyTF.text = ""
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.descriptionInfo = "Quantity should not be zero.".localiz()

//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Quantity should not be zero.".localiz()
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "मात्रा शून्य नहीं होनी चाहिए।"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "পরিমাণ শূন্য হওয়া উচিত নয়।"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "పరిమాణం సున్నా కాకూడదు."
//                      }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                } else {
                    self.addE_warrantyListArray[tappedIndexPath.row].noOfQty = Int(vc.enterQtyTF.text ?? "0") ?? 0
                    self.eWarrantyQty = Int(vc.enterQtyTF.text ?? "0") ?? 0
                    self.addE_warrantyListArray[tappedIndexPath.row].textAdded = 1
                    
                    self.nextButton.isHidden = false
                    self.filterView.isHidden = true
                    self.nextButtonHeightConstraint.constant = 40
                    self.areaDetails = self.addE_warrantyListArray[tappedIndexPath.row].address ?? ""
                    self.brandId = self.addE_warrantyListArray[tappedIndexPath.row].brandId ?? -1
                    self.productId = self.addE_warrantyListArray[tappedIndexPath.row].productId ?? -1
                    print("Next Button will Show")
                }
            } else {
                isQtyAdded = 0
                self.addE_warrantyListArray[tappedIndexPath.row].noOfQty = 0
                self.addE_warrantyListArray[tappedIndexPath.row].textAdded = 0
            }
        }else{
            if Int(vc.enterQtyTF.text ?? "0") ?? 0 == 0 {
                vc.enterQtyTF.text = ""
                isQtyAdded = 0
                self.addE_warrantyListArray[tappedIndexPath.row].textAdded = 0
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Quantity should not be zero.".localiz()
//                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                    vc!.descriptionInfo = "Quantity should not be zero."
//                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                     vc!.descriptionInfo = "मात्रा शून्य नहीं होनी चाहिए।"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                    vc!.descriptionInfo = "পরিমাণ শূন্য হওয়া উচিত নয়।"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                    vc!.descriptionInfo = "పరిమాణం సున్నా కాకూడదు."
//                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }else if Int( vc.enterQtyTF.text ?? "") ?? 0 > self.addE_warrantyListArray[tappedIndexPath.row].eWarrantyQty ?? 0 {
                isQtyAdded = 0
//                vc.enterQtyTF.text = self.enteredValue
//                print(self.enteredValue, "entereasfdf")
                self.addE_warrantyListArray[tappedIndexPath.row].textAdded = 0
                vc.enterQtyTF.text = ""
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.descriptionInfo = "Quantity should not exceed.".localiz()
//                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                    vc!.descriptionInfo = "Quantity should not exceed."
//                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                     vc!.descriptionInfo = "मात्रा अधिक नहीं होनी चाहिए।"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                    vc!.descriptionInfo = "পরিমাণের বেশি হওয়া উচিত নয়।"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                    vc!.descriptionInfo = "పరిమాణం మించకూడదు."
//                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
                
            }else{
                isQtyAdded = 1
                    self.addE_warrantyListArray[tappedIndexPath.row].noOfQty = Int(vc.enterQtyTF.text ?? "0") ?? 0
                    self.addE_warrantyListArray[tappedIndexPath.row].textAdded = 1
                    self.eWarrantyQty = Int(vc.enterQtyTF.text ?? "0") ?? 0
                    self.nextButton.isHidden = false
                self.filterView.isHidden = true
                    self.nextButtonHeightConstraint.constant = 40
                self.areaDetails = self.addE_warrantyListArray[tappedIndexPath.row].address ?? ""
                self.brandId = self.addE_warrantyListArray[tappedIndexPath.row].brandId ?? -1
                self.productId = self.addE_warrantyListArray[tappedIndexPath.row].productId ?? -1
            }
        }
       print(isQtyAdded, "QTY Value")
//        let filterArray = self.addE_warrantyListArray.filter{$0.textAdded == 1}
//        print(filterArray.count, "Filter Count")
//        if filterArray.count == 0{
//
////        }
        if isQtyAdded == 0 {
            self.nextButton.isHidden = true
            self.filterView.isHidden = false
            self.nextButtonHeightConstraint.constant = 0
//            self.selectedAreaName = ""
//              self.selectedCityName = ""
//              self.selectedAreaID = 0
//              self.selectedCityID = 0
//              self.brandId = 0
//              self.eWarrantyQty = 0
//              self.productId = 0
//            self.productName = ""
//            self.brandName = ""
        
//                self.selectedAreaName = ""
//                self.selectedCityName = ""
//                self.selectedAreaID = 0
//                self.selectedCityID = 0
//                self.brandId = 0
//                self.eWarrantyQty = 0
//                self.productId = 0
//                self.productName = ""
//                self.brandName = ""
           
            if let index = filteredDataArray.firstIndex(where: {$0.eWarrantyQty == 0 || $0.eWarrantyQty == nil}) {
                filteredDataArray.remove(at: index)
            }
            print(self.filteredDataArray.count ,"askldfjasjklfjksldafljksadflajskd")
            
            for data in self.filteredDataArray{
            
                print(data.brandId)
                print(data.productId)
                print(data.eWarrantyQty, "Test")
                
                self.selectedAreaName = data.selectedAreaName
                self.selectedCityName = data.selectedCityName
                self.selectedAreaID = data.selectedAreaID
                self.selectedCityID = data.selectedCityID
                self.brandId = data.brandId
                self.eWarrantyQty = data.eWarrantyQty
                self.productId = data.productId
                self.productName = data.productName
                self.brandName = data.brandName
                
                
            }
            
            

        } else if isQtyAdded == 1 {
            self.nextButton.isHidden = false
            self.filterView.isHidden = true
            self.nextButtonHeightConstraint.constant = 40
            self.areaDetails = self.addE_warrantyListArray[tappedIndexPath.row].address ?? ""
            self.brandId = self.addE_warrantyListArray[tappedIndexPath.row].brandId ?? -1
            self.productId = self.addE_warrantyListArray[tappedIndexPath.row].productId ?? -1
            
            print(self.addE_warrantyListArray[tappedIndexPath.row].brandId ?? 0, "Selected Brand ID")
            print(self.eWarrantyQty, "Entered QTY Value")
            print(self.addE_warrantyListArray[tappedIndexPath.row].productId ?? 0, " Selected Product ID")
            filteredDataArray.append(FilteredData(selectedAreaName: self.addE_warrantyListArray[tappedIndexPath.row].areaName ?? "", selectedCityName: self.addE_warrantyListArray[tappedIndexPath.row].cityName ?? "", selectedAreaID: self.addE_warrantyListArray[tappedIndexPath.row].areaId ?? 0, selectedCityID: self.addE_warrantyListArray[tappedIndexPath.row].cityId ?? 0, brandId: self.addE_warrantyListArray[tappedIndexPath.row].brandId ?? 0, eWarrantyQty: Int(vc.enterQtyTF.text ?? "0") ?? 0, productId: self.addE_warrantyListArray[tappedIndexPath.row].productId ?? 0, productName: self.addE_warrantyListArray[tappedIndexPath.row].productName ?? "", brandName: self.addE_warrantyListArray[tappedIndexPath.row].brandName ?? ""))
            
            
            
//            self.selectedAreaName = self.addE_warrantyListArray[tappedIndexPath.row].areaName ?? ""
//              self.selectedCityName = self.addE_warrantyListArray[tappedIndexPath.row].cityName ?? ""
//              self.selectedAreaID = self.addE_warrantyListArray[tappedIndexPath.row].areaId ?? 0
//              self.selectedCityID = self.addE_warrantyListArray[tappedIndexPath.row].cityId ?? 0
//              self.brandId = self.addE_warrantyListArray[tappedIndexPath.row].brandId ?? 0
//                self.eWarrantyQty = Int(vc.enterQtyTF.text ?? "0") ?? 0
//              self.productId = self.addE_warrantyListArray[tappedIndexPath.row].productId ?? 0
//            self.productName = self.addE_warrantyListArray[tappedIndexPath.row].productName ?? ""
//            self.brandName = self.addE_warrantyListArray[tappedIndexPath.row].brandName ?? ""
//            print("Selected Product Details")
//            print(self.brandId)
//            print(self.productName)

        }
    }
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    func acceptDate(_ vc: DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.fromdateButton.setTitle(vc.selectedDate, for: .normal)
            self.fromdateButton.setTitleColor(.black, for: .normal)
        }else{
            self.selectedToDate = vc.selectedDate
            self.toDateButton.setTitle(vc.selectedDate, for: .normal)
            self.toDateButton.setTitleColor(.black, for: .normal)
        }
    }
    
    func declineDate(_ vc: DOBVC) {}
    
    func apiCalling() {
        let parameters = ["ActionType":1,"CustomerID":userID,"FromDate":"\(selectedFromDate)","ToDate":"\(selectedToDate)"]
        print(parameters)
        self.vm.addE_warrantyListAPi(parameters: parameters) { response in
            self.addE_warrantyListArray = response?.lstEWarranty ?? []
            DispatchQueue.main.async {
                if self.addE_warrantyListArray.count != 0{
                    
                    self.addE_warrantyTableView.isHidden = false
                    self.addE_warrantyTableView.reloadData()
                }else{
                    
                    self.addE_warrantyTableView.isHidden = true
                    
                }
                
                self.stopLoading()
            }
        }
    }
    
    
}
extension SelectProductEWarrantyListViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addE_warrantyListArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectProductEWarrantyListTableViewCell") as? SelectProductEWarrantyListTableViewCell
        cell?.delegate = self
        cell?.areaLabel.text = self.addE_warrantyListArray[indexPath.row].address ?? ""
        cell?.brandNameLabel.text = self.addE_warrantyListArray[indexPath.row].brandName ?? ""
        cell?.productNameLabel.text = self.addE_warrantyListArray[indexPath.row].productName ?? ""
        cell?.totalQRCodeLael.text = String(self.addE_warrantyListArray[indexPath.row].eWarrantyQty ?? 0)
        if self.addE_warrantyListArray[indexPath.row].noOfQty != 0 {
            cell?.enterQtyTF.text = "\(self.addE_warrantyListArray[indexPath.row].noOfQty)"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
 
}

class FilteredData: NSObject{

    var selectedAreaName: String!
    var selectedCityName: String!
    var selectedAreaID: Int!
    var selectedCityID: Int!
    var brandId: Int!
    var eWarrantyQty: Int!
    var productId: Int!
    var productName: String!
    var brandName: String!
    init(selectedAreaName: String!, selectedCityName: String!, selectedAreaID: Int!, selectedCityID: Int!, brandId: Int!, eWarrantyQty: Int!, productId: Int!, productName: String!, brandName: String!) {
        self.selectedAreaName = selectedAreaName
        self.selectedCityName = selectedCityName
        self.selectedAreaID = selectedAreaID
        self.selectedCityID = selectedCityID
        self.brandId = brandId
        self.eWarrantyQty = eWarrantyQty
        self.productId = productId
        self.productName = productName
        self.brandName = brandName
    }
}
