//
//  PersistentStorage.swift
//  core-data
//
//  Created by Mayank Negi on 09/02/24.
//

import CoreData
import Foundation

protocol PersistentStoring {

    var persistentContainer: NSPersistentContainer { get }
    func saveContext()
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]?
}

final class PersistentStorage: PersistentStoring {

    private init() {}
    static let shared = PersistentStorage()

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "core_data")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard
                let record = try self.persistentContainer.viewContext.fetch(managedObject.fetchRequest()) as? [T] else {
                return nil
            }
            return record
        } catch {
            return nil
        }
    }

}
