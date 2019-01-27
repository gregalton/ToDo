//
//  AppDelegate.swift
//  ToDo
//
//  Created by Greg Alton on 1/27/19.
//  Copyright © 2019 Greg Alton. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        PersistentService.saveContext()
    }

}

