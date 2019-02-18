//
//  Category.swift
//  Todoey2
//
//  Created by Morgan Hondros on 2/18/19.
//  Copyright © 2019 Morgan Hondros. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    
}
