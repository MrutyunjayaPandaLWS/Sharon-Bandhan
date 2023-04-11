//
//  CodeSummary_VC.swift
//  centuryDemo
//
//  Created by Arokia-M3 on 16/03/22.
//

import UIKit
import Firebase

class CodeSummary_VC: BaseViewController {

    @IBOutlet var codeSummaryLabel: UILabel!
    @IBOutlet var codeSummaryTableView: UITableView!
    let loyaltyId = UserDefaults.standard.string(forKey: "LoyaltyID") ?? ""
    var vm = CodeSummaryViewModel()
    var codeSummaryListingArray = [QrUsegereport]()
    var codeTitleListingArray = ["","","",""]
    var itsFrom = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm.VC = self
        self.codeSummaryTableView.delegate = self
        self.codeSummaryTableView.dataSource = self
        self.apiCalling()
        languagelocalization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Code Summery")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])

        
    }
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
            self.codeSummaryLabel.text = "Code Summary"

        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
            self.codeSummaryLabel.text = "कोड सारांश"
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
            self.codeSummaryLabel.text = "কোড সারাংশ"
        }else{
            self.codeSummaryLabel.text = "కోడ్ సారాంశం"
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        if itsFrom == 1{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        }
        
    
    func apiCalling() {
        let parameters = ["ActionType":211,"MemberID":"\(loyaltyId)","QrCodeStatusID":-1] as [String : Any]
        self.vm.codeSummaryListingAPI(parameters: parameters) { response in
            self.codeSummaryListingArray = response?.qrUsegereport ?? []
            DispatchQueue.main.async {
                self.codeSummaryTableView.reloadData()
                self.stopLoading()
            }
        }
    }
    
}

extension CodeSummary_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.codeSummaryListingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodeSummary_TVC") as! CodeSummary_TVC
        cell.codeCount.text = String(self.codeSummaryListingArray[indexPath.row].codeStatusWiseCount ?? 0)
        cell.codesTitleName.text = self.codeSummaryListingArray[indexPath.row].status ?? ""
        return cell
    }
}
