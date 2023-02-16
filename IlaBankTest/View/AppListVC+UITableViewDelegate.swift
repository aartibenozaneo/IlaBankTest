//
//  AppListVC+UITableViewDelegate.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import UIKit

//MARK: - UITableViewDataSource

extension AppListVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        let sectionCarousel = viewModel.getSectionCarousel()
        
        //Setup carousel section cell
        if section == sectionCarousel {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.TableCellCarousel, for: indexPath) as! TableCellCarousel
            cell.arrCarouselList = viewModel.getCarouselList()
            cell.selectedCarouselHandler = { [weak self] index in
                self?.viewModel.updateSelectedIndex(index)
            }
            return cell
        } else {
            let arr = viewModel.getSelectedAppList()
            let count = arr.count
            
            //Setup no data cell if arr count is 0
            if count == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: StrConst.noDataCell) {
                    cell.textLabel?.textAlignment = .center
                    let strNoData = StrConst.noSearchData + StrConst.space + viewModel.getSelectedCategoryName()
                    cell.textLabel?.text = strNoData
                    return cell
                }
            }
            
            //Setup app list section cell
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.TableCellAppList, for: indexPath) as! TableCellAppList
            let arrList = viewModel.getSelectedAppList()
            let index = indexPath.row
            cell.applistData = arrList[safe: index]
            return cell
        }
    }
}

//MARK: - UITableViewDelegate

extension AppListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == viewModel.getSectionList() {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellIdentifire.TableHeaderSearchView) as! TableHeaderSearchView
            header.searchBar.delegate = self
            header.isSearchActive = viewModel.isSearchActive
            header.hintText = viewModel.getSelectedCategoryName()
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == viewModel.getSectionList() {
            return NumConst.searchSectionHeight
        }
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == viewModel.getSectionCarousel() {
            return NumConst.carouselRowHeight
        }
        return UITableView.automaticDimension
    }
}
