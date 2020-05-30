//
//  Alertable.swift
//  Friendie
//
//  Created by Com on 2020/5/30.
//  Copyright © 2020 Com. All rights reserved.
//

import UIKit
import Foundation

extension String {

    public var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }

    public var localizedUppercaseString: String {
        return localizedString.uppercased()
    }
}


protocol Alertable {}

extension Alertable where Self: UIViewController {

    func presentAlert() {

        let alert = UIAlertController(title: StringKey.Alert.title.localizedString,
                                      message: StringKey.Alert.description.localizedString,
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: StringKey.General.ok.localizedUppercaseString,
                                      style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}

