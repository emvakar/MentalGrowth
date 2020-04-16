//
//  BasePresenter.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit

class BasePresenter {

    init() {

    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
