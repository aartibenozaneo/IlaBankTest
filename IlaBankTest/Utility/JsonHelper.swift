//
//  JSONHelper.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import UIKit

struct JSONHelper {
    
    func loadJsonDataFromFile() -> (MainData?) {
        guard let url = Bundle.main.url(forResource: StrConst.fileName, withExtension: StrConst.json) else { return nil }
        
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        if let mainData = decodeData(data: data) {
            return mainData
        }
        return nil
    }
    
    private func decodeData( data: Data) -> MainData? {
        guard let jsonData = try? JSONDecoder().decode(MainData.self, from: data) else { return nil }
        return jsonData
    }
}
