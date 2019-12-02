//
//  PersonTableViewCell.swift
//  QuestArcsinus
//
//  Created by Евгений Бейнар on 27.11.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import UIKit

final class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var personInfoLabel: UILabel!
    
    func configureCell(person: Person) {
        personInfoLabel.text = """
            \(person.name)
            \(person.url)
        """
    }

}
