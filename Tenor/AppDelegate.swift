//
//  AppDelegate.swift
//  Tenor
//
//  Created by Jitendra on 27/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Configuration.checkConfiguration()
        
        IQKeyboardManager.shared.enable = true

        NetworkActivityIndicatorManager.shared.isEnabled = true

        return true
    }
}

