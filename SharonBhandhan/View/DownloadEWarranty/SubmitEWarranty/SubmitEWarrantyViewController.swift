//
//  SubmitEWarrantyViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import SafariServices
import PDFKit
import Alamofire
import Lottie
import Firebase

class SubmitEWarrantyViewController: BaseViewController, SelectedItemDelegate, UITextFieldDelegate, UIDocumentInteractionControllerDelegate, popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {
    }
    
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var mobileNumberTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var addressTF: UITextField!
    @IBOutlet var cityButton: UIButton!
    @IBOutlet var areaButton: UIButton!
    @IBOutlet var generateE_warranty: GradientButton!
    
    
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var area: UILabel!
    
    
    var vm = SubmitEWarrantyViewModel()
    var userID = UserDefaults.standard.value(forKey: "UserID") ?? -1
    var selectedAreaName = ""
    var selectedCityName = ""
    var selectedAreaID = -1
    var selectedCityID = -1
    var brandId = -1
    var eWarrantyQty = -1
    var productId = -1
    var productName = ""
    var brandName = ""
    var ewarrantyID = 0
    var itsFrom = 0
    var areaDetails = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        self.selectedAreaID = -1
        self.selectedCityID = -1
        mobileNumberTF.delegate = self
        self.mobileNumberTF.keyboardType = .numberPad
        languagelocalization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Submit E-Warranty")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.header.text = "Add E-Warranty"
            self.name.text = "Name *"
            self.mobile.text = "Mobile *"
            self.email.text = "Email"
            self.address.text = "Address *"
            self.city.text = "City"
            self.area.text = "Area"
            self.nameTF.placeholder = "Enter Name"
            self.mobileNumberTF.placeholder = "Enter Mobile"
            self.emailTF.placeholder = "Enter Email"
            self.addressTF.placeholder = "Enter Address"
            self.generateE_warranty.setTitle("Generate E-Warranty", for: .normal)
            self.cityButton.setTitle("Select City", for: .normal)
            self.areaButton.setTitle("Select Area", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.header.text = "ई-वारंटी जोड़ें"
            self.name.text = "नाम *"
            self.mobile.text = "मोबाइल *"
            self.email.text = "ईमेल"
            self.address.text = "पता *"
            self.city.text = "शहर"
            self.area.text = "क्षेत्र"
            self.nameTF.placeholder = "नाम दर्ज करें"
            self.mobileNumberTF.placeholder = "मोबाइल दर्ज करें"
            self.emailTF.placeholder = "ईमेल दर्ज करें"
            self.addressTF.placeholder = "पता दर्ज करें"
            self.generateE_warranty.setTitle("ई-वारंटी जनरेट करें", for: .normal)
            self.cityButton.setTitle("शहर चुनें", for: .normal)
            self.areaButton.setTitle("क्षेत्र चुनें", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            
            self.header.text = "ই-ওয়ারেন্টি যোগ করুন"
            self.name.text = "নাম *"
            self.mobile.text = "মুঠোফোন *"
            self.email.text = "ইমেইল"
            self.address.text = "ঠিকানা *"
            self.city.text = "শহর"
            self.area.text = "এলাকা"
            self.nameTF.placeholder = "নাম লিখুন"
            self.mobileNumberTF.placeholder = "মোবাইলে প্রবেশ করুন"
            self.emailTF.placeholder = "ইমেইল প্রদান করুন"
            self.addressTF.placeholder = "ঠিকানা লিখুন"
            self.generateE_warranty.setTitle("ই-ওয়ারেন্টি জেনারেট করুন", for: .normal)
            self.cityButton.setTitle("সিটি নির্বাচন করুন", for: .normal)
            self.areaButton.setTitle("এলাকা নির্বাচন করুন৷", for: .normal)
            
        }else{
        
            self.header.text = "ఇ-వారెంటీని జోడించండి"
            self.name.text = "పేరు *"
            self.mobile.text = "మొబైల్ *"
            self.email.text = "ఇమెయిల్"
            self.address.text = "చిరునామా *"
            self.city.text = "నగరం"
            self.area.text = "ప్రాంతం"
            self.nameTF.placeholder = "పేరు నమోదు చేయండి"
            self.mobileNumberTF.placeholder = "మొబైల్‌ని నమోదు చేయండి"
            self.emailTF.placeholder = "ఇమెయిల్ నమోదు చేయండి"
            self.addressTF.placeholder = "చిరునామాను నమోదు చేయండి"
            self.generateE_warranty.setTitle("E-వారెంటీని రూపొందించండి", for: .normal)
            self.cityButton.setTitle("సిటీని ఎంచుకోండి", for: .normal)
            self.areaButton.setTitle("ఏరియాను ఎంచుకోండి", for: .normal)
        }
    }
    
    
    
    
    @IBAction func cityButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
            vc.delegate = self
            vc.isComeFrom = 2
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func areaButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DropDownVC") as! DropDownVC
            vc.delegate = self
            vc.isComeFrom = 4
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func nackButton(_ sender: Any) {
        if generateE_warranty.currentTitle == "Generate E-Warranty"{
            self.navigationController?.popViewController(animated: true)
        }else{
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: DownloadEWarrantyListViewController.self) {
                    _ =  self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            } }
    }
    
    @IBAction func generateE_warranty(_ sender: Any) {
        
        if generateE_warranty.currentTitle == "Generate E-Warranty" {
            if self.nameTF.text?.count == 0 {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Enter Name"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "नाम दर्ज करें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "নাম লিখুন"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "పేరు నమోదు చేయండి"
                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }else if mobileNumberTF.text?.count == 0 {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Enter Mobile Number"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "मोबाइल नंबर डालें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "মোবাইল নম্বর লিখুন"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "మొబైల్ నంబర్ ఎంటర్ చేయండి"
                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }else if mobileNumberTF.text?.count != 10 {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Enter Valid Mobile Number"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "वैध मोबाइल नंबर दर्ज करें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "বৈধ মোবাইল নম্বর লিখুন"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "చెల్లుబాటయ్యే మొబైల్ నంబర్‌ని నమోదు చేయండిr"
                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
//            else if emailTF.text?.count == 0{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//
//                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                    vc!.descriptionInfo = "Enter Email ID"
//                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                     vc!.descriptionInfo = "ईमेल आईडी दर्ज करें"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                    vc!.descriptionInfo = "ইমেইল আইডি লিখুন"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                    vc!.descriptionInfo = "ఈమెయిల్ ఐడిని నమోదు చేయండి"
//                  }
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
//            else if !isValidEmail(emailTF.text ?? "") {
//                DispatchQueue.main.async{
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//
//                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                        vc!.descriptionInfo = "Enter Valid EmailID"
//                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                         vc!.descriptionInfo = "मान्य ईमेल आईडी दर्ज करें"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                        vc!.descriptionInfo = "বৈধ ইমেইল আইডি লিখুন"
//                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                        vc!.descriptionInfo = "చెల్లుబాటు అయ్యే ఇమెయిల్ IDని నమోదు చేయండి"
//                      }
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.present(vc!, animated: true, completion: nil)
//                    }
//            }
            else if addressTF.text?.count == 0{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Enter Address"
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "पता दर्ज करें"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "ঠিকানা লিখুন"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "చిరునామా నమోదు చేయండి"
                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
//            else if self.selectedCityID == -1{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//
//                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                    vc!.descriptionInfo = "Select City"
//                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                     vc!.descriptionInfo = "शहर चुनें"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                    vc!.descriptionInfo = "শহর নির্বাচন করুন"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                    vc!.descriptionInfo = "సిటీని ఎంచుకోండి"
//                  }
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }else if self.selectedAreaID == -1{
//                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
//                vc!.delegate = self
//                vc!.titleInfo = ""
//
//                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
//                    vc!.descriptionInfo = "Select Area"
//                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
//                     vc!.descriptionInfo = "क्षेत्र का चयन करें"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
//                    vc!.descriptionInfo = "এলাকা নির্বাচন করুন"
//                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
//                    vc!.descriptionInfo = "ప్రాంతాన్ని ఎంచుకోండి"
//                  }
//                vc!.modalPresentationStyle = .overCurrentContext
//                vc!.modalTransitionStyle = .crossDissolve
//                self.present(vc!, animated: true, completion: nil)
//            }
            else{

                generateApiCalling()
            }
            
            
           
        } else {
            if generateE_warranty.currentTitle == "Download E-Warranty" || generateE_warranty.currentTitle == "ई-वारंटी डाउनलोड करें" || generateE_warranty.currentTitle == "ই-ওয়ারেন্টি ডাউনলোড করুন" || generateE_warranty.currentTitle == "ఇ-వారెంటీని డౌన్‌లోడ్ చేయండి"{
                downloadEWarrantyApiCall()
            }
        }
    }
    
    //Delegate: -
    
    func didSelectedItem(_ vc: DropDownVC) {
        if vc.isComeFrom == 2{
            self.cityButton.setTitle(vc.selectedTitle, for: .normal)
            self.cityButton.setTitleColor(.black, for: .normal)
            self.selectedCityID = Int(vc.selectedId) ?? -1
        
            self.selectedCityName = vc.selectedTitle
            print(self.selectedCityID, "Selected City")
            
        }else if vc.isComeFrom == 4{
            self.areaButton.setTitle(vc.selectedTitle, for: .normal)
            self.areaButton.setTitleColor(.black, for: .normal)
            self.selectedAreaID = Int(vc.selectedId) ?? -1
            self.selectedAreaName = vc.selectedTitle
            print(self.selectedAreaID, "Selected Area")
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
    
    
    //Api :-
    
    func generateApiCalling() {
        let parameters = [

                "ActionType": 0,
                "ActorId": userID,
                "Address": "\(self.addressTF.text ?? "")",
                "AreaId": selectedAreaID,
                "CityId": selectedCityID,
                "CustomerName": "\(self.nameTF.text ?? "")",
                "EmailId": "\(self.emailTF.text ?? "")",
                "lstEWarranty": [
                    [
                        "AreaName": "\(self.areaDetails)",
                        "BrandId": brandId,
                        "EWarrantyQty": eWarrantyQty,
                        "ProductId": productId
                    ]
                ],
                "MobileNum": "\(self.mobileNumberTF.text ?? "")"
        ] as [String: Any]
        
        
        print(parameters)
        self.vm.generateWarrantyDetails(parameters: parameters) { response in
            print(response?.returnValue ?? 0, "ReturnValue")
            DispatchQueue.main.async {
                self.stopLoading()
          
            if response?.returnValue == 1 {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
                vc!.itsComeFrom = "DownloadEWarranty"
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "E-Warranty details saved successfully."
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "ई-वारंटी विवरण सफलतापूर्वक सहेजा गया।"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "ই-ওয়ারেন্টির বিবরণ সফলভাবে সংরক্ষিত হয়েছে।"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "E-వారెంటీ వివరాలు విజయవంతంగా సేవ్ చేయబడ్డాయి."
                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
                self.nameTF.isEnabled = false
                self.mobileNumberTF.isEnabled = false
                self.emailTF.isEnabled = false
                self.addressTF.isEnabled = false
                self.cityButton.isEnabled = false
                self.areaButton.isEnabled = false
                self.ewarrantyID = response?.lstEWarranty?[0].eWarrantyID ?? 0
                self.productId = response?.lstEWarranty?[0].productId ?? 0

                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    self.generateE_warranty.setTitle("Download E-Warranty", for: .normal)
                    
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                    self.generateE_warranty.setTitle("ई-वारंटी डाउनलोड करें", for: .normal)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    self.generateE_warranty.setTitle("ই-ওয়ারেন্টি ডাউনলোড করুন", for: .normal)
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    self.generateE_warranty.setTitle("ఇ-వారెంటీని డౌన్‌లోడ్ చేయండి", for: .normal)
                }
                
            } else {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                vc!.delegate = self
                vc!.titleInfo = ""
               
                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                    vc!.descriptionInfo = "Something went wrong please try again later."
                 }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                     vc!.descriptionInfo = "कुछ गलत हुआ कृपया बाद में पुन: प्रयास करें।"
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                    vc!.descriptionInfo = "কিছু ভুল হয়েছে। পরে আবার চেষ্টা করুন."
                    
                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                    vc!.descriptionInfo = "ఏదో తప్పు జరిగినది. దయచేసి కాసేపు ఆగక ప్రయత్నించండి."
                  }
                vc!.modalPresentationStyle = .overCurrentContext
                vc!.modalTransitionStyle = .crossDissolve
                self.present(vc!, animated: true, completion: nil)
            }
            }
        }
    }
    func e_warrantyAPICall() {
        let parameters = ["ActionType":2,"CustomerID": userID]
        self.vm.e_warrantyListAPi(parameters: parameters) { response in
            DispatchQueue.main.async {
                self.stopLoading()
            }
        }
    }
    
    func downloadEWarrantyApiCall(){
        let parameters = [
            "ActionType": "1",
            "EWarrantyId": "\(self.ewarrantyID)",
            "ProductId": "\(self.productId)"
        ] as [String: Any]
        print(parameters)
        self.vm.downloadEwarranty(parameters: parameters) { response in
         
            let warrantyDetails = response?.base64Image ?? ""
            print(warrantyDetails, "Reponse")
            DispatchQueue.main.async {
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
      let compSepByCharInSet = string.components(separatedBy: aSet)
      let numberFiltered = compSepByCharInSet.joined(separator: "")

      if string == numberFiltered {
        let currentText = mobileNumberTF.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 10
      } else {
        return false
      }
    }
    func isValidPhone(testStr:String) -> Bool {
        let phoneRegEx = "^[6-9]\\d{9}$"
        let phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneNumber.evaluate(with: testStr)
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
