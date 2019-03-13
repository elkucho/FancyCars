//
//  Array-Extensions.swift
//  fancycars
//
//  Created by Marco Lima on 2019-03-12.
//  Copyright © 2019 LIM4. All rights reserved.
//

import Foundation

extension Array {
    
    func distinct<T:Hashable>(by: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(by(value)) {
                set.insert(by(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
    
}
