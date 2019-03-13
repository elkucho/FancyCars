//
//  FancyCarsDTO.swift
//  fancycars
//
//  Created by Marco Lima on 2019-03-11.
//  Copyright © 2019 LIM4. All rights reserved.
//

import Foundation


/*
 
 One of yher requirements is to have two servie calls for all the cars and another one for the
 availability. Because we are using stubbed dsta, I've added the availability here in the DTO
 
 */

struct FancyCarsDTO: Decodable {
    
    let id : Int
    let img : String
    let name : String
    let make : String
    let model : String
    let year : Int
    let availability : String 
    
}
