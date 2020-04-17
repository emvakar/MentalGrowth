//
//  RootViewController.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var resolver: DIResolver
    var current: UIViewController!

    init(resolver: DIResolver) {
        self.resolver = resolver
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showDefaultScreen()
    }

    private func showDefaultScreen() {
        let tabbarController = UITabBarController()
        
        let mixer = UINavigationController(rootViewController: self.resolver.presentMixerViewController())
        mixer.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        let videoList = UINavigationController(rootViewController: self.resolver.presentPlaylistViewController())
        videoList.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        tabbarController.setViewControllers([mixer, videoList], animated: false)
        self.addChild(tabbarController)
        self.view.addSubview(tabbarController.view)
        tabbarController.didMove(toParent: self)

        self.current = tabbarController
    }
}
