//
//  Catalogue_CVC.swift
//  centuryDemo
//
//  Created by Arkmacbook on 10/03/22.
//

import UIKit

class Catalogue_CVC: UICollectionViewCell {
    
    @IBOutlet var catalogurLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            catalogurLabel.textColor = isSelected ? .white : .darkGray
            catalogurLabel.backgroundColor = isSelected ? #colorLiteral(red: 0.007268199697, green: 0.4740364552, blue: 0.2290205359, alpha: 1) : #colorLiteral(red: 0.8392156959, green: 0.8392156959, blue: 0.8392156959, alpha: 1)
        
        }
    }
}
