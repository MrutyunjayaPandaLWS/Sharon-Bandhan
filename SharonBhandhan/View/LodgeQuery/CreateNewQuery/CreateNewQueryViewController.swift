//
//  CreateNewQueryViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Photos
import AVFoundation
import SDWebImage
import CoreData
import Firebase

class CreateNewQueryViewController: BaseViewController , UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, popUpDelegate{
    func popupAlertDidTap(_ vc: PopupAlertOne_VC) {}
    
    
       @IBOutlet weak var querydetails: UILabel!
       @IBOutlet weak var querysummarylabel: UILabel!
       @IBOutlet weak var selectyourtopiclabel: UILabel!
       @IBOutlet weak var pleasesubmityourqueryusingthisform: UILabel!
      
       @IBOutlet weak var ldgequery: UILabel!
       @IBOutlet weak var topview: UIView!
     
       @IBOutlet weak var ProfileImageView: UIImageView!
      

       @IBOutlet weak var browseimage: UIButton!
       @IBOutlet weak var textviewforquerysummary: UITextView!
       @IBOutlet weak var tableviewtopics: UITableView!
       @IBOutlet weak var titleview: UIView!
       @IBOutlet weak var tableandcancelbtn: UIView!
       @IBOutlet weak var submitbtn: UIButton!
       @IBOutlet weak var buttonTodisplayTitleslabel: UIButton!
       @IBOutlet weak var topicnamelabel: UILabel!
       @IBOutlet weak var titledisplaylabel: UILabel!
       @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
       @IBOutlet weak var querysummarytf: UITextView!
    
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectionButton: UIButton!
    var sendScannedCodes:Array = [SendUploadedCodes]()
    var helptopicid = ""
        var strdata1 = ""
        var isFrom = 0
        var helptopicname:String = ""
        var isComeFrom = ""
        var codeData = [String]()
        var storyboard1 = UIStoryboard(name: "Main", bundle: nil)
        let VM = CreateNewQueryViewModel()
        var topicsarray = [ObjHelpTopicList]()
        var uploadedCodes:Array = [UploadedCodes]()
        var topicselectedID:String = ""
        let picker = UIImagePickerController()
        let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    
        let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
        var querySummaryDetails = ""
        var selectedCodesArray = [String]()
       override func viewDidLoad() {
           super.viewDidLoad()
           print("Its From",isFrom)
           languagelocalization()
           mainViewHeightConstraint.constant = 459
           imageHeightConstraint.constant = 0
           
           picker.delegate = self
           self.imageHeightConstraint.constant = 0
           cancelbutton.layer.shadowColor = UIColor.black.cgColor
           cancelbutton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
           cancelbutton.layer.shadowOpacity = 0.2
           cancelbutton.layer.shadowRadius = 0.0
           cancelbutton.layer.masksToBounds = false
           cancelbutton.layer.cornerRadius = 18.0
//           querysummarytf.setLeftPaddingPoints(8)
           tableviewtopics.delegate = self
           tableviewtopics.dataSource = self
           tableandcancelbtn.isHidden = true
           self.selectionButton.isHidden = false
           helpTopicListApi()
//           self.querysummarytf.delegate = self as! UITextFieldDelegate
           self.textviewforquerysummary.delegate = self as! UITextViewDelegate
           
           NotificationCenter.default.addObserver(self, selector: #selector(querySubmissions), name: Notification.Name.querySubmission, object: nil)
           if self.isFrom == 2{
               fetchDetails()
               self.querysummarytf.isEditable = true
               self.querysummarytf.isUserInteractionEnabled = true
           }else if self.isFrom == 3{
               self.querysummarytf.isEditable = true
               self.querysummarytf.isUserInteractionEnabled = true
           }else if self.isFrom == 10{
               self.querySummaryDetails = ""
               self.querysummarytf.isUserInteractionEnabled = true
               self.querysummarytf.isEditable = false
               for code in self.selectedCodesArray{
                   self.querySummaryDetails = self.querySummaryDetails + "\(code)"
               }
               print(self.selectedCodesArray.count, "Selected Codes Array count")
               var str2 = self.querySummaryDetails
               str2.insert(separator: ", ", every: 12)
               print(str2)
               self.querysummarytf.text = String(str2)

           }

       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Create New Query")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    func fetchDetails(){
        
        let fetchRequest:NSFetchRequest<SendUploadedCodes> = SendUploadedCodes.fetchRequest()
        do{
            self.sendScannedCodes = try persistanceservice.context.fetch(fetchRequest)
            print(self.sendScannedCodes.count, "Count")
            for code in self.sendScannedCodes{
                print(code.code ?? "", "Codes")
                self.querySummaryDetails = self.querySummaryDetails + "\(code.code!)"
            }
            var str2 = self.querySummaryDetails
            str2.insert(separator: ", ", every: 12)
            print(str2)
//            self.querysummarytf.text = String(str2)
        }catch{
            print("error while fetching data")
        }
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.ldgequery.text = "Add Lodge Query"
            self.pleasesubmityourqueryusingthisform.text = "Please submit your query using this form"
            self.selectyourtopiclabel.text = "Select Your Topic"
            self.querysummarylabel.text = "Query Summary"
            self.querydetails.text = "Query Details"
            self.browseimage.setTitle("Browse Image", for: .normal)
            self.submitbtn.setTitle("Submit Query", for: .normal)
            self.cancelbutton.setTitle("Cancel", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.ldgequery.text = "लॉज पूछताछ जोड़ें"
            self.pleasesubmityourqueryusingthisform.text = "कृपया इस फॉर्म का उपयोग करके अपना प्रश्न सबमिट करें"
            self.selectyourtopiclabel.text = "अपना विषय चुनें"
            self.querysummarylabel.text = "प्रश्न सारांश"
            self.querydetails.text = "क्वेरी विवरण"
            self.browseimage.setTitle("छवि ब्राउज़ करें", for: .normal)
            self.submitbtn.setTitle("क्वेरी सबमिट करें", for: .normal)
            self.cancelbutton.setTitle("रद्द करना", for: .normal)
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.ldgequery.text = "লজ কোয়েরি যোগ করুন"
            self.pleasesubmityourqueryusingthisform.text = "এই ফর্ম ব্যবহার করে আপনার ক্যোয়ারী জমা দিন"
            self.selectyourtopiclabel.text = "আপনার বিষয় নির্বাচন করুন"
            self.querysummarylabel.text = "প্রশ্নের সারাংশ"
            self.querydetails.text = "ক্যোয়ারী বিবরণ"
            self.browseimage.setTitle("ইমেজ ব্রাউজ করুন", for: .normal)
            self.submitbtn.setTitle("ক্যোয়ারী জমা দিন", for: .normal)
            self.cancelbutton.setTitle("বাতিল করুন", for: .normal)
        }else{
            self.ldgequery.text = "లాడ్జ్ క్వెరీని జోడించండి"
            self.pleasesubmityourqueryusingthisform.text = "దయచేసి ఈ ఫారమ్‌ని ఉపయోగించి మీ ప్రశ్నను సమర్పించండి"
            self.selectyourtopiclabel.text = "మీ అంశాన్ని ఎంచుకోండి"
            self.querysummarylabel.text = "ప్రశ్న సంగ్రహము"
            self.querydetails.text = "క్వెరీ వివరాలు"
            self.browseimage.setTitle("చిత్రాన్ని బ్రౌజ్ చేయండి", for: .normal)
            self.submitbtn.setTitle("క్వెరీని సమర్పించండి", for: .normal)
            self.cancelbutton.setTitle("రద్దు చేయి", for: .normal)
        }
    }
    @objc func querySubmissions(){
        if self.isFrom == 3{
            self.navigationController?.popViewController(animated: true)

        }else if self.isFrom == 2{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .goToParticularVc, object: nil)
            }
        }else if self.isFrom == 21{
            self.dismiss(animated: true){
                NotificationCenter.default.post(name: .comeBackStatus, object: nil)
            }
            
        }else{
            NotificationCenter.default.post(name: .comeBackStatus, object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        
    }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
        
    
    
       @IBAction func uploadPhotoButton(_ sender: UIButton) {
           let alert = UIAlertController(title: "Choose any option", message: "", preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "Camera", style: .default , handler:{ (UIAlertAction)in
               self.openCamera()
           }))
           alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler:{ (UIAlertAction)in
               self.openGallery()
           }))
           alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
           }))
           self.present(alert, animated: true, completion: {
               print("completion block")
           })
       }

        func openGallery() {
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    DispatchQueue.main.async {
                        self.picker.allowsEditing = false
                        self.picker.sourceType = .savedPhotosAlbum
                        self.picker.mediaTypes = ["public.image"]
                        self.present(self.picker, animated: true, completion: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        let alertVC = UIAlertController(title: "Need Gallary access", message: "Allow Gallery access", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            DispatchQueue.main.async {
                                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                            }
                        }
                        let cancelAction = UIAlertAction(title: "DisAllow", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in

                        }
                        alertVC.addAction(okAction)
                        alertVC.addAction(cancelAction)
                        self.present(alertVC, animated: true, completion: nil)

                    }
                }
            })
        }

        func openCamera(){
            DispatchQueue.main.async {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                        if response {
                            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                                DispatchQueue.main.async {

                                    self.picker.allowsEditing = false
                                    self.picker.sourceType = .camera
                                    self.picker.mediaTypes = ["public.image"]
                                    self.present(self.picker,animated: true,completion: nil)
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                let alertVC = UIAlertController(title: "NeedCameraAccess", message: "Allow", preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                                    UIAlertAction in
                                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    UIAlertAction in
                                }
                                alertVC.addAction(okAction)
                                alertVC.addAction(cancelAction)
                                self.present(alertVC, animated: true, completion: nil)

                            }
                        }
                    }} else {
                        DispatchQueue.main.async {
                            self.noCamera()
                        }
                    }
            }

        }


        func opencamera() {
            DispatchQueue.main.async {
                if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                    DispatchQueue.main.async {
                        self.picker.allowsEditing = false
                        self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: self.picker.sourceType)!
                        self.picker.sourceType = UIImagePickerController.SourceType.camera
                        self.picker.cameraCaptureMode = .photo
                        self.present(self.picker,animated: true,completion: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        let alertVC = UIAlertController(title: "HRJohnsonneedtoaccesscameraGallery", message: "", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Allow", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        }
                        let cancelAction = UIAlertAction(title: "Disallow", style: UIAlertAction.Style.cancel) {
                            UIAlertAction in
                        }
                        alertVC.addAction(okAction)
                        alertVC.addAction(cancelAction)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                }
            }
        }
        func noCamera(){
            let alertVC = UIAlertController(title: "No Camera", message: "Sorrnodevice", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style:.default, handler: nil)
            alertVC.addAction(okAction)
            present(alertVC, animated: true, completion: nil)
        }
        //MARK: - UIImagePickerControllerDelegate
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            DispatchQueue.main.async { [self] in
                guard let selectedImage = info[.originalImage] as? UIImage else {
                    return
                }
                let imageData = selectedImage.resized(withPercentage: 0.1)
                let imageData1: NSData = imageData!.pngData()! as NSData
                self.ProfileImageView.image = selectedImage
                self.imageHeightConstraint.constant = 180
                mainViewHeightConstraint.constant = 659
                self.strdata1 = imageData1.base64EncodedString(options: .lineLength64Characters)
                picker.dismiss(animated: true, completion: nil)
//                self.dismiss(animated: true, completion: nil)
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
       
     
       func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return topicsarray.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "customerqueryTableViewCell", for: indexPath) as! customerqueryTableViewCell
           cell.selectionStyle = .none
           cell.topicslabel.text = self.topicsarray[indexPath.row].helpTopicName ?? ""
           return cell
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           topicnamelabel.text = "  \(topicsarray[indexPath.row].helpTopicName ?? "")"
           helptopicid  = "\(topicsarray[indexPath.row].helpTopicId ?? 0)"
           print(helptopicid)
           tableandcancelbtn.isHidden = true
           self.selectionButton.isHidden = false
           
           
       }
       @IBAction func backbtn(_ sender: UIButton) {
           if self.isFrom == 3{
//               self.dismiss(animated: true){
//                   NotificationCenter.default.post(name: .fromCodeStatus, object: nil)
//               }
               self.navigationController?.popViewController(animated: true)
           } else if self.isFrom == 2{
               self.dismiss(animated: true){
                   NotificationCenter.default.post(name: .goToParticularVc, object: nil)
               }
           }else if self.isFrom == 21{
               self.dismiss(animated: true, completion:  nil)
           }else{
               self.navigationController?.popViewController(animated: true)
           }
           
           }
       
       @IBOutlet weak var cancelbutton: UIButton!
       @IBAction func buttonselecttopic(_ sender: UIButton) {
           self.tableandcancelbtn.isHidden = false
           self.selectionButton.isHidden = true
           self.tableviewtopics.isHidden = false
           
       }
       @IBAction func cancelbtn(_ sender: UIButton) {
           tableandcancelbtn.isHidden = true
           self.selectionButton.isHidden = false
           self.tableviewtopics.isHidden = true
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
       }
       
       @IBAction func submitbtn(_ sender: UIButton) {
           
           if topicnamelabel.text == "  Select Topic"{
               DispatchQueue.main.async{
                   let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                   vc!.delegate = self
                   vc!.titleInfo = ""
                  
                   if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                       vc!.descriptionInfo = "Select a Query Topic"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                        vc!.descriptionInfo = "एक प्रश्न विषय का चयन करें"
                   }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                       vc!.descriptionInfo = "একটি ক্যোয়ারী বিষয় নির্বাচন করুন"
                   }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                       vc!.descriptionInfo = "ప్రశ్న అంశాన్ని ఎంచుకోండి"
                     }
                   vc!.modalPresentationStyle = .overFullScreen
                   vc!.modalTransitionStyle = .crossDissolve
                   self.present(vc!, animated: true, completion: nil)
               }

           }else if querysummarytf.text == ""{
               DispatchQueue.main.async{
                   let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                   vc!.delegate = self
                   vc!.titleInfo = ""
                  
                   if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                       vc!.descriptionInfo = "Query summary is Empty"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                        vc!.descriptionInfo = "क्वेरी सारांश खाली है"
                   }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                       vc!.descriptionInfo = "প্রশ্নের সারাংশ খালি"
                   }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                       vc!.descriptionInfo = "ప్రశ్న సారాంశం ఖాళీగా ఉంది"
                     }
                   vc!.modalPresentationStyle = .overFullScreen
                   vc!.modalTransitionStyle = .crossDissolve
                   self.present(vc!, animated: true, completion: nil)
               }

           }else if textviewforquerysummary.text == ""{
               
               DispatchQueue.main.async{
                   let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                   vc!.delegate = self
                   vc!.titleInfo = ""
                   
                   if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                       vc!.descriptionInfo = "Query Details is empty"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                        vc!.descriptionInfo = "क्वेरी विवरण खाली है"
                   }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                       vc!.descriptionInfo = "ক্যোয়ারী বিবরণ খালি আছে"
                   }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                       vc!.descriptionInfo = "ప్రశ్న వివరాలు ఖాళీగా ఉన్నాయి"
                     }
                   vc!.modalPresentationStyle = .overFullScreen
                   vc!.modalTransitionStyle = .crossDissolve
                   self.present(vc!, animated: true, completion: nil)
               }
           }else{
               self.startLoading()
                   DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                       self.newQuerySubmissionApi()
                   }
               )       
           }
           
       }
    
    func helpTopicListApi(){
        let parameters = [
            "objHelpTopicRetrieveRequest": [
                "ActionType": "4",
                "ActorId": "\(userID)",
                "IsActive": "true"
            ]
        ] as [String: Any]
        print(parameters)
        self.VM.helpTopicList(parameters: parameters) { response in
            self.topicsarray = response?.getHelpTopicsResult?.objHelpTopicList ?? []
            print(self.topicsarray.count)
            DispatchQueue.main.async {
                    self.tableviewtopics.isHidden = false
                    self.tableviewtopics.reloadData()
                self.stopLoading()
            
        }
        
    }
    }
    
    // submission Api
    
    func newQuerySubmissionApi(){
        
        let parameters = [
            "ActionType": "0",
            "ActorId": "\(userID)",
            "CustomerName": "null",
            "Email": "null",
            "HelpTopic": topicnamelabel.text ?? "",
            "HelpTopicID": "\(helptopicid)",
            "IsQueryFromMobile": "true",
            "LoyaltyID": "\(loyaltyId)",
            "QueryDetails": textviewforquerysummary.text ?? "",
            "QuerySummary": querysummarytf.text ?? "",
            "SourceType": "1",
            "ImageUrl": "\(self.strdata1)",
            "FileType": ""
        ] as [String: Any]
        print(parameters)
        self.VM.newQuerySubmission(parameters: parameters) { response in
        
            if response?.returnMessage ?? "" != "" || response?.returnMessage ?? nil != nil{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "QuerySubmission"
                    self.clearTable2()
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Query submitted successfully"
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "क्वेरी सफलतापूर्वक सबमिट की गई"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "প্রশ্ন সফলভাবে জমা দেওয়া হয়েছে"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "ప్రశ్న విజయవంతంగా సమర్పించబడింది"
                      }
                    vc!.modalPresentationStyle = .overFullScreen
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }else{
                DispatchQueue.main.async{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupAlertOne_VC") as? PopupAlertOne_VC
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsComeFrom = "QuerySubmission"
                    if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                        vc!.descriptionInfo = "Something went wrong please try again later."
                     }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                         vc!.descriptionInfo = "कुछ गलत हुआ कृपया बाद में पुन: प्रयास करें।"
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                        vc!.descriptionInfo = "কিছু ভুল হয়েছে। পরে আবার চেষ্টা করুন."
                        
                    }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "4"{
                        vc!.descriptionInfo = "ఏదో తప్పు జరిగినది. దయచేసి కాసేపు ఆగక ప్రయత్నించండి."
                      }
                    vc!.modalPresentationStyle = .overFullScreen
                    vc!.modalTransitionStyle = .crossDissolve
                    self.present(vc!, animated: true, completion: nil)
                }
            }
            
            
        }
    }
    
    func clearTable2(){
            
            let context = persistanceservice.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SendUploadedCodes")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
    
   }
extension StringProtocol where Self: RangeReplaceableCollection {

    mutating func insert<S: StringProtocol>(separator: S, every n: Int) {
        for index in indices.every(n: n).dropFirst().reversed() {
            insert(contentsOf: separator, at: index)
        }
    }

    func inserting<S: StringProtocol>(separator: S, every n: Int) -> Self {
        .init(unfoldSubSequences(limitedTo: n).joined(separator: separator))
    }
    
}
extension Collection {

    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence,Index> {
        sequence(state: startIndex) { start in
            guard start < endIndex else { return nil }
            let end = index(start, offsetBy: maxLength, limitedBy: endIndex) ?? endIndex
            defer { start = end }
            return self[start..<end]
        }
    }

    func every(n: Int) -> UnfoldSequence<Element,Index> {
        sequence(state: startIndex) { index in
            guard index < endIndex else { return nil }
            defer { formIndex(&index, offsetBy: n, limitedBy: endIndex) }
            return self[index]
        }
    }

    var pairs: [SubSequence] { .init(unfoldSubSequences(limitedTo: 2)) }
}
