//
//  ScannerViewModel.swift
//  Sharon Secure
//
//  Created by Arokia IT on 9/9/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import Foundation
import AVFoundation
import Firebase


class ScannerViewModel: PopUpDelegate{
    func popUpAlertDidTap(_ vc: PopUp2ViewController) {}

    weak var vc : CP_Scanner_VC?
    var codeGenuineResponse = CodeGenuineModels()
    var tempStoreCodesArray = [GenuineCodeSaveModels]()
    var GenuineCodesArray = [GenuineCodeSaveModels]()
    var validStoreCodesArray = [GenuineCodeSaveModels]()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? "-1"
    var message = ""
    var message2 = ""
    var checkMessage = ""
    
    func codeGenuineAPI(code:String){
        self.vc!.startLoading()
        fromURL.almofireSOAPRequestForCodeGenuine(methodName: methodName.codeGenuine_METHODNAME, SCRATCH_CODE: code, ActorId: userID) { (result, error) in
            if result == nil{
                DispatchQueue.main.async{
                    self.vc!.stopLoading()
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                    vc!.delegate = self
                    vc!.titleInfo = ""
                    vc!.itsFrom = ""
                    vc!.descriptionInfo = "No Internet. Please check your Internet Connection"
                    vc!.modalPresentationStyle = .overCurrentContext
                    vc!.modalTransitionStyle = .crossDissolve
                    self.vc!.present(vc!, animated: true, completion: nil)
                }

            }else{
                if error == ""{
                    self.codeGenuineResponse = (result as? CodeGenuineModels)!
                    print(self.codeGenuineResponse.ReturnMessage ?? "")
                    self.vc!.stopLoading()
                    if self.codeGenuineResponse.ReturnMessage ?? "" != nil && self.codeGenuineResponse.ReturnMessage ?? "" != "" {
                        let unsplitedresponse = self.codeGenuineResponse.ReturnMessage ?? ""
                        let splittedArray = unsplitedresponse.split(separator: "~")
                        print(splittedArray[0])
                        if splittedArray[0] == "1"{
                            self.vc!.productname.text = self.codeGenuineResponse.ProductName ?? ""
                            self.vc!.plantName.text = self.codeGenuineResponse.PlantName ?? ""
                            self.vc!.thickness.text = self.codeGenuineResponse.Thickness ?? ""
                            self.vc!.size.text = self.codeGenuineResponse.Size ?? ""
                            self.vc!.uniqueCode.text = self.codeGenuineResponse.ScratchCode ?? ""
                            if self.codeGenuineResponse.PrintDate ?? "" != "" && self.codeGenuineResponse.PrintDate ?? "" != nil && self.codeGenuineResponse.PrintDate ?? "" != "-"{
                                self.vc!.dateofMfg.text = self.dateformatterFunc(stringDate: self.codeGenuineResponse.PrintDate ?? "01/01/0001 00:00:00")
                            }else{
                                self.vc!.dateofMfg.text = "-"
                            }
                            self.vc!.statusLabel.text = "Sharon Ply Genuine Product"
                            print(self.codeGenuineResponse.ProductId)
                            self.appendDatatoListing(data: self.codeGenuineResponse, StatusID: String(splittedArray[0]), scratchcode: code)
                            self.appendGenuineSendDatatoListing(data: self.codeGenuineResponse, StatusID:  String(splittedArray[0]))
                            if self.validStoreCodesArray.count == 0{
                                
                                self.vc!.generateEwarranty.isHidden = true
                                self.vc!.generateEWarrantyBottom.isHidden = true
                            }else{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                    
                                }else{
                                    self.vc!.generateEwarranty.isHidden = false
                                    self.vc!.generateEWarrantyBottom.isHidden = false
                                }
                                
                            }
                            self.vc!.codetableView.reloadData()
                            if self.tempStoreCodesArray.count == 0{
                                self.vc!.codeDetails.isHidden = true
                            }else{
                                self.vc!.codeDetails.isHidden = false
                            }
                            if self.vc!.selectedindex == 1{
                                self.vc!.isscannedOnce = true
//                                self.vc!.session.startRunning()
                            }else{
                                self.vc!.isscannedOnce = true
                                self.vc!.captureSession.stopRunning()
                            }
                            
                        }else if splittedArray[0] == "4"{
                            var list3 = [GenuineCodeSaveModels]()
                            list3 = self.tempStoreCodesArray.filter{ ($0.ScratchCode == "\(code)") }
                            print(list3.count)
                            if list3.count ==  0 {
//                                self.vc?.alertmsg(msg: "\(splittedArray[1])", title: "")
                                self.vc?.alertWithAction(title: "", message: "\(splittedArray[1])")
                            }
                            self.appendDatatoListing(data: self.codeGenuineResponse, StatusID: String(splittedArray[0]), scratchcode: code)
                            self.appendGenuineSendDatatoListing(data: self.codeGenuineResponse, StatusID:  String(splittedArray[0]))
                            if self.validStoreCodesArray.count == 0{
                                self.vc!.generateEwarranty.isHidden = false
                                self.vc!.generateEWarrantyBottom.isHidden = true
                            }else{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                    
                                }else{
                                    self.vc!.generateEwarranty.isHidden = false
                                    self.vc!.generateEWarrantyBottom.isHidden = false
                                }
                            }
                            self.vc!.codetableView.reloadData()
                            if self.tempStoreCodesArray.count == 0{
                                self.vc!.codeDetails.isHidden = true
                            }else{
                                self.vc!.codeDetails.isHidden = false
                            }
                            
                            self.vc!.shadowView.isHidden = true
                            if self.vc!.selectedindex == 1{
                                self.vc!.isscannedOnce = true
//                                self.vc!.session.startRunning()
                            }else{
                                self.vc!.isscannedOnce = true
                                self.vc!.captureSession.stopRunning()
                            }
                            
                        }else if splittedArray[0] == "-2"{
                            var list3 = [GenuineCodeSaveModels]()
                            self.checkMessage = String(splittedArray[1])
                            if splittedArray[1] == "Kindly check download menu for the e-warranty" {
                                list3 = self.tempStoreCodesArray.filter{ ($0.ScratchCode == "\(code)") }
                                if list3.count ==  0 {
                                    self.vc?.alertWithAction(title: "", message: "\(splittedArray[1])")
//                                    self.vc!.alertmsg(msg: "\(splittedArray[1])", title: "")
                                }
                            } else {
                                list3 = self.tempStoreCodesArray.filter{ ($0.ScratchCode == "\(code)") }
                                if list3.count ==  0 {
                                    self.vc?.alertWithAction(title: "", message: "\(splittedArray[1]) " + "\(self.codeGenuineResponse.membername ?? "")")
//                                    self.vc?.alertmsg(msg: "\(splittedArray[1]) " + "\(self.codeGenuineResponse.membername ?? "")", title: "")
                                }
                            }
                            
                            self.vc!.productname.text = self.codeGenuineResponse.ProductName ?? ""
                            self.vc!.plantName.text = self.codeGenuineResponse.PlantName ?? ""
                            self.vc!.thickness.text = self.codeGenuineResponse.Thickness ?? ""
                            self.vc!.size.text = self.codeGenuineResponse.Size ?? ""
                            if self.codeGenuineResponse.PrintDate ?? "" != "" && self.codeGenuineResponse.PrintDate ?? "" != nil && self.codeGenuineResponse.PrintDate ?? "" != "-"{
                                self.vc!.dateofMfg.text = self.dateformatterFunc(stringDate: self.codeGenuineResponse.PrintDate ?? "01/01/0001 00:00:00")
                            }else{
                                self.vc!.dateofMfg.text = "-"
                            }
                            self.vc!.uniqueCode.text = self.codeGenuineResponse.ScratchCode ?? ""
                            self.appendDatatoListing(data: self.codeGenuineResponse, StatusID: String(splittedArray[0]), scratchcode: code)
                            
                            if self.validStoreCodesArray.count == 0{
                                
                                self.vc!.generateEwarranty.isHidden = true
                                self.vc!.generateEWarrantyBottom.isHidden = true
                                
                            }else{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                    
                                }else{
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = false
                                }
                                
                            }
                            
                            self.vc!.codetableView.reloadData()
                            if self.tempStoreCodesArray.count == 0{
                                self.vc!.codeDetails.isHidden = true
                            }else{
                                self.vc!.codeDetails.isHidden = false
                            }
                            if self.vc!.selectedindex == 1{
                                self.vc!.isscannedOnce = true
//                                self.vc!.session.startRunning()
                            }else{
                                self.vc!.isscannedOnce = true
                                self.vc!.captureSession.stopRunning()
                            }
                        }else if splittedArray[0] == "3"{
                            var list3 = [GenuineCodeSaveModels]()
                            list3 = self.tempStoreCodesArray.filter{ ($0.ScratchCode == "\(code)") }
                            print(list3.count)
                            if list3.count ==  0 {
                                self.vc?.alertWithAction(title: "", message: "\(splittedArray[1])")
//                                self.vc?.alertmsg(msg: "\(splittedArray[1])", title: "")
                            }
                            
                            self.appendDatatoListing(data: self.codeGenuineResponse, StatusID: String(splittedArray[0]), scratchcode: code)
                            self.vc!.statusLabel.text = "\(splittedArray[1])"
                            self.message = "\(splittedArray[1])"
                            
                            if self.validStoreCodesArray.count == 0{
                                self.vc!.generateEwarranty.isHidden = true
                                self.vc!.generateEWarrantyBottom.isHidden = true
                            }else{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                    
                                }else{
                                    self.vc!.generateEwarranty.isHidden = false
                                    self.vc!.generateEWarrantyBottom.isHidden = false
                                }
                                
                            }
                            
                            self.vc!.codetableView.reloadData()
                            if self.tempStoreCodesArray.count == 0{
                                self.vc!.codeDetails.isHidden = true
                            }else{
                                self.vc!.codeDetails.isHidden = false
                            }
                            
                            
                            self.vc!.shadowView.isHidden = true
                            if self.vc!.selectedindex == 1{
                                self.vc!.isscannedOnce = true
//                                self.vc!.session.startRunning()
                            }else{
                                self.vc!.isscannedOnce = true
                                self.vc!.captureSession.stopRunning()
                            }
                        }else if splittedArray[0] == "5"{
                            var list3 = [GenuineCodeSaveModels]()
                            list3 = self.tempStoreCodesArray.filter{ ($0.ScratchCode == "\(code)") }
                            print(list3.count)
                            if list3.count ==  0 {
                                self.vc?.alertWithAction(title: "", message: "\(splittedArray[1])")
//                                self.vc?.alertmsg(msg: "\(splittedArray[1])", title: "")
                            }
                            self.appendDatatoListing(data: self.codeGenuineResponse, StatusID: String(splittedArray[0]), scratchcode: code)
                            self.vc!.statusLabel.text = "\(splittedArray[1])"
                            self.message2 = "\(splittedArray[1])"
                            
                            
                            if self.validStoreCodesArray.count == 0{
                                
                                self.vc!.generateEwarranty.isHidden = true
                                self.vc!.generateEWarrantyBottom.isHidden = true
                                
                            }else{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                    
                                }else{
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = false
                                }
                            
                            }
                            
                            self.vc!.codetableView.reloadData()
                            if self.tempStoreCodesArray.count == 0{
                                self.vc!.codeDetails.isHidden = true
                                }else{
                                self.vc!.codeDetails.isHidden = false
                            }
                            
                            
                            self.vc!.shadowView.isHidden = true
                            if self.vc!.selectedindex == 1{
                                self.vc!.isscannedOnce = true
//                                self.vc!.session.startRunning()
                            }else{
                                self.vc!.isscannedOnce = true
                                self.vc!.captureSession.stopRunning()
                            }
                        }else if splittedArray[0] == "6"{
                            //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7" {
                            if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                            if self.vc!.selectedindex == 1 {
                                    
                                    DispatchQueue.main.async{
                                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                        vc!.delegate = self
                                        vc!.titleInfo = ""
                                        vc!.itsFrom = "MaxLimit"
                                        vc!.descriptionInfo = "Maximum scanning limit reached"
                                        vc!.modalPresentationStyle = .overCurrentContext
                                        vc!.modalTransitionStyle = .crossDissolve
                                        self.vc!.present(vc!, animated: true, completion: nil)
                                    }
                                    
                                } else if self.vc!.selectedindex == 2 {
                                    
                                    DispatchQueue.main.async{
                                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                        vc!.delegate = self
                                        vc!.titleInfo = ""
                                        vc!.itsFrom = "MaxUploadLimit"
                                        vc!.descriptionInfo = "Maximum uploading limit reached"
                                        vc!.modalPresentationStyle = .overCurrentContext
                                        vc!.modalTransitionStyle = .crossDissolve
                                        self.vc!.present(vc!, animated: true, completion: nil)
                                    }
                                }
                            }
                            
                        }else if splittedArray[0] == "-3"{
                            self.appendDatatoListing(data: self.codeGenuineResponse, StatusID: String(splittedArray[0]), scratchcode: code)
                            self.vc!.statusLabel.text = "You are not entitled to this product"
                            
                            if self.validStoreCodesArray.count == 0{
                                
                                self.vc!.generateEwarranty.isHidden = true
                                self.vc!.generateEWarrantyBottom.isHidden = true
                                
                            }else{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                    
                                }else{
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = false
                                }
                                
                            }
                            
                            self.vc!.codetableView.reloadData()
                            if self.tempStoreCodesArray.count == 0{
                                self.vc!.codeDetails.isHidden = true
                            }else{
                                self.vc!.codeDetails.isHidden = false
                            }
                            
                            
                            self.vc!.shadowView.isHidden = true
                            if self.vc!.selectedindex == 1{
                                self.vc!.isscannedOnce = true
                                self.vc!.captureSession.startRunning()
                            }else{
                                self.vc!.isscannedOnce = true
                                self.vc!.captureSession.stopRunning()
                            }
                        }else{
                            self.appendDatatoListing(data: self.codeGenuineResponse, StatusID: String(splittedArray[0]), scratchcode: code)
                            self.vc!.statusLabel.text = "Not a Sharon Ply Genuine Product"
                            print(self.validStoreCodesArray.count, "Valid Store Codes")
                            if self.validStoreCodesArray.count == 0{
                                
                                self.vc!.generateEwarranty.isHidden = true
                                self.vc!.generateEWarrantyBottom.isHidden = true
                                
                            }else{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                    
                                }else{
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = false
                                }
                                
                            }
                            
                            self.vc!.codetableView.reloadData()
                            if self.tempStoreCodesArray.count == 0{
                                self.vc!.codeDetails.isHidden = true
                            }else{
                                self.vc!.codeDetails.isHidden = false
                            }
                            
                            
                            self.vc!.shadowView.isHidden = true
                            if self.vc!.selectedindex == 1{
                                self.vc!.isscannedOnce = true
                                self.vc!.captureSession.startRunning()
                            }else{
                                self.vc!.isscannedOnce = true
                                self.vc!.captureSession.stopRunning()
                            }
                        }
                    }else{
                        DispatchQueue.main.async{
                            self.vc!.stopLoading()
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                            vc!.delegate = self
                            vc!.titleInfo = ""
                            vc!.itsFrom = ""
                            vc!.descriptionInfo = "Not a Sharon Ply Genuine Product"
                            vc!.modalPresentationStyle = .overCurrentContext
                            vc!.modalTransitionStyle = .crossDissolve
                            self.vc!.present(vc!, animated: true, completion: nil)
                        }
                        
                        
                        self.vc!.shadowView.isHidden = true
                        if self.vc!.selectedindex == 1{
                            self.vc!.isscannedOnce = true
                            self.vc!.captureSession.startRunning()
                        }else{
                            self.vc!.isscannedOnce = true
                            self.vc!.captureSession.stopRunning()
                        }
                    }
                    self.vc?.codeTF.text = ""
                    self.vc?.codeTF.resignFirstResponder()
                }else{
                    print(error?.description ?? "")
                    self.vc!.stopLoading()
                }
            }
        }
    }
    
    func appendDatatoListing(data:CodeGenuineModels, StatusID:String, scratchcode:String){
        if self.tempStoreCodesArray.count == 0{
            self.tempStoreCodesArray.insert(GenuineCodeSaveModels(ReturnMessage: data.ReturnMessage ?? "", ProductName: data.ProductName ?? "", ProductId: data.ProductId ?? "", PrintDate: data.PrintDate ?? "", ScratchCode: scratchcode, Size: data.Size ?? "", Thickness: data.Thickness ?? "", PlantName: data.PlantName ?? "", PlantCode: data.PlantCode ?? "", codeCount: 1, brandID: data.brandID ?? "", StatusID: StatusID, Membername: data.membername ?? ""), at: 0)
            
            if StatusID == "-1"{
                self.vc!.shadowView.isHidden = true
            }else if StatusID == "4"{
                self.vc!.shadowView.isHidden = true
            }else if StatusID == "-2"{
                self.vc!.shadowView.isHidden = true
            }else if StatusID == "3"{
                self.vc!.shadowView.isHidden = true
            }else if StatusID == "5"{
                self.vc!.shadowView.isHidden = true
            }else if StatusID == "1"{
                self.vc!.shadowView.isHidden = false
            }else{
                self.vc!.shadowView.isHidden = true
            }
        }else{
            let filterdArray = self.tempStoreCodesArray.filter { $0.ScratchCode == scratchcode}
            print(data.membername ?? "")
            if filterdArray.count == 0{
                
                self.tempStoreCodesArray.insert(GenuineCodeSaveModels(ReturnMessage: data.ReturnMessage ?? "", ProductName: data.ProductName ?? "", ProductId: data.ProductId ?? "", PrintDate: data.PrintDate ?? "", ScratchCode: scratchcode, Size: data.Size ?? "", Thickness: data.Thickness ?? "", PlantName: data.PlantName ?? "", PlantCode: data.PlantCode ?? "", codeCount: 1, brandID: data.brandID ?? "", StatusID: StatusID, Membername: data.membername ?? ""), at: 0)
                if StatusID == "-1"{
                    self.vc!.shadowView.isHidden = true
                }else if StatusID == "4"{
                    self.vc!.shadowView.isHidden = true
                }else if StatusID == "-2"{
                    self.vc!.shadowView.isHidden = true
                }else if StatusID == "3"{
                    self.vc!.shadowView.isHidden = true
                }else if StatusID == "5"{
                    self.vc!.shadowView.isHidden = true
                }else if StatusID == "1"{
                    self.vc!.shadowView.isHidden = false
                }else{
                    self.vc!.shadowView.isHidden = true
                }
            }else{
                
                if self.vc!.selectedindex == 1{
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "Code is already scanned"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.vc!.present(vc!, animated: true, completion: nil)
                    }
                    self.vc!.isscannedOnce = true
                    self.vc!.captureSession.startRunning()
                    self.vc!.shadowView.isHidden = true
                    
                } else if self.vc!.selectedindex == 2 {
                    DispatchQueue.main.async{
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                        vc!.delegate = self
                        vc!.titleInfo = ""
                        vc!.descriptionInfo = "Code is already uploaded"
                        vc!.modalPresentationStyle = .overCurrentContext
                        vc!.modalTransitionStyle = .crossDissolve
                        self.vc!.present(vc!, animated: true, completion: nil)
                    }
                    self.vc!.isscannedOnce = true
                    self.vc!.captureSession.startRunning()
                    self.vc!.shadowView.isHidden = true
                    
                }
                
            }
            
        }
        print("temp codes: \(self.tempStoreCodesArray.count)")
    }
    func dateformatterFunc(stringDate:String) -> String{
        let splitteddatestring = stringDate.split(separator: " ")
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yyyy"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        let date: NSDate? = dateFormatterGet.date(from: String(splitteddatestring[0])) as NSDate?
        return dateFormatterPrint.string(from: date! as Date)
    }
    func appendGenuineSendDatatoListing(data:CodeGenuineModels, StatusID:String){
        
        if self.validStoreCodesArray.count == 0{
            
            self.validStoreCodesArray.append(GenuineCodeSaveModels(ReturnMessage: data.ReturnMessage ?? "", ProductName: data.ProductName ?? "", ProductId: data.ProductId ?? "", PrintDate: data.PrintDate ?? "", ScratchCode: data.ScratchCode ?? "", Size: data.Size ?? "", Thickness: data.Thickness ?? "", PlantName: data.PlantName ?? "", PlantCode: data.PlantCode ?? "", codeCount: 1, brandID: data.brandID ?? "", StatusID: StatusID, Membername: data.membername ?? ""))
        }else{
            let filterdArray = self.validStoreCodesArray.filter { $0.ProductId == data.ProductId ?? ""}
            if filterdArray.count == 0{
                self.validStoreCodesArray.append(GenuineCodeSaveModels(ReturnMessage: data.ReturnMessage ?? "", ProductName: data.ProductName ?? "", ProductId: data.ProductId ?? "", PrintDate: data.PrintDate ?? "", ScratchCode: data.ScratchCode ?? "", Size: data.Size ?? "", Thickness: data.Thickness ?? "", PlantName: data.PlantName ?? "", PlantCode: data.PlantCode ?? "", codeCount: 1, brandID: data.brandID ?? "", StatusID: StatusID, Membername: data.membername ?? ""))
            }else{
                for code in filterdArray{
                    if code.ScratchCode == data.ScratchCode ?? ""{
                        print("Scratch code already present")
                    }else{
                        
                        self.validStoreCodesArray.filter({$0.ProductId == data.ProductId}).first?.codeCount = (self.validStoreCodesArray.filter({$0.ProductId == data.ProductId}).first?.codeCount)! + 1
                    }
                }
            }
            
        }
        let filterdArray = self.GenuineCodesArray.filter { $0.ScratchCode == data.ScratchCode ?? ""}
        if filterdArray.count == 0 {
            self.GenuineCodesArray.append(GenuineCodeSaveModels(ReturnMessage: data.ReturnMessage ?? "", ProductName: data.ProductName ?? "", ProductId: data.ProductId ?? "", PrintDate: data.PrintDate ?? "", ScratchCode: data.ScratchCode ?? "", Size: data.Size ?? "", Thickness: data.Thickness ?? "", PlantName: data.PlantName ?? "", PlantCode: data.PlantCode ?? "", codeCount: 1, brandID: data.brandID ?? "", StatusID: StatusID, Membername: data.membername ?? ""))
        }
        print("valid codes: \(self.validStoreCodesArray.count)")
    }
}
