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
    func popUpAlertDidTap2(_ vc: PopUp2ViewController) {}
    var requestAPIs = RestAPI_Requests()
    weak var vc : CP_Scanner_VC?
    var codeGenuineResponse : EWarrentyScannerModel?
    var tempStoreCodesArray = [QrUsegereport1]()
    var GenuineCodesArray = [QrUsegereport1]()
    var validStoreCodesArray = [QrUsegereport1]()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? "-1"
    var message = ""
    var message2 = ""
    var checkMessage = ""
    
    func codeGenuineAPI(code:String,parameter: JSON){
        self.vc!.startLoading()
//        ewarrentyScanCodeValidation
        requestAPIs.ewarrentyScanCodeValidation(parameters: parameter) { (result, error) in
//            if result == nil{
//                DispatchQueue.main.async{
//                    self.vc!.stopLoading()
//                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
//                    vc!.delegate = self
//                    vc!.titleInfo = ""
//                    vc!.itsFrom = ""
//                    vc!.descriptionInfo = "No Internet. Please check your Internet Connection"
//                    vc!.modalPresentationStyle = .overCurrentContext
//                    vc!.modalTransitionStyle = .crossDissolve
//                    self.vc!.present(vc!, animated: true, completion: nil)
//                }
//
//            }else{
                if error == nil{
                    guard result != nil else{
                        DispatchQueue.main.async {
                            self.vc?.stopLoading()
                        }
                        return
                        
                    }
                    self.codeGenuineResponse = result!
                    print(self.codeGenuineResponse?.returnMessage ?? "")
                    
                    DispatchQueue.main.async {
                        self.vc?.stopLoading()
                    }
                    if self.codeGenuineResponse?.returnMessage ?? "" != nil && self.codeGenuineResponse?.returnMessage ?? "" != "" {
                        let unsplitedresponse = self.codeGenuineResponse?.returnMessage ?? ""
                        let splittedArray = unsplitedresponse.split(separator: "~")
                        print(splittedArray[0])
                        if splittedArray[0] == "1"{
                           DispatchQueue.main.async {
                                self.vc!.productname.text = self.codeGenuineResponse?.qrUsegereport?[0].productName ?? ""
                                self.vc!.plantName.text = self.codeGenuineResponse?.plantName ?? ""
                                self.vc!.thickness.text = self.codeGenuineResponse?.qrUsegereport?[0].thickness ?? ""
                                self.vc!.size.text = self.codeGenuineResponse?.qrUsegereport?[0].size ?? ""
                                self.vc!.uniqueCode.text = self.codeGenuineResponse?.qrUsegereport?[0].scratchCode ?? ""
                                if self.codeGenuineResponse?.qrUsegereport?[0].printDate ?? "" != "" && self.codeGenuineResponse?.qrUsegereport?[0].printDate ?? "" != nil && self.codeGenuineResponse?.qrUsegereport?[0].printDate ?? "" != "-"{
                                    self.vc!.dateofMfg.text = self.codeGenuineResponse?.qrUsegereport?[0].printDate ?? "01/01/0001 00:00:00"// self.dateformatterFunc(stringDate: self.codeGenuineResponse?.qrUsegereport?[0].printDate ?? "01/01/0001 00:00:00")
                                }else{
                                    self.vc!.dateofMfg.text = "-"
                                }
                                self.vc!.statusLabel.text = "Sharon Ply Genuine Product"
                                print(self.codeGenuineResponse?.qrUsegereport?[0].productId)
                                self.appendDatatoListing(data: self.codeGenuineResponse!, StatusID: String(splittedArray[0]), scratchcode: code)
                                self.appendGenuineSendDatatoListing(data: self.codeGenuineResponse!, StatusID:  String(splittedArray[0]))
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

                            }

                        }else if splittedArray[0] == "4"{
                            var list3 = [QrUsegereport1]()
                            list3 = self.tempStoreCodesArray.filter{ ($0.scratchCode == "\(code)") }
                            print(list3.count)
                            if list3.count ==  0 {
//                                self.vc?.alertmsg(msg: "\(splittedArray[1])", title: "")
                                self.vc?.alertWithAction(title: "", message: "\(splittedArray[1])")
                            }
                            self.appendDatatoListing(data: self.codeGenuineResponse!, StatusID: String(splittedArray[0]), scratchcode: code)
                            self.appendGenuineSendDatatoListing(data: self.codeGenuineResponse!, StatusID:  String(splittedArray[0]))
                            if self.validStoreCodesArray.count == 0{
                                DispatchQueue.main.async {
                                    self.vc!.generateEwarranty.isHidden = false
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                }
                            }else{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                    DispatchQueue.main.async {
                                        self.vc!.generateEwarranty.isHidden = true
                                            self.vc!.generateEWarrantyBottom.isHidden = true
                                    }
                           
                                    
                                }else{
                                    DispatchQueue.main.async {
                                        self.vc!.generateEwarranty.isHidden = false
                                        self.vc!.generateEWarrantyBottom.isHidden = false
                                    }
                                    
                                }
                            }
                            DispatchQueue.main.async {
                                self.vc!.codetableView.reloadData()
                            }
                           
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
                                DispatchQueue.main.async {
                                    self.vc?.captureSession.stopRunning()
                                }

                            }

                        }else if splittedArray[0] == "-2"{
                            var list3 = [QrUsegereport1]()
                            self.checkMessage = String(splittedArray[1])
                            if splittedArray[1] == "Kindly check download menu for the e-warranty" {
                                list3 = self.tempStoreCodesArray.filter{ ($0.scratchCode == "\(code)") }
                                if list3.count ==  0 {
                                    self.vc?.alertWithAction(title: "", message: "\(splittedArray[1])")
//                                    self.vc!.alertmsg(msg: "\(splittedArray[1])", title: "")
                                }
                            } else {
                                list3 = self.tempStoreCodesArray.filter{ ($0.scratchCode == "\(code)") }
                                if list3.count ==  0 {
                                    self.vc?.alertWithAction(title: "", message: "\(splittedArray[1]) " + "\(self.codeGenuineResponse?.qrUsegereport?[0].memberName ?? "")")
//                                    self.vc?.alertmsg(msg: "\(splittedArray[1]) " + "\(self.codeGenuineResponse.membername ?? "")", title: "")
                                }
                            }

                            DispatchQueue.main.async {
                                self.vc!.productname.text = self.codeGenuineResponse?.qrUsegereport?[0].productName ?? ""
                                self.vc!.plantName.text = self.codeGenuineResponse?.plantName ?? ""
                                self.vc!.thickness.text = self.codeGenuineResponse?.qrUsegereport?[0].thickness ?? ""
                                self.vc!.size.text = self.codeGenuineResponse?.qrUsegereport?[0].size ?? ""
                                if self.codeGenuineResponse?.qrUsegereport?[0].printDate ?? "" != "" && self.codeGenuineResponse?.qrUsegereport?[0].printDate ?? "" != nil && self.codeGenuineResponse?.qrUsegereport?[0].printDate ?? "" != "-"{
                                    self.vc!.dateofMfg.text = self.codeGenuineResponse?.qrUsegereport?[0].printDate ?? "01/01/0001 00:00:00" //self.dateformatterFunc(stringDate: self.codeGenuineResponse?.qrUsegereport?[0].printDate ?? "01/01/0001 00:00:00")
                                }else{
                                    self.vc!.dateofMfg.text = "-"
                                }
                                self.vc!.uniqueCode.text = self.codeGenuineResponse?.qrUsegereport?[0].scratchCode ?? ""
                                self.appendDatatoListing(data: self.codeGenuineResponse!, StatusID: String(splittedArray[0]), scratchcode: code)
                            }
                            

                            if self.validStoreCodesArray.count == 0{
                                DispatchQueue.main.async {
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                }
                               

                            }else{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                    
                                    DispatchQueue.main.async {
                                        self.vc!.generateEwarranty.isHidden = true
                                            self.vc!.generateEWarrantyBottom.isHidden = true
                                    }
                                    
                                

                                }else{
                                    DispatchQueue.main.async {
                                        self.vc!.generateEwarranty.isHidden = true
                                        self.vc!.generateEWarrantyBottom.isHidden = false
                                    }
                                    
                                    
                                    
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
                                DispatchQueue.main.async {
                                    self.vc?.captureSession.stopRunning()

                                }
                            }
                        }else if splittedArray[0] == "3"{
                            var list3 = [QrUsegereport1]()
                            list3 = self.tempStoreCodesArray.filter{ ($0.scratchCode == "\(code)") }
                            print(list3.count)
                            if list3.count ==  0 {
                                self.vc?.alertWithAction(title: "", message: "\(splittedArray[1])")
//                                self.vc?.alertmsg(msg: "\(splittedArray[1])", title: "")
                            }

                            self.appendDatatoListing(data: self.codeGenuineResponse!, StatusID: String(splittedArray[0]), scratchcode: code)
                            DispatchQueue.main.async {
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
                            }
                            DispatchQueue.main.async {
                                self.vc!.shadowView.isHidden = true
                            }
                           
                            if self.vc!.selectedindex == 1{
                                self.vc!.isscannedOnce = true
//                                self.vc!.session.startRunning()
                            }else{
                                self.vc!.isscannedOnce = true
                                DispatchQueue.main.async {
                                    self.vc?.captureSession.stopRunning()
                                }
                            }
                        }else if splittedArray[0] == "5"{
                            var list3 = [QrUsegereport1]()
                            list3 = self.tempStoreCodesArray.filter{ ($0.scratchCode == "\(code)") }
                            print(list3.count)
                            if list3.count ==  0 {
                                self.vc?.alertWithAction(title: "", message: "\(splittedArray[1])")
//                                self.vc?.alertmsg(msg: "\(splittedArray[1])", title: "")
                            }
                            self.appendDatatoListing(data: self.codeGenuineResponse!, StatusID: String(splittedArray[0]), scratchcode: code)
                            self.vc!.statusLabel.text = "\(splittedArray[1])"
                            self.message2 = "\(splittedArray[1])"


                            if self.validStoreCodesArray.count == 0{
                                DispatchQueue.main.async {
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true

                                }
                            }else{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                    DispatchQueue.main.async {
                                        self.vc!.generateEwarranty.isHidden = true
                                            self.vc!.generateEWarrantyBottom.isHidden = true
                                    }
                               

                                }else{
                                    DispatchQueue.main.async {
                                        self.vc!.generateEwarranty.isHidden = true
                                        self.vc!.generateEWarrantyBottom.isHidden = false
                                    }
                                    
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
                                DispatchQueue.main.async {
                                    self.vc!.captureSession.stopRunning()
                                }
                                
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
                            self.appendDatatoListing(data: self.codeGenuineResponse!, StatusID: String(splittedArray[0]), scratchcode: code)
                            self.vc!.statusLabel.text = "You are not entitled to this product"

                            if self.validStoreCodesArray.count == 0{
                                DispatchQueue.main.async {
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                }
                                
                                

                            }else{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                    DispatchQueue.main.async {
                                        self.vc!.generateEwarranty.isHidden = true
                                        self.vc!.generateEWarrantyBottom.isHidden = true
                                    }
                                    

                                }else{
                                    DispatchQueue.main.async {
                                        self.vc!.generateEwarranty.isHidden = true
                                        self.vc!.generateEWarrantyBottom.isHidden = false
                                    }
                                    
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
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                                    self.vc!.captureSession.startRunning()
                                })
                               
                            }else{
                                self.vc!.isscannedOnce = true
                                DispatchQueue.main.async {
                                    self.vc!.captureSession.stopRunning()
                                }
                            }
                        }else if splittedArray[0] == "-1"{
                            DispatchQueue.main.async{
                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopUp2ViewController") as? PopUp2ViewController
                                vc!.delegate = self
                                vc!.titleInfo = ""
                                vc!.descriptionInfo = "Please enter the valid code"
                                vc!.modalPresentationStyle = .overCurrentContext
                                vc!.modalTransitionStyle = .crossDissolve
                                self.vc!.present(vc!, animated: true, completion: nil)
                            }
                        }else{
                            self.appendDatatoListing(data: self.codeGenuineResponse!, StatusID: String(splittedArray[0]), scratchcode: code)
                            DispatchQueue.main.async {
                                self.vc!.statusLabel.text = "Not a Sharon Ply Genuine Product"
                            }
                            print(self.validStoreCodesArray.count, "Valid Store Codes")
                            if self.validStoreCodesArray.count == 0{
                                DispatchQueue.main.async {
                                    self.vc!.generateEwarranty.isHidden = true
                                    self.vc!.generateEWarrantyBottom.isHidden = true
                                }
                                

                            }else{
                                if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5"{
                                //if UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "5" || UserDefaults.standard.string(forKey: "CUSTTYPE") ?? "-1" == "7"{
                                    DispatchQueue.main.async {
                                        self.vc!.generateEwarranty.isHidden = true
                                        self.vc!.generateEWarrantyBottom.isHidden = true

                                    }
                                    
                                }else{
                                    DispatchQueue.main.async {
                                        self.vc!.generateEwarranty.isHidden = true
                                        self.vc!.generateEWarrantyBottom.isHidden = false
                                    }
                                    
                                    
                                }

                            }
                            DispatchQueue.main.async {
                                self.vc!.codetableView.reloadData()
                            }
                            
                            if self.tempStoreCodesArray.count == 0{
                                self.vc!.codeDetails.isHidden = true
                            }else{
                                self.vc!.codeDetails.isHidden = false
                            }


                            self.vc!.shadowView.isHidden = true
                            if self.vc!.selectedindex == 1{
                                self.vc!.isscannedOnce = true
                                DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                                    self.vc!.captureSession.startRunning()
                                })
                                
                            }else{
                                self.vc!.isscannedOnce = true
                                DispatchQueue.main.async {
                                    self.vc!.captureSession.stopRunning()
                                }
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
                            DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                                self.vc!.captureSession.startRunning()
                            })
                        }else{
                            self.vc!.isscannedOnce = true
                            DispatchQueue.main.async {
                                self.vc!.captureSession.stopRunning()
                            }
                            
                        }
                    }
                    DispatchQueue.main.async {
                        self.vc?.codeTF.text = ""
                        self.vc?.codeTF.resignFirstResponder()
                    }
                }else{
                    print(error?.localizedDescription ?? "")
                    DispatchQueue.main.async {
                        self.vc!.stopLoading()
                    }
                }
