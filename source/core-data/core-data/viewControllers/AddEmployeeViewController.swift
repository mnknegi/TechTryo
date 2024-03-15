//
//  AddEmployeeViewController.swift
//  core-data
//
//  Created by Mayank Negi on 10/02/24.
//

import UIKit

class AddEmployeeViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var viewModel: AddEmployeeRecordViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        precondition(viewModel != nil, "AddEmployeeViewModel can't be nil.")

        self.title = "\(viewModel.operation.value) Employee"

        self.setUpUI(employeeRecord: viewModel.employeeRecord)
    }

    @IBAction func saveEmployeeAction(_ sender: UIButton) {
        guard
            let employeeName = self.nameTextField.text, let employeeEmail = self.emailTextField.text else {
                self.showAlertController(with: "Attention!", message: "Name and email fields can't be empty.")
                return
            }
        switch viewModel.operation {
        case .create:
            saveNewEmployeeRecord(with: employeeName, email: employeeEmail)
        case .update:
            updateExistingEmployeeRecord(with: employeeName, email: employeeEmail)
        }
    }

    private func showAlertController(with title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }

    private func saveNewEmployeeRecord(with name: String, email: String) {
        let newEmployeeRecord = Employee(id: UUID(), name: name, email: email)
        self.viewModel.createNewRecord(with: newEmployeeRecord)
        self.clearUI()
        self.showAlertController(with: "Saved", message: "employee record has been saved successfully.")
    }

    private func updateExistingEmployeeRecord(with name: String, email: String) {
        let updatedEmployeeRecord = Employee(id: viewModel.employeeRecord!.id, name: name, email: email)
        if self.viewModel.updateExistingRecord(with: updatedEmployeeRecord) {
            self.showAlertController(with: "Updated", message: "employee record has been updated successfully.")
        } else {
            self.showAlertController(with: "Something went wrong", message: "This operation is failed due to some unknown issue.")
        }
    }

    private func setUpUI(employeeRecord: Employee?) {
        guard
            let employeeRecord = employeeRecord else {
            return
        }
        self.nameTextField.text = employeeRecord.name
        self.emailTextField.text = employeeRecord.email
    }

    private func clearUI() {
        self.nameTextField.text = ""
        self.emailTextField.text = ""
    }

}
