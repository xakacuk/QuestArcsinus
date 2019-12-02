//
//  Extension+Realm.swift
//  QuestArcsinus
//
//  Created by Евгений Бейнар on 02.12.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    static func safeInit() -> Realm? {
        do {
            let realm = try Realm()
            return realm
        }
        catch {
            // LOG ERROR
        }
        return nil
    }

    func safeWrite(_ block: () -> ()) {
        do {
            // Async safety, to prevent "Realm already in a write transaction" Exceptions
            if !isInWriteTransaction {
                try write(block)
            }
        } catch {
            // LOG ERROR
        }
    }
}
