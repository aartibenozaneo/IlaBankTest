//
//  AppListViewModel.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import Foundation

final class AppListViewModel {
    
    //MARK: - Variables
    
    private var arrCarouselList: [CarouselData]?
    private var arrList: [CarouselData]?
    private var currentCarouselIndex = 0
    var isSearchActive = false
    
    //Callback to reloadData
    var reloadData: ((Bool) -> Void)?
    
    //Table sections
    private enum Sections: Int, CaseIterable {
        case carousel
        case list
    }
    
    init() {
        arrCarouselList = []
        arrList = []
        
        //Get carousel array from JSONHelper
        let objHelper = JSONHelper()
        if let mainData = objHelper.loadJsonDataFromFile() {
            let arrMainData = mainData.data ?? []
            arrCarouselList = arrMainData
            arrList = arrCarouselList
        }
    }
}

//MARK: - Get/Set Data Handler

extension AppListViewModel {
    
    func getCarouselList() -> [CarouselData] {
        return arrList ?? []
    }
    
    //Get array of selected carousel
    func getSelectedAppList() -> [AppsList] {
        let appsList = arrList?[safe: currentCarouselIndex]?.appsList ?? []
        return appsList
    }
    
    func getSelectedCategoryName() -> String {
        let dic = arrCarouselList?[safe: currentCarouselIndex]
        let name = dic?.name ?? StrConst.empty
        return name
    }
    
    func getSectionCarousel() -> Int {
        return Sections.carousel.rawValue
    }
    
    func getSectionList() -> Int {
        return Sections.list.rawValue
    }
    
    //MARK: - Update Data
    
    func updateIsSearchActive(_ isSearchActive: Bool) {
        self.isSearchActive = isSearchActive
        reloadData?(true)
    }
    
    func updateSelectedIndex(_ currentCarouselIndex: Int) {
        self.currentCarouselIndex = currentCarouselIndex
        reloadData?(false)
    }
    
    //MARK: - SearchAppList Handler
    
    func searchTxt(txt : String) {
        if(txt.count > 0) {
            if let arr: [AppsList] = arrCarouselList?[safe: currentCarouselIndex]?.appsList {
                let appsList = arr.filter({$0.name!.localizedCaseInsensitiveContains(txt)})
                arrList?[safe: currentCarouselIndex]?.appsList = appsList
            }
        } else {
            arrList = arrCarouselList
        }
        reloadData?(true)
    }
}

//MARK: - UITableViewDelegate Handler

extension AppListViewModel {
    
    func numberOfSections() -> Int {
        return Sections.allCases.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if section == Sections.carousel.rawValue {
            //Hide carousel section if search is active
            return isSearchActive ? 0 : 1
        } else {
            let appsList = getSelectedAppList()
            let count = appsList.count
            //Return atleast one row for `no data found` cell
            return count == 0 ? 1 : count
        }
    }
}
