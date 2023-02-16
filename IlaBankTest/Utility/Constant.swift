//
//  Constant.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import UIKit

struct StrConst {
    static let empty = ""
    static let space = " "
    static let json = "json"
    static let fileName = "data"
    static let noDataCell = "NoDataCell"
    static let noSearchData =  "No search result found for"
    static let search = "Search"
}

struct NumConst {
    static let searchSectionHeight = 60.0
    static let carouselRowHeight = UIScreen.main.bounds.size.height * 0.3
    static let carouselWitdhPercentage: CGFloat = 0.85
    static let cellSpacing: CGFloat = 10
}

struct CellIdentifire {
    static let TableCellCarousel = "TableCellCarousel"
    static let TableCellAppList = "TableCellAppList"
    static let TableHeaderSearchView = "TableHeaderSearchView"
    static let CollectionCellImage = "CollectionCellImage"
}
