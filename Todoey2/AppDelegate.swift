//
//  AppDelegate.swift
//  Todoey2
//
//  Created by Morgan Hondros on 2/11/19.
//  Copyright © 2019 Morgan Hondros. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        } catch {
            print("FUCKING SHIT, THERE WAS TOTALLY AN ERROR SAVING THE FUCKING REALM. Figure it out: \(error)")
        }

        
        return true
    }


}






