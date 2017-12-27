//
//  Item.swift
//  ToDoey
//
//  Created by MBP on 27/12/2017.
//  Copyright © 2017 MBP. All rights reserved.
//

import Foundation
//make class encodable to plist form
//only primative data types
class Item : Encodable, Decodable{
    
    var title = ""
    var done = false
}
