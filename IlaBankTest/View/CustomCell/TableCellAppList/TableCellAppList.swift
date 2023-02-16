//
//  TableCellAppList.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import UIKit

class TableCellAppList: UITableViewCell {
    
    //MARK: - @IBOutlet & Variables
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var iconImgView: UIImageView!
    
    var applistData: AppsList?  {
        didSet {
            setupCell()
        }
    }
    
    //MARK: - Custom Function
    
    private func setupCell() {
        lblName.text = applistData?.name ?? StrConst.empty
        
        if let imgName = applistData?.image {
            iconImgView.image = UIImage(named: imgName)
        } else {
            iconImgView.image = nil
        }
    }
}
