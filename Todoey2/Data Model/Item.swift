//
//  Item.swift
//  Todoey2
//
//  Created by Morgan Hondros on 2/18/19.
//  Copyright © 2019 Morgan Hondros. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
