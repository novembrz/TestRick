//
//  RealmService.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 16.05.2023.
//

import RealmSwift

class RealmService {
    
    private var rm: Realm {
        return try! Realm()
    }
    
    func write(_ onWrite: () -> Void) {
        try! rm.write {
            onWrite()
        }
    }
    
    func add(object: Object, update: Realm.UpdatePolicy = .all) {
        let realm: Realm = rm
        try! realm.write {
            realm.add(object, update: update)
        }
    }
    
    func add(objects: [Object], update: Realm.UpdatePolicy = .modified) {
        let realm: Realm = rm
        try! realm.write {
            realm.add(objects, update: update)
        }
    }
    
    func getAll<T: Object>(type: T.Type) -> Results<T> {
        return rm.objects(type)
    }
    
    func get<T: Object>(type: T.Type, primaryKey: Int) -> T? {
        return rm.object(ofType: type, forPrimaryKey: primaryKey)
    }
    
    func delete(object: Object) {
        let realm: Realm = rm
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func delete(objects: [Object]) {
        let realm: Realm = rm
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    func delete<T: Object>(objects: Results<T>) {
        let realm: Realm = rm
        try! realm.write {
            realm.delete(objects)
        }
    }
}
