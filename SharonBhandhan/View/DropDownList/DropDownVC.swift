//
//  DropDownVC.swift
//  CenturyPly_JSON
//
//  Created by ADMIN on 19/04/2022.
//

import UIKit
protocol SelectedItemDelegate {
    func didSelectedItem(_ vc: DropDownVC)
}
class DropDownVC: BaseViewController {
    
    @IBOutlet weak var dropDownTableView: UITableView!

    
    var delegate: SelectedItemDelegate!
    var selectedTitle = ""
    var selectedId = ""
    var statusArray = [String]()
    var isComeFrom = 0
    var selectedStateId = 0
    var selectedCountryId = 0
    var VM = DropDownModels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.dropDownTableView.delegate = self
        self.dropDownTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isComeFrom == 1{
            stateListing()
        }else if isComeFrom == 2{
            cityListing()
        } else if isComeFrom == 3 {
            allCityListing()
        } else if isComeFrom == 4 {
            areaListing()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
        {
            let touch = touches.first
            if touch?.view != self.dropDownTableView
            {
                self.dismiss(animated: true, completion: nil) }
        }
    
    func stateListing(){
        let parameters = [
                "ActionType": "2",
                "CountryID": "103",
                "IsActive": "true",
                "SortColumn": "STATE_NAME",
                "SortOrder": "ASC",
                "StartIndex": "1"
        ] as [String: Any]
        print(parameters)
        self.VM.stateList(parameters: parameters) { response in
            self.VM.stateArray = response?.stateList ?? []
            if self.VM.stateArray.count != 0{
                DispatchQueue.main.async{
                    self.dropDownTableView.isHidden = false
                    self.dropDownTableView.reloadData()
                    self.stopLoading()
                }
                
            }else{
                DispatchQueue.main.async{
                    self.dropDownTableView.isHidden = true
                    self.stopLoading()
                }
                
            }
        }
    }
    func cityListing(){
        
        let parameters = [
            "ActionType": "2",
               "IsActive": "true",
               "SortColumn": "CITY_NAME",
               "SortOrder": "ASC",
               "StartIndex": "1",
               "StateId": "\(selectedStateId)"
        ] as [String: Any]
        print(parameters)
        self.VM.cityList(parameters: parameters) { response in
            self.VM.cityArray = response?.cityList ?? []
            if self.VM.cityArray.count != 0{
                DispatchQueue.main.async{
                    self.dropDownTableView.isHidden = false
                    self.dropDownTableView.reloadData()
                    self.stopLoading()
                }
            }else{
                DispatchQueue.main.async{
                    self.dropDownTableView.isHidden = true
                    self.stopLoading()
                }
                
            }
        }
        
    }

    func allCityListing() {
        let parameters = [
            "ActionType":"18"
        ] as [String: Any]
        print(parameters)
        self.VM.cityList(parameters: parameters) { response in
            self.VM.cityArray = response?.cityList ?? []
            if self.VM.cityArray.count != 0{
                DispatchQueue.main.async{
                    self.dropDownTableView.isHidden = false
                    self.dropDownTableView.reloadData()
                    self.stopLoading()
                }
                
            }else{
                DispatchQueue.main.async{
                    self.dropDownTableView.isHidden = true
                    self.stopLoading()
                }
                
            }
        }
        
    }
    
    func areaListing() {
        let parameters = [
            "ActionType":1
        ] as [String: Any]
        print(parameters)
        self.VM.areaList(parameters: parameters) { response in
            self.VM.areaArray = response?.areaList ?? []
            if self.VM.areaArray.count != 0{
                DispatchQueue.main.async{
                    self.dropDownTableView.isHidden = false
                    self.dropDownTableView.reloadData()
                    self.stopLoading()
                }
                
            }else{
                DispatchQueue.main.async{
                    self.dropDownTableView.isHidden = true
                    self.stopLoading()
                }
                
            }
        }
        
    }

}

extension DropDownVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if isComeFrom == 1{
            return self.VM.stateArray.count
        }else if isComeFrom == 2{
            return self.VM.cityArray.count
        }else if isComeFrom == 4{
            return self.VM.areaArray.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTVC", for: indexPath) as! DropDownTVC
        cell.selectionStyle = .none
        if isComeFrom == 1{
            cell.selectedItem.text = self.VM.stateArray[indexPath.row].stateName ?? ""
        }else if isComeFrom == 2{
            cell.selectedItem.text = self.VM.cityArray[indexPath.row].cityName ?? ""
        }else if isComeFrom == 4{
            cell.selectedItem.text = self.VM.areaArray[indexPath.row].areaName ?? ""
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if isComeFrom == 1{
            self.selectedTitle = self.VM.stateArray[indexPath.row].stateName ?? ""
            self.selectedId = "\(self.VM.stateArray[indexPath.row].stateId ?? 0)"
        }else if isComeFrom == 2{
            self.selectedTitle = self.VM.cityArray[indexPath.row].cityName ?? ""
            self.selectedId = "\(self.VM.cityArray[indexPath.row].cityId ?? 0)"
        }else if isComeFrom == 4{
            self.selectedTitle = self.VM.areaArray[indexPath.row].areaName ?? ""
            self.selectedId = "\(self.VM.areaArray[indexPath.row].areaId ?? 0)"
        }
        self.delegate.didSelectedItem(self)
        self.dismiss(animated: true, completion: nil)
       
    }
    
    
}
