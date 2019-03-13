//
//  FancyCarsModel.swift
//  fancycars
//
//  Created by Marco Lima on 2019-03-11.
//  Copyright © 2019 LIM4. All rights reserved.
//

import Foundation

class FancyCarsModel {
    
    var originalFancyCars : [FancyCarsDTO] = []
    
    func loadCars(completion: @escaping (_ result: Bool, _ data: [FancyCarsDTO]) -> Void) {
        
        if  let theCars = Bundle.main.path(forResource: "FancyCars", ofType: "json") {
            
            do {

                let fileContent = try String(contentsOfFile: theCars)
                let fancyCars = try JSONDecoder().decode([FancyCarsDTO].self, from: fileContent.data(using: .utf8)!)
                
                originalFancyCars = fancyCars
                completion(true, fancyCars)
                
            } catch let error {
                print("Error trying to decode FancyCars : \(error)")
                completion(false, [])
            }
            
        } else {
            completion(false, [])
        }
        
    }
    
    func duplicateFancyCars() {
        
        let theCarsWeHave = originalFancyCars
        originalFancyCars.append(contentsOf: theCarsWeHave)
        
    }
    
    
    /*
     
     Created this class separately so it can be incremented with other manipulation of data,
     such as changing the vehicle availability when the car is sold, etc.
     
     */

    
}
