//
//  CollectionCellImage.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import UIKit

class CollectionCellImage: UICollectionViewCell {
    
    //MARK: - @IBOutlet & Variables
    
    @IBOutlet weak var imgView: UIImageView!
    
    var strImage: String?  {
        didSet {
            setupCell()
        }
    }
    
    //MARK: - Custom Function
    
    private func setupCell() {
        let name = strImage ?? StrConst.empty
        imgView.image = UIImage(named: name)
    }
}
