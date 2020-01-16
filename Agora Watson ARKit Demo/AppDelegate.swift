//
//  AppDelegate.swift
//  Agora Watson ARKit Demo
//
//  Created by Hermes Frangoudis on 1/14/20.
//  Copyright © 2020 Agora.io. All rights reserved.
//

import UIKit
import ARVideoKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return ViewAR.orientation
    }


}

