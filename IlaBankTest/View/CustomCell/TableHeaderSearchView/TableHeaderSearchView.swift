//
//  TableHeaderSearchView.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import UIKit

class TableHeaderSearchView: UITableViewHeaderFooterView {
    
    //MARK: - @IBOutlet & Variables
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSearchActive: Bool = false {
        didSet {
            searchBar.searchTextField.text = isSearchActive ? searchBar.searchTextField.text : StrConst.empty
        }
    }
    
    var hintText = StrConst.empty {
        didSet {
            searchBar.searchTextField.placeholder = StrConst.search + StrConst.space + hintText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchBar.searchTextField.backgroundColor = .clear
    }
}
