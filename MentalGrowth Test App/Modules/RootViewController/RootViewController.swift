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
        let vc = self.resolver.presentMixerViewController()
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)

        self.current = vc
    }
}
