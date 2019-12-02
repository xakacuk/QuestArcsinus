//
//  PersonViewController.swift
//  QuestArcsinus
//
//  Created by Евгений Бейнар on 26.11.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import UIKit
import RealmSwift
import MBProgressHUD

private enum Cons: String {
    case cell = "shortPersonCell"
    case segue = "detailInfoPersonSegue"
}

final class PersonViewController: UIViewController {
    
    private let viewModel = PersonViewModel()
    private var fromNetworkPersons = [Person]()
    private var selectedPerson: Person!
    
//    let realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "Temp"))
    
    private let realm = try! Realm()
    private lazy var localPersons: Results<Person> = { self.realm.objects(Person.self) }()
    
    @IBOutlet private weak var personsTableView: UITableView! {
        didSet {
            personsTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet private weak var personSearchTextField: UITextField!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    
    @IBAction private func switcher(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                personSearchTextField.isEnabled = true
                personsTableView.reloadData()
                break
            case 1:
                personSearchTextField.isEnabled = false
                personsTableView.reloadData()
                break
            default:
                break
        }
    }
    
    
    @IBAction func clearDBTap(_ sender: Any) {
        clearDB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personSearchTextField.delegate = self
        setupTableView()
    }
    
    private func setupTableView() {
        personsTableView.delegate = self
        personsTableView.dataSource = self
    }
    
    private func getPersonFromInternet(name: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = .indeterminate
        hud.label.text = "Searching..."
        viewModel.getPersonFromInternet(name: name) { result in
            switch result {
                case .success(let response):
                    hud.hide(animated: true)
                    if response.count == 0 {
                        self.showErrorAlertMessadge(title: "Oops!", messadge: "Nothing found :[")
                    } else {
                        self.fromNetworkPersons = response
                        self.personsTableView.reloadData()
                    }
                    break
                case .failure(let error):
                    hud.hide(animated: true)
                    self.showErrorAlertMessadge(title: "Error", messadge: error.localizedDescription)
                    break
            }
        }
    }
    
    private func clearDB() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        if segmentedControl.selectedSegmentIndex == 1 {
            personsTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Cons.segue.rawValue {
            guard let vc = segue.destination as? DetailPersonViewController else {return}
            vc.selectedPerson = selectedPerson
        }
    }
}

extension PersonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if segmentedControl.selectedSegmentIndex == 0 {
            selectedPerson = fromNetworkPersons[indexPath.row]
        } else {
            selectedPerson = localPersons[indexPath.row]
        }
        performSegue(withIdentifier: Cons.segue.rawValue, sender: nil)
    }
}

extension PersonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return fromNetworkPersons.count
        } else {
            return localPersons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cons.cell.rawValue, for: indexPath) as! PersonTableViewCell
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.configureCell(person: fromNetworkPersons[indexPath.row])
        } else {
            cell.configureCell(person: localPersons[indexPath.row])
        }
        return cell
    }
}

extension PersonViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text else {return false}
        if text == "" {return false}
        getPersonFromInternet(name: text)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard range.location == 0 else {
            return true
        }

        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string) as NSString
        return newString.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines).location != 0
    }
}
