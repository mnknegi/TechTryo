//
//  EmployeeRepository.swift
//  core-data
//
//  Created by Mayank Negi on 09/02/24.
//

import CoreData
import Foundation

protocol EmployeeRepositoryProviding {

    func create(employee: Employee)
    func getAllEmployee() -> [Employee]?
    func getEmployee(byIdentifier id: UUID) -> Employee?
    func update(employee record: Employee) -> Bool
    func delete(employee record: Employee) -> Bool
}

final class EmployeeRepositoryProvider: EmployeeRepositoryProviding {

    let storage: PersistentStoring

    init(storage: PersistentStoring) {
        self.storage = storage
    }

    var context: NSManagedObjectContext {
        self.storage.persistentContainer.viewContext
    }

    func create(employee: Employee) {
        let employeeEntity = CDEmployee(context: self.context)
        employeeEntity.id = employee.id
        employeeEntity.name = employee.name
        employeeEntity.email = employee.email
        self.storage.saveContext()
    }

    func getAllEmployee() -> [Employee]? {
        guard
            let employeeRecords = self.storage.fetchManagedObject(managedObject: CDEmployee.self) else {
            return nil
        }

        var employee: [Employee] = []
        employeeRecords.forEach { record in
            employee.append(Employee(id: record.id!, name: record.name, email: record.email))
        }
        return employee
    }

    func getEmployee(byIdentifier id: UUID) -> Employee? {

        guard
            let cdEmployee = getCDEmployee(withIdentifier: id) else {
            return nil
        }
        return Employee(id: cdEmployee.id!, name: cdEmployee.name, email: cdEmployee.email)
    }

    func update(employee record: Employee) -> Bool {

        guard
            let cdEmployee = getCDEmployee(withIdentifier: record.id) else {
            return false
        }
        cdEmployee.name = record.name
        cdEmployee.email = record.email
        self.storage.saveContext()
        return true
    }

    func delete(employee record: Employee) -> Bool {
        
        guard let cdEmployee = getCDEmployee(withIdentifier: record.id) else {
            return false
        }
        self.context.delete(cdEmployee)
        return true
    }
}

extension EmployeeRepositoryProvider {

    fileprivate func getCDEmployee(withIdentifier id: UUID) -> CDEmployee? {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)

        fetchRequest.predicate = predicate
        do {
            let cdEmployee = try self.context.fetch(fetchRequest).first
            guard
                let cdEmployee = cdEmployee else {
                return nil
            }
            return cdEmployee
        } catch {
            return nil
        }
    }
}
