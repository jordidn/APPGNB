//
//  GNBExtensions.swift
//  APPGNB
//
//  Created by Jordi Durán on 04/09/2020.
//  Copyright © 2020 Jordi Duran. All rights reserved.
//

import UIKit

class GNBExtensions: NSObject {

}


//internal extension UITableView {
//    func gnbRegisterCell(nibName: SRBaseTableViewCellType) {
//        let nibIdentifier = nibName.getNibName()
//        self.register(UINib(nibName: nibIdentifier, bundle: APPGNB.bundle), forCellReuseIdentifier: nibIdentifier)
//    }
//}

internal extension UIViewController {
    static func gnbStoryboardInstance(storyboardIdentifier: String) -> UIViewController {
        return UIStoryboard(name: storyboardIdentifier, bundle: APPGNB.bundle).instantiateViewController(withIdentifier: String(describing: self))
    }
}
