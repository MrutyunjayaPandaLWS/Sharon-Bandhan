//
//  PancardViewModel.swift
//  CenturyPly_JSON
//
//  Created by admin on 26/10/22.
//

import UIKit
import SDWebImage

class PancardViewModel{
    
    
    weak var VC: PancardViewController?
    var requestAPIs = RestAPI_Requests()
    var resultData:PanModels?
    
    func pancarddetailsApi(parameters: JSON){
        self.VC?.startLoading()
        self.requestAPIs.getpaneApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        if result?.lstPanDetails![0].result ?? "-1" == "1"{
                            
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                               // self.headerTitle.text = "PanVerification".localizableString(loc: "en")
                                self.VC?.dobLabel.text = "Date of Birth: \( result?.lstPanDetails![0].dOB ?? "")"
                                self.VC?.nameofPerson.text = "Person Name : \(result?.lstPanDetails![0].panName ?? "")"
                                self.VC?.pannumber.text = "Pan Number : \(result?.lstPanDetails![0].panId ?? "")"
                                
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                              //  self.headerTitle.text = "PanVerification".localizableString(loc: "hi")
                                self.VC?.dobLabel.text = "जन्म की तारीख : \(result?.lstPanDetails![0].dOB ?? "")"
                                self.VC?.nameofPerson.text = "व्यक्ति का नाम : \(result?.lstPanDetails![0].panName ?? "")"
                                self.VC?.pannumber.text = "पैन नंबर : \(result?.lstPanDetails![0].panId ?? "")"
                                
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                             //   self.headerTitle.text = "PanVerification".localizableString(loc: "ta-IN")
                                self.VC?.dobLabel.text = "பிறந்த தேதி: \(result?.lstPanDetails![0].dOB ?? "")"
                                self.VC?.nameofPerson.text = "நபர் பெயர்: \(result?.lstPanDetails![0].panName ?? "")"
                                self.VC?.pannumber.text = "பான் எண்: \(result?.lstPanDetails![0].panId ?? "")"
                            }else{
                                
                           //     self.headerTitle.text = "PanVerification".localizableString(loc: "te")
                                self.VC?.dobLabel.text = "పుట్టిన తేది : \(result?.lstPanDetails![0].dOB ?? "")"
                                self.VC?.nameofPerson.text = "వ్యక్తి పేరు : \(result?.lstPanDetails![0].panName ?? "")"
                                self.VC?.pannumber.text = "పాన్ నంబర్ : \(result?.lstPanDetails![0].panId ?? "")"
                            }
                            
                       
                        self.VC?.panNumberTF.text = "\(result?.lstPanDetails![0].panId ?? "")"

                        if result?.lstPanDetails![0].panImage ?? "" == ""{
                        //self.VC?.panImage.image = UIImage(named: "sample-pan-card")
                            print(result?.lstPanDetails?[0].panImage,"dsjhbj")
                            self.VC?.imagePanCons.constant = 0
                        }else{
                            print(result?.lstPanDetails?[0].panImage,"dsjhbj")
                            let x = (result?.lstPanDetails![0].panImage ?? "").split(separator: "~")
                            if x.count != 0{
                            let totalImgURL = PROMO_IMG + (x[0])
                            self.VC?.panImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "sample-pan-card"))
                            }
                        }
                        print(result?.lstPanDetails![0].isVerified ?? "-1")
                        if result?.lstPanDetails![0].isVerified ?? "-1" == "0"{
                            self.VC?.SuccessshadowView.isHidden = false
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "en")
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "hi")
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "ta-IN")
                            }else{
                                self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "te")
                            }
                            self.VC?.panImage.isHidden = true
                            self.VC?.dobLabel.isHidden = true
                            
                            self.VC?.nameofPerson.isHidden = false
                            self.VC?.panattachmet.isHidden = false
                            self.VC?.panattachment.isHidden = false
                            self.VC?.pannumber.isHidden = false
                            self.VC?.validateButtonn.isHidden = false
                            self.VC?.saveButton.isHidden = false
                            self.VC?.borderview.isHidden = false
                            self.VC?.validateButtonn.isEnabled = false
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "en"), for: .normal)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "hi"), for: .normal)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "ta-IN"), for: .normal)
                            }else{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "te"), for: .normal)
                            }
                        }else if result?.lstPanDetails![0].isVerified ?? "-1" == "1"{
                            self.VC?.SuccessshadowView.isHidden = false
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                self.VC?.successmeassage.text = "customerPANVerified".localizableString(loc: "en")
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                self.VC?.successmeassage.text = "customerPANVerified".localizableString(loc: "hi")
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                self.VC?.successmeassage.text = "customerPANVerified".localizableString(loc: "ta-IN")
                            }else{
                                self.VC?.successmeassage.text = "customerPANVerified".localizableString(loc: "te")
                            }
                            self.VC?.panImage.isHidden = true
                            self.VC?.dobLabel.isHidden = true
                            self.VC?.nameofPerson.isHidden = false
                            self.VC?.panattachmet.isHidden = false
                            self.VC?.panattachment.isHidden = false
                            self.VC?.pannumber.isHidden = false
                            self.VC?.validateButtonn.isHidden = false
                            self.VC?.saveButton.isHidden = false
                            self.VC?.borderview.isHidden = false
                            self.VC?.validateButtonn.isEnabled = false
                        }else if result?.lstPanDetails![0].isVerified ?? "-1" == "3"{
                            
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "en"), for: .normal)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "hi"), for: .normal)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "ta-IN"), for: .normal)
                            }else{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "te"), for: .normal)
                            }
                            
                            self.VC?.panNumberTF.text = ""
                            self.VC?.dobLabel.isHidden = true
                            self.VC?.nameofPerson.isHidden = true
                            self.VC?.panattachmet.isHidden = true
                            self.VC?.panattachment.isHidden = true
                            self.VC?.pannumber.isHidden = true
                            self.VC?.validateButtonn.isHidden = false
                            self.VC?.panImage.isHidden = true
                            self.VC?.saveButton.isHidden = true
                            self.VC?.borderview.isHidden = true
                        }
                    }
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

        }
    }
    
    }
    
    func pancardVerifyApi(parameters: JSON){
        self.VC?.startLoading()
        self.requestAPIs.panVerifyApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        if result?.objPanDetailsRetrieverequest?.isPanValid ?? -1 == 1{
                       
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                self.VC?.dobLabel.text = "Date of Birth : \(result?.objPanDetailsRetrieverequest?.dateOfBirth ?? "")"
                                self.VC?.nameofPerson.text = "Person Name : \(result?.objPanDetailsRetrieverequest?.firstName ?? "") \(result?.objPanDetailsRetrieverequest?.lastName ?? "")"
                                self.VC?.pannumber.text = "Pan Number : \(result?.objPanDetailsRetrieverequest?.panNumber ?? "")"
                                
                                
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                self.VC?.dobLabel.text = "जन्म की तारीख : \(result?.objPanDetailsRetrieverequest?.dateOfBirth ?? "")"
                                self.VC?.nameofPerson.text = "व्यक्ति का नाम : \(result?.objPanDetailsRetrieverequest?.firstName ?? "") \(result?.objPanDetailsRetrieverequest?.lastName ?? "")"
                                self.VC?.pannumber.text = "पैन नंबर : \(result?.objPanDetailsRetrieverequest?.panNumber ?? "")"
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                self.VC?.dobLabel.text = "জন্ম তারিখ : \(result?.objPanDetailsRetrieverequest?.dateOfBirth ?? "")"
                                self.VC?.nameofPerson.text = "ব্যক্তির নাম : \(result?.objPanDetailsRetrieverequest?.firstName ?? "") \(result?.objPanDetailsRetrieverequest?.lastName ?? "")"
                                self.VC?.pannumber.text = "প্যান নম্বর : \(result?.objPanDetailsRetrieverequest?.panNumber ?? "")"
                            }else{
                                self.VC?.dobLabel.text = "పుట్టిన తేది : \(result?.objPanDetailsRetrieverequest?.dateOfBirth ?? "")"
                                self.VC?.nameofPerson.text = "వ్యక్తి పేరు : \(result?.objPanDetailsRetrieverequest?.firstName ?? "") \(result?.objPanDetailsRetrieverequest?.lastName ?? "")"
                                self.VC?.pannumber.text = "పాన్ నంబర్ : \(result?.objPanDetailsRetrieverequest?.panNumber ?? "")"
                                
                            }
                            
                            
                            
                            self.resultData = result
                            self.VC?.dobLabel.isHidden = true
                            self.VC?.nameofPerson.isHidden = false
                            self.VC?.panattachmet.isHidden = false
                            self.VC?.panattachment.isHidden = false
                            self.VC?.pannumber.isHidden = false
                            self.VC?.validateButtonn.isHidden = false
                            self.VC?.panImage.isHidden = false
                            self.VC?.saveButton.isHidden = false
                            self.VC?.borderview.isHidden = false
                            self.VC?.validateButtonn.isEnabled = false
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "en"), for: .normal)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "hi"), for: .normal)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "ta-IN"), for: .normal)
                            }else{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "te"), for: .normal)
                            }
                            self.VC?.validateButtonn.backgroundColor = UIColor.gray
                            if result?.objPanDetailsRetrieverequest?.panImage ?? "" == ""{
                            //self.VC?.panImage.image = UIImage(named: "sample-pan-card"
                                self.VC?.imagePanCons.constant = 0

                            }else{
                                let totalImgURL = productCatalogueImgURL + (result?.objPanDetailsRetrieverequest?.panImage ?? "")
                                self.VC?.panImage.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "sample-pan-card"))
                            }
                        }else {
                            
                            
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                self.VC?.alertTypeWithoutAction(alertheading: "", alertMessage: "validPanNum".localizableString(loc: "en"), buttonTitle: "rOKKEY".localizableString(loc: "en"))
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                self.VC?.alertTypeWithoutAction(alertheading: "", alertMessage: "validPanNum".localizableString(loc: "hi"), buttonTitle: "rOKKEY".localizableString(loc: "hi"))
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                self.VC?.alertTypeWithoutAction(alertheading: "", alertMessage: "validPanNum".localizableString(loc: "ta-IN"), buttonTitle: "rOKKEY".localizableString(loc: "ta-IN"))
                            }else{
                                self.VC?.alertTypeWithoutAction(alertheading: "", alertMessage: "validPanNum".localizableString(loc: "te"), buttonTitle: "rOKKEY".localizableString(loc: "te"))
                            }
                            
                            self.VC?.dobLabel.isHidden = true
                            self.VC?.nameofPerson.isHidden = true
                            self.VC?.panattachmet.isHidden = true
                            self.VC?.panattachment.isHidden = true
                            self.VC?.pannumber.isHidden = true
                            //self.VC?.validateButtonn.isHidden = true
                            self.VC?.panImage.isHidden = true
                            self.VC?.saveButton.isHidden = true
                            self.VC?.borderview.isHidden = true
                            self.VC?.panImage.image = UIImage(named: "sample-pan-card")
                            self.VC?.validateButtonn.isEnabled = true
                            if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "en"), for: .normal)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "hi"), for: .normal)
                            }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "ta-IN"), for: .normal)
                            }else{
                                self.VC?.validateButtonn.setTitle("verify".localizableString(loc: "te"), for: .normal)
                            }
                        }
                        print("No Response")
                        DispatchQueue.main.async {
                            self.VC?.stopLoading()
                        }
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

        }
    }
    
    }
    
    func pancardSaveApi(parameters: JSON){
        self.VC?.startLoading()
        print(parameters)
        self.requestAPIs.pansaveApi(parameters: parameters) { (result, error) in
            if error == nil{
                if result != nil {
                    DispatchQueue.main.async {
                        print(result?.returnMessage ?? "")
                        self.VC?.stopLoading()
                        let resultvalue = result?.returnMessage ?? ""
                        print(resultvalue,"Pan")
                        let splitted = resultvalue.split(separator: ":")
                        print(splitted.count)
                        
                        if splitted.count != 0{
                            if splitted[0] == "1"{
                                print("success")
                                self.VC?.SuccessshadowView.isHidden = false
                                //self.VC?.successmeassage.text = "Pancard saved successfully"
                                //self.VC?.successmeassage.text = "Customer PAN details have been submitted for verification!"
                                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                    self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "en")
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                    self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "hi")
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                    self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "ta-IN")
                                }else{
                                    self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "te")
                                }
                            }else if splitted[0] == "2"{
                                self.VC?.SuccessshadowView.isHidden = false
                                //self.VC?.successmeassage.text = "Customer PAN details have been verified!"
                                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                    self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "en")
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                    self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "hi")
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                    self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "ta-IN")
                                }else{
                                    self.VC?.successmeassage.text = "customerPANDetails".localizableString(loc: "te")
                                }
                            }else{
                                self.VC?.SuccessshadowView.isHidden = false
                                
                                if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
                                    self.VC?.successmeassage.text = "PanSaveFailed".localizableString(loc: "en")
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
                                    self.VC?.successmeassage.text = "PanSaveFailed".localizableString(loc: "hi")
                                }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
                                    self.VC?.successmeassage.text = "PanSaveFailed".localizableString(loc: "ta-IN")
                                }else{
                                    self.VC?.successmeassage.text = "PanSaveFailed".localizableString(loc: "te")
                                }
                            }
                        }
                        let parameterJSON = [
                            "ActorId":"\(self.VC?.userID ?? "")",
                               "ActionType":"4",
                            "LoyaltyId":"\(self.VC?.loyaltyId ?? "")"
                        ]
                        print(parameterJSON)
                        self.pancarddetailsApi(parameters: parameterJSON)
                    }
                } else {
                    print("No Response")
                    DispatchQueue.main.async {
                        self.VC?.stopLoading()
                        
                    }
                }
            }else{
                print("ERROR_Login \(error)")
                DispatchQueue.main.async {
                    self.VC?.stopLoading()
                }

        }
    }
    
    }

}
