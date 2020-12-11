//
//  IceCream.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import Foundation

class IceCream {
    let name1: String
    let name2: String
    let price: String
    let bg_color: String
    let type: IceCreamType
    var selection: Int = 0
    
    init(name1: String, name2: String, price: String, bg_color: String, type: IceCreamType) {
        self.name1 = name1
        self.name2 = name2
        self.price = price
        self.bg_color = bg_color
        self.type = type
    }
    
    func select() {
        selection += 1
    }
    
    func restartSelection() {
        selection = 0
    }
}

enum IceCreamType: String {
    case popsicle
    case cone
    case froyo
    case sundae
    case undefined
}

struct APIIceCream: Decodable {
    let name1: String
    let name2: String
    let price: String
    let bg_color: String
    let type: String
}
