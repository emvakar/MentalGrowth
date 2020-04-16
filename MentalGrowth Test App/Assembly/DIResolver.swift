//
//  DIResolver.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit

protocol DIResolverComponents { }

class DIResolver { }

// MARK: - DIResolverComponents

extension DIResolver: DIResolverComponents {

    func rootViewController() -> RootViewController {
        let controller = RootViewController(resolver: self)
        return controller
    }

}
