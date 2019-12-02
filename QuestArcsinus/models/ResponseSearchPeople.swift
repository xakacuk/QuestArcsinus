//
//  ResponseSearchPeople.swift
//  QuestArcsinus
//
//  Created by Евгений Бейнар on 27.11.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import Foundation

struct ResponseSearchPeople: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Person]
}
