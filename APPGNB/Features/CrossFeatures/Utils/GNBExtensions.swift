//
//  GNBExtensions.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

internal extension UITableView {
    func gnbRegisterCell(nibName: GNBBaseTableViewCellType) {
        let nibIdentifier = nibName.getNibName()
        self.register(UINib(nibName: nibIdentifier, bundle: APPGNB.bundle), forCellReuseIdentifier: nibIdentifier)
    }
}

internal extension UIViewController {
    static func gnbStoryboardInstance(storyboardIdentifier: String) -> UIViewController {
        return UIStoryboard(name: storyboardIdentifier, bundle: APPGNB.bundle).instantiateViewController(withIdentifier: String(describing: self))
    }
}
