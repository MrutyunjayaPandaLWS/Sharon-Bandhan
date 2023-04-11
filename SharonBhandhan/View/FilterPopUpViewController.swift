//
//  FilterPopUpViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 14/04/22.
//

import UIKit
protocol FilterDelegate {
    func selectedDateRange(_ vc: FilterPopUpViewController)
  
}


class FilterPopUpViewController: BaseViewController, DateSelectedDelegate, popUpDelegate, StatusDelegate{
    func selectStatus(_ vc: FilterByStatusPopUpVC) {
      
        self.selectedStatusId = vc.statusId
        self.selectedStatusName = vc.statusName
        self.selectStatusButton.setTitle(selectedStatusName, for: .normal)
        self.selectStatusButton.setTitleColor(.black, for: .normal)
        print(vc.statusId, "Status ID")
        print(vc.statusName, "Status Name")
        
    }
    
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    func acceptDate(_ vc: DOBVC) {
        if vc.isComeFrom == "1"{
            self.selectedFromDate = vc.selectedDate
            self.fromdateButton.setTitle(self.selectedFromDate, for: .normal)
            self.fromdateButton.setTitleColor(.black, for: .normal)
        }else{
            self.selectedToDate = vc.selectedDate
            self.toDateButton.setTitle(self.selectedToDate, for: .normal)
            self.toDateButton.setTitleColor(.black, for: .normal)
        }
    }
    func declineDate(_ vc: DOBVC) {}
    

