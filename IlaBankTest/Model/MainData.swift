//
//  MainData.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import Foundation

struct MainData : Codable {
    let data: [CarouselData]?
}

struct CarouselData : Codable {
    let name : String?
    let image : String?
    var appsList : [AppsList]?
}

struct AppsList : Codable {
    let name : String?
    let image : String?
}
