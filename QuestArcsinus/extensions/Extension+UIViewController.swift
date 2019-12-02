//
//  extension+UIViewController.swift
//  QuestArcsinus
//
//  Created by Евгений Бейнар on 27.11.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import UIKit

extension UIViewController {
    public func showErrorAlertMessadge(title: String, messadge: String) {
        let alert = UIAlertController(title: title, message: messadge, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
