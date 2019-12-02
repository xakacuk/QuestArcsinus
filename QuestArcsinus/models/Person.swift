//
//  Person.swift
//  QuestArcsinus
//
//  Created by Евгений Бейнар on 27.11.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

final class Person: Object, Decodable {
    @objc dynamic var name: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var mass: String = ""
    @objc dynamic var hair_color: String = ""
    @objc dynamic var skin_color: String = ""
    @objc dynamic var eye_color: String = ""
    @objc dynamic var birth_year: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var homeworld: String = ""
//    let films = List<String>()
    @objc dynamic var created: String = ""
    @objc dynamic var edited: String = ""
    @objc dynamic var url: String = ""
    
    private enum PersonCodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hair_color
        case skin_color
        case eye_color
        case birth_year
        case gender
        case homeworld
        case created
        case edited
        case url
    }
    
    convenience init(name: String, height: String, mass: String, hair_color: String, skin_color: String, eye_color: String, birth_year: String, gender: String, homeworld: String, created: String, edited: String, url: String) {
        self.init()
        self.name = name
        self.height = height
        self.mass = mass
        self.hair_color = hair_color
        self.skin_color = skin_color
        self.eye_color = eye_color
        self.birth_year = birth_year
        self.gender = gender
        self.homeworld = homeworld
        self.created = created
        self.edited = edited
        self.url = url
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonCodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let height = try container.decode(String.self, forKey: .height)
        let mass = try container.decode(String.self, forKey: .mass)
        let hair_color = try container.decode(String.self, forKey: .hair_color)
        let skin_color = try container.decode(String.self, forKey: .skin_color)
        let eye_color = try container.decode(String.self, forKey: .eye_color)
        let birth_year = try container.decode(String.self, forKey: .birth_year)
        let gender = try container.decode(String.self, forKey: .gender)
        let homeworld = try container.decode(String.self, forKey: .homeworld)
        let created = try container.decode(String.self, forKey: .created)
        let edited = try container.decode(String.self, forKey: .edited)
        let url = try container.decode(String.self, forKey: .url)
        self.init(name: name, height: height, mass: mass, hair_color: hair_color, skin_color: skin_color, eye_color: eye_color, birth_year: birth_year, gender: gender, homeworld: homeworld, created: created, edited: edited, url: url)
    }
    
    required init() {
        super.init()
    }
}

