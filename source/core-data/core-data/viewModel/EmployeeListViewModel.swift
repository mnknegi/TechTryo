//
//  EmployeeListViewModel.swift
//  core-data
//
//  Created by Mayank Negi on 10/02/24.
//

import Foundation

final class EmployeeListViewModel {

    let repository: EmployeeRepositoryProviding

    init(repository: EmployeeRepositoryProviding) {
        self.repository = repository
    }

    func getAllEmployees() -> [Employee]? {
        self.repository.getAllEmployee()
    }

    func deleteEmployeeRecord(_ employee: Employee) -> Bool {
        self.repository.delete(employee: employee)
    }
}
