//
//  DetailPersonViewController.swift
//  QuestArcsinus
//
//  Created by Евгений Бейнар on 27.11.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import UIKit
import RealmSwift

final class DetailPersonViewController: UIViewController {
    
    var selectedPerson: Person!
    
    @IBOutlet weak var infoPersonTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedPerson.name
        setupTextView()
        if !checkPerson() {
            savePerson()
        }
    }
    
    private func test() {
        if selectedPerson == nil {
            savePerson()
        } else {
            setupTextView()
        }
    }
    
    private func setupTextView() {
        infoPersonTextView.text = """
            url(id): \(selectedPerson.url)
            created: \(selectedPerson.created)
            eye color: \(selectedPerson.eye_color)
            birth year: \(selectedPerson.birth_year)
            hair color: \(selectedPerson.hair_color)
            height: \(selectedPerson.height)
            mass: \(selectedPerson.mass)
            skin color: \(selectedPerson.skin_color)
            homeworld: \(selectedPerson.homeworld)
        """
    }
    
    private func checkPerson() -> Bool {
        let realm = try! Realm()
        let persons = realm.objects(Person.self)
        for person in persons {
            if person == selectedPerson {
                return true
            }
        }
        return false
    }
    
    private func savePerson() {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.add(selectedPerson)
            }
        } catch _ as NSError {
            // handle error
        }
    }
}
