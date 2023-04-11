//
//  FollowerListViewController.swift
//  CenturyPly_JSON
//
//  Created by Arokia-M3 on 03/03/22.
//

import UIKit
import Lottie
class FollowerListViewController: BaseViewController {
    
  
    @IBOutlet weak var animationLottieView: LottieAnimationView!
    @IBOutlet weak var followertableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.followertableView.register(UINib(nibName: "AddFollowerTableViewCell", bundle: nil), forCellReuseIdentifier: "AddFollowerTableViewCell")
        self.lottieAnimation(animationView: self.animationLottieView)
        self.followertableView.delegate = self
        self.followertableView.dataSource = self
    }
    
 
}
extension FollowerListViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddFollowerTableViewCell") as? AddFollowerTableViewCell
        return cell!
        
    }
}
