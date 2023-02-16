//
//  AppListVC+UISearchBarDelegate.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import UIKit

// MARK: - UISearchBarDelegate -

extension AppListVC : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.updateIsSearchActive(true)
        //show cancel button when editing started
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            searchBar.showsCancelButton = true
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //Do not allow space as first charater
        if text == StrConst.space && range.location == 0 {
            return false
        }
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchAppListText: String) {
        viewModel.searchTxt(txt: searchAppListText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchTxt(txt: StrConst.empty)
        viewModel.updateIsSearchActive(false)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //hide cancel button when editing ended
        if !viewModel.isSearchActive {
            searchBar.showsCancelButton = false
        }
    }
}
