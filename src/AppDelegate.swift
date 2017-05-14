//
//  AppDelegate.swift
//  Boil Clock
//
//  Created by Katya on 18.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        return true
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        CoreDataManager.sharedInstance.saveContext()
    }

   }

