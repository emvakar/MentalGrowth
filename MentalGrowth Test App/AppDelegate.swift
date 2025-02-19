//
//  AppDelegate.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit
import EKNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var resolver: DIResolver!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let audioMixer = AudioMixerManager()
        let networking = NetworkRequestProvider(networkWrapper: EKNetworkRequestWrapper())
        let youtubeLinkWrapper = YouTubeLinkWrapper()
        let resolver = DIResolver(audioMixer: audioMixer, networking: networking, youtubeLinkWrapper: youtubeLinkWrapper)
        
        self.resolver = resolver
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = self.resolver.rootViewController()
        self.window?.makeKeyAndVisible()

        return true
    }
}


// MARK: - Life circle
extension AppDelegate {

    func applicationWillResignActive(_ application: UIApplication) { }
    func applicationDidEnterBackground(_ application: UIApplication) { }
    func applicationWillEnterForeground(_ application: UIApplication) { }
    func applicationDidBecomeActive(_ application: UIApplication) { }
}

