//
//  Array+Extension.swift
//  Pods
//
//  Created by 刘伟 on 16/6/30.
//
//

import Foundation

extension Array where Element: Equatable {
    
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }

    mutating func removeObjectsInArray(array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}