    @IBOutlet var selectStatusButton: UIButton!
    @IBOutlet var fromdateButton: UIButton!
    @IBOutlet var toDateButton: UIButton!
    @IBOutlet weak var filterButton: GradientButton!
    @IBOutlet weak var statusView: UIView!
    var delegate: FilterDelegate!
    var selectedFromDate = ""
    var selectedToDate = ""
    var itsFrom = ""
    var selectedStatusName = ""
    var selectedStatusId = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        languagelocalization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.itsFrom == "FilterByStatus"{
            self.statusView.isHidden = false
            if self.selectedStatusName != "" && selectedFromDate == "" && selectedToDate == ""{
                self.selectStatusButton.setTitle(selectedStatusName, for: .normal)
                self.selectStatusButton.setTitleColor(.black, for: .normal)
                self.fromdateButton.setTitleColor(.lightGray, for: .normal)
                self.fromdateButton.setTitle("From Date", for: .normal)
                self.toDateButton.setTitleColor(.lightGray, for: .normal)
                self.toDateButton.setTitle("To Date", for: .normal)
            }else if self.selectedStatusName != "" && selectedFromDate != "" && selectedToDate != ""{
                self.selectStatusButton.setTitle(selectedStatusName, for: .normal)
                self.selectStatusButton.setTitleColor(.black, for: .normal)
                self.fromdateButton.setTitleColor(.black, for: .normal)
                self.fromdateButton.setTitle(self.selectedFromDate, for: .normal)
                self.toDateButton.setTitleColor(.black, for: .normal)
                self.toDateButton.setTitle(self.selectedToDate, for: .normal)
            }else if selectedToDate != "" && selectedFromDate == "" && self.selectedStatusName == ""{
                self.selectStatusButton.setTitle("Select Status", for: .normal)
                self.selectStatusButton.setTitleColor(.lightGray, for: .normal)
                self.toDateButton.setTitleColor(.black, for: .normal)
                self.toDateButton.setTitle(self.selectedToDate, for: .normal)
                self.fromdateButton.setTitleColor(.lightGray, for: .normal)
                self.fromdateButton.setTitle("From Date", for: .normal)
            }else if selectedToDate == "" && selectedFromDate != "" && self.selectedStatusName == ""{
                self.selectStatusButton.setTitle("Select Status", for: .normal)
                self.selectStatusButton.setTitleColor(.lightGray, for: .normal)
                self.toDateButton.setTitleColor(.lightGray, for: .normal)
                self.toDateButton.setTitle("To Date", for: .normal)
                self.fromdateButton.setTitleColor(.black, for: .normal)
                self.fromdateButton.setTitle(self.selectedFromDate, for: .normal)
            }else{
                self.fromdateButton.setTitleColor(.lightGray, for: .normal)
                self.fromdateButton.setTitle("From Date", for: .normal)
                self.toDateButton.setTitleColor(.lightGray, for: .normal)
                self.toDateButton.setTitle("To Date", for: .normal)
                self.selectStatusButton.setTitle("Select Status", for: .normal)
                self.selectStatusButton.setTitleColor(.lightGray, for: .normal)
            }
           
        }else{
            self.statusView.isHidden = true
            if selectedFromDate == "" && selectedToDate == ""{
                self.fromdateButton.setTitleColor(.lightGray, for: .normal)
                self.fromdateButton.setTitle("From Date", for: .normal)
                self.toDateButton.setTitleColor(.lightGray, for: .normal)
                self.toDateButton.setTitle("To Date", for: .normal)
            }else if selectedFromDate != "" && selectedToDate != ""{
                self.fromdateButton.setTitleColor(.black, for: .normal)
                self.fromdateButton.setTitle(self.selectedFromDate, for: .normal)
                self.toDateButton.setTitleColor(.black, for: .normal)
                self.toDateButton.setTitle(self.selectedToDate, for: .normal)
            }else if selectedToDate != "" && selectedFromDate == ""{
                self.toDateButton.setTitleColor(.black, for: .normal)
                self.toDateButton.setTitle(self.selectedToDate, for: .normal)
                self.fromdateButton.setTitleColor(.lightGray, for: .normal)
                self.fromdateButton.setTitle("From Date", for: .normal)
            }else if selectedToDate == "" && selectedFromDate != ""{
                self.toDateButton.setTitleColor(.lightGray, for: .normal)
                self.toDateButton.setTitle("To Date", for: .normal)
                self.fromdateButton.setTitleColor(.black, for: .normal)
                self.fromdateButton.setTitle(self.selectedFromDate, for: .normal)
            }else{
                self.fromdateButton.setTitleColor(.lightGray, for: .normal)
                self.fromdateButton.setTitle("From Date", for: .normal)
                self.toDateButton.setTitleColor(.lightGray, for: .normal)
                self.toDateButton.setTitle("To Date", for: .normal)
            }
        }
    }
    override func touchesBegan(_ touchscreen: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touchscreen.first
        if touch?.view != self.presentingViewController
        {
            self.dismiss(animated: true, completion: nil)

        }
    }
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            filterButton.setTitle("ewFilterKEY".localizableString(loc: "en"), for: .normal)
            fromdateButton.setTitle("ewFromDatemKEY".localizableString(loc: "en"), for: .normal)
            toDateButton.setTitle("ewToDateKEY".localizableString(loc: "en"), for: .normal)
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            filterButton.setTitle("ewFilterKEY".localizableString(loc: "hi"), for: .normal)
            fromdateButton.setTitle("ewFromDatemKEY".localizableString(loc: "hi"), for: .normal)
            toDateButton.setTitle("ewToDateKEY".localizableString(loc: "hi"), for: .normal)
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            filterButton.setTitle("ewFilterKEY".localizableString(loc: "bn"), for: .normal)
            fromdateButton.setTitle("ewFromDatemKEY".localizableString(loc: "bn"), for: .normal)
            toDateButton.setTitle("ewToDateKEY".localizableString(loc: "bn"), for: .normal)
        }else{
            filterButton.setTitle("ewFilterKEY".localizableString(loc: "te"), for: .normal)
            fromdateButton.setTitle("ewFromDatemKEY".localizableString(loc: "te"), for: .normal)
            toDateButton.setTitle("ewToDateKEY".localizableString(loc: "te"), for: .normal)
        }
      }
    
    
    @IBAction func selectStatus(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FilterByStatusPopUpVC") as? FilterByStatusPopUpVC
        vc!.delegate = self
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func fromDate(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DOBVC") as? DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "1"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func toDAte(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DOBVC") as? DOBVC
        vc!.delegate = self
        vc!.isComeFrom = "2"
        vc!.modalPresentationStyle = .overCurrentContext
        vc!.modalTransitionStyle = .coverVertical
        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func filterButton(_ sender: Any) {
        if self.itsFrom == "FilterByStatus"{
            if self.selectStatusButton.currentTitle != "" && self.selectedFromDate == "" && self.selectedToDate == ""{
                self.delegate.selectedDateRange(self)
                self.dismiss(animated: true, completion: nil)
            }else if  self.selectStatusButton.currentTitle != "" && self.selectedFromDate != "" && self.selectedToDate != ""{
                if selectedToDate < selectedFromDate{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                            vc!.descriptionInfo = "To Date should greater than From Date"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                            vc!.descriptionInfo = "तिथि करने के लिए दिनांक से अधिक होना चाहिए"
                        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                            vc!.descriptionInfo = "তারিখ থেকে তারিখ থেকে বড় হওয়া উচিত"
                        }else{
                            vc!.descriptionInfo = "టు డేట్ ఫ్రమ్ డేట్ కంటే ఎక్కువ ఉండాలి"
                        }
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.present(vc!, animated: true, completion: nil)
                    }
                }else{
                    self.delegate.selectedDateRange(self)
                    self.dismiss(animated: true, completion: nil)
                }
            }else if  self.selectStatusButton.currentTitle != "" && self.selectedFromDate != "" && self.selectedToDate == ""{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Select To Date"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                        vc!.descriptionInfo = "तिथि करने के लिए चुनें"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "টু ডেট নির্বাচন করুন"
                    }else{
                        vc!.descriptionInfo = "తేదీని ఎంచుకోండి"
                    }
                   
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else if  self.selectStatusButton.currentTitle != "" && self.selectedFromDate == "" && self.selectedToDate != ""{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Select From Date"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                        vc!.descriptionInfo = "दिनांक से चुनें"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "তারিখ থেকে নির্বাচন করুন"
                    }else{
                        vc!.descriptionInfo = "తేదీ నుండి ఎంచుకోండి"
                    }
                    
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
         
        }else if selectedFromDate == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Select From Date"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                    vc!.descriptionInfo = "दिनांक से चुनें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "তারিখ থেকে নির্বাচন করুন"
                }else{
                    vc!.descriptionInfo = "తేదీ నుండి ఎంచుకోండి"
                }
                
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else if selectedToDate == ""{
            DispatchQueue.main.async{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Select To Date"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                    vc!.descriptionInfo = "तिथि करने के लिए चुनें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "টু ডেট নির্বাচন করুন"
                }else{
                    vc!.descriptionInfo = "తేదీని ఎంచుకోండి"
                }
               
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
        }else{
            if selectedToDate < selectedFromDate{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "To Date should greater than From Date"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                        vc!.descriptionInfo = "तिथि करने के लिए दिनांक से अधिक होना चाहिए"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "তারিখ থেকে তারিখ থেকে বড় হওয়া উচিত"
                    }else{
                        vc!.descriptionInfo = "టు డేట్ ఫ్రమ్ డేట్ కంటే ఎక్కువ ఉండాలి"
                    }
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                self.delegate.selectedDateRange(self)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