//            }
        }
    }
    
    func appendDatatoListing(data:EWarrentyScannerModel, StatusID:String, scratchcode:String){
        if self.tempStoreCodesArray.count == 0{

            guard data.qrUsegereport?.count != 0 else{
                print("qrcode data is empty-4")
                return
            }
            var genuineData : QrUsegereport1 = (data.qrUsegereport?[0])!
            genuineData.scratchCode = scratchcode
            genuineData.codeStatusWiseCount = 1
            genuineData.status = StatusID
            self.tempStoreCodesArray.insert(genuineData, at: 0)
            
            
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
            let filterdArray = self.tempStoreCodesArray.filter { $0.scratchCode == scratchcode}
            print(data.qrUsegereport?[0].memberName ?? "")
            if filterdArray.count == 0{
                guard data.qrUsegereport?.count != 0 else{
                    print("qrcode data is empty-3")
                    return
                }
                var genuineData : QrUsegereport1 = (data.qrUsegereport?[0])!
                genuineData.scratchCode = scratchcode
                genuineData.codeStatusWiseCount = 1
                genuineData.status = StatusID
                self.tempStoreCodesArray.insert(genuineData, at: 0)
                
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
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                        self.vc!.captureSession.startRunning()
                    })
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
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {
                        self.vc!.captureSession.startRunning()
                    })
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
    func appendGenuineSendDatatoListing(data:EWarrentyScannerModel, StatusID:String){
        
        if self.validStoreCodesArray.count == 0{

        
            guard data.qrUsegereport?.count != 0 else{
                print("qrcode data is empty-2")
                return
            }
            var genuineData : QrUsegereport1 = (data.qrUsegereport?[0])!
        genuineData.codeStatusWiseCount = 1
        genuineData.status = StatusID
        self.validStoreCodesArray.insert(genuineData, at: 0)
        
        
        }else{
            let filterdArray = self.validStoreCodesArray.filter { $0.productId == data.qrUsegereport?[0].productId}
            if filterdArray.count == 0{
                guard data.qrUsegereport?.count != 0 else{
                    print("qrcode data is empty- 1")
                    return
                }
                var genuineData : QrUsegereport1 = (data.qrUsegereport?[0])!
                genuineData.codeStatusWiseCount = 1
                genuineData.status = StatusID
                self.validStoreCodesArray.insert(genuineData, at: 0)
            }else{
                for code in filterdArray{
                    if code.scratchCode == data.qrUsegereport?[0].scratchCode ?? ""{
                        print("Scratch code already present")
                    }else{
                        for data1 in self.validStoreCodesArray.enumerated(){
                            if data1.element.productId == data.qrUsegereport?[0].productId{
                                self.validStoreCodesArray[data1.offset].codeStatusWiseCount! += 1
                            }
                        }
                    }
                }
            }
            
        }
        let filterdArray = self.GenuineCodesArray.filter { $0.scratchCode == data.qrUsegereport?[0].scratchCode ?? ""}
        if filterdArray.count == 0 {
            guard data.qrUsegereport?.count != 0 else{
                print("qrcode data is empty")
                return
            }
            var genuineData : QrUsegereport1 = (data.qrUsegereport?[0])!
            genuineData.codeStatusWiseCount = 1
            genuineData.status = StatusID
            self.GenuineCodesArray.insert(genuineData, at: 0)
            
        }
        print("valid codes: \(self.validStoreCodesArray.count)")
    }
}
