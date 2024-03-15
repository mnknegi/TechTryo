//
//  AddEmployeeRecordViewModel.swift
//  core-data
//
//  Created by Mayank Negi on 10/02/24.
//

import Foundation

protocol AddEmployeeRecordViewModelDelegate: AnyObject {
    func addEmployeeRecordViewModel(_ viewModel: AddEmployeeRecordViewModel, didFinishCreatingRecord employeeRecord: Employee)
    func addEmployeeRecordViewModel(_ viewModel: AddEmployeeRecordViewModel, didFinishUpdatingRecord updatedRecord: Employee)
}

enum Operation: String {
    case create
    case update

    var value: String {
        switch self {
        case .create:
            return "Add"
        case .update:
            return "Update"
        }
    }
}

final class AddEmployeeRecordViewModel {

    let repository: EmployeeRepositoryProviding
    var operation: Operation

    var employeeRecord: Employee?

    weak var delegate: AddEmployeeRecordViewModelDelegate?

    init(repository: EmployeeRepositoryProviding, operation: Operation = .create) {
        self.repository = repository
        self.operation = operation
    }

    func createNewRecord(with newEmployee: Employee) {
        self.repository.create(employee: newEmployee)
        self.delegate?.addEmployeeRecordViewModel(self, didFinishCreatingRecord: newEmployee)
    }

    func updateExistingRecord(with updatedEmployeeRecord: Employee) -> Bool {
        if self.repository.update(employee: updatedEmployeeRecord) {
            self.delegate?.addEmployeeRecordViewModel(self, didFinishUpdatingRecord: updatedEmployeeRecord)
            return true
        } else {            
            return false
        }
    }
}
