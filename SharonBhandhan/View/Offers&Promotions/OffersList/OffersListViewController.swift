//
//  OffersListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Lottie
import SDWebImage
import Firebase

class OffersListViewController: BaseViewController, OffersandPromotionsDelegate{
    
    

    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var redemblePointTitleLbl: UILabel!
    @IBOutlet weak var animationLottieView: LottieAnimationView!
    @IBOutlet weak var offerstableView: UITableView!
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var noDataFound: UILabel!
    var fromSideMenu = ""
    var VM = OffersListViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID") ?? ""
    var pointBalance = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.VM.VC = self
        self.offerstableView.register(UINib(nibName: "OffersTableViewCell", bundle: nil), forCellReuseIdentifier: "OffersTableViewCell")
        offersandPromotionsApi()
        self.offerstableView.delegate = self
        self.offerstableView.dataSource = self
        self.noDataFound.isHidden = true
        self.offerstableView.separatorStyle = .none
        languagelocalization()
    //    self.lottieAnimation(animationView: animationLottieView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
//        tracker.set(kGAIScreenName, value: "Offers and Promotion")
//
//        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
//        tracker.send(builder.build() as [NSObject : AnyObject])
        pointsLbl.text = UserDefaults.standard.string(forKey: "RedeemablePointBalance") ?? "0"
        
    }
    
    func languagelocalization(){
        if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "1"{
          
            self.header.text = "Offers & Promotions"
            self.noDataFound.text = "No Data Found !!"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "2"{
          
            self.header.text = "ऑफ़र और प्रचार"
            self.noDataFound.text = "कोई डेटा नहीं मिला !!"
            
        }else if UserDefaults.standard.string(forKey: "LanguageLocalizable") == "3"{
          
            self.header.text = "অফার এবং প্রচার"
            self.noDataFound.text = "কোন ডেটা পাওয়া যায়নি!!"
            
        }else{
          
            self.header.text = "ఆఫర్‌లు & ప్రమోషన్‌లు"
            self.noDataFound.text = "డేటా కనుగొనబడలేదు !!"
        }
    }
    
//    func playAnimation(){
//        animationView = .init(name: "lf30_editor_jh47f7lt")
//        animationView!.frame = animationLottieView.bounds
//          // 3. Set animation content mode
//        animationView!.contentMode = .scaleAspectFit
//          // 4. Set animation loop mode
//        animationView!.loopMode = .loop
//          // 5. Adjust animation speed
//        animationView!.animationSpeed = 0.5
//        animationLottieView.addSubview(animationView!)
//          // 6. Play animation
//        animationView!.play()
//
//    }
//
  
    
    
 
    @IBAction func backBTN(_ sender: Any) {
        if self.fromSideMenu == "SideMenu"{
            NotificationCenter.default.post(name: .sideMenuClosing, object: nil)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //Delegate:-
    
    func offersDetails(_ cell: OffersTableViewCell) {
        guard let tappedIndexPath = offerstableView.indexPath(for: cell) else{return}
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OffersDetailsViewController") as! OffersDetailsViewController
        vc.offersImage = self.VM.offersandPromotionsArray[tappedIndexPath.row].proImage ?? ""
        vc.offerName = self.VM.offersandPromotionsArray[tappedIndexPath.row].promotionName ?? ""
        vc.shortDesc = self.VM.offersandPromotionsArray[tappedIndexPath.row].proShortDesc ?? ""
        vc.longDesc = self.VM.offersandPromotionsArray[tappedIndexPath.row].proLongDesc ?? ""
        vc.promotionId = self.VM.offersandPromotionsArray[tappedIndexPath.row].promotionId ?? 0
        vc.promotionValid = self.VM.offersandPromotionsArray[tappedIndexPath.row].validTo ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //Api:-
    
    func offersandPromotionsApi(){
        
        let parameters = [
            "ActionType": "99",
            "ActorId": userID
        ] as [String: Any]
        print(parameters)
        self.VM.offersandPromotions(parameters: parameters) { response in
            self.VM.offersandPromotionsArray = response?.lstPromotionJsonList ?? []
            DispatchQueue.main.async {
                self.stopLoading()
                if self.VM.offersandPromotionsArray.count != 0 {
                    self.offerstableView.isHidden = false
                    self.noDataFound.isHidden = true
                    self.offerstableView.reloadData()
                }else{
                    self.noDataFound.isHidden = false
                    self.offerstableView.isHidden = true
                   // self.playAnimation()
                }
            }
        }
    }
    
    
    
}
extension OffersListViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.VM.offersandPromotionsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersTableViewCell") as? OffersTableViewCell
        cell!.delegate = self
        cell?.selectionStyle = .none
        cell?.offersName.text = self.VM.offersandPromotionsArray[indexPath.row].promotionName ?? ""
        let receivedImage = (self.VM.offersandPromotionsArray[indexPath.row].proImage ?? "").dropFirst(2)
        print(receivedImage, "receivedURL")
        let totalImgURL = PROMO_IMG + receivedImage
        cell?.offersImg.sd_setImage(with: URL(string: totalImgURL), placeholderImage: UIImage(named: "ic_default_img"))
        
        return cell!
        
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 160
//    }
}
