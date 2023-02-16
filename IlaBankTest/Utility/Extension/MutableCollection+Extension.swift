//
//  MutableCollection+Extension.swift
//  IlaBankTest
//
//  Created by Aarti Oza on 16/02/23.
//

import Foundation

//Extension to get/set values of array safely to avoid index out of bounds
extension MutableCollection {
    
    subscript(safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set(newValue) {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
