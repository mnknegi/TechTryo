//
//  EmployeeListViewController.swift
//  core-data
//
//  Created by Mayank Negi on 09/02/24.
//

import UIKit

class EmployeeListViewController: UIViewController {

    @IBOutlet weak var employeeTableView: UITableView!

    private var viewModel: EmployeeListViewModel {
        let storage = PersistentStorage.shared
        let repository = EmployeeRepositoryProvider(storage: storage)
        return EmployeeListViewModel(repository: repository)
    }

    private var employeesList: [Employee]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Employees List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addEmployeeAction))

        self.employeesList = self.viewModel.getAllEmployees()
    }

    @objc
    func addEmployeeAction() {
        let addEmployeeRecordViewController = AddEmployeeRecordViewModel(repository: self.viewModel.repository, operation: .create)
        self.makeModifyEmployeeRecordViewController(with: addEmployeeRecordViewController)
    }

}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employeesList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employee.cell.identifier", for: indexPath)
        let employee = employeesList?[indexPath.row]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = employee?.name
        contentConfiguration.secondaryText = employee?.email
        cell.contentConfiguration = contentConfiguration
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updateEmployeeRecordViewModel = AddEmployeeRecordViewModel(repository: self.viewModel.repository, operation: .update)
        guard
            let employeeRecord = employeesList?[indexPath.row] else {
            return
        }
        updateEmployeeRecordViewModel.employeeRecord = employeeRecord
        self.makeModifyEmployeeRecordViewController(with: updateEmployeeRecordViewModel)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard
                let self = self, let employeeRecord = self.employeesList?[indexPath.row] else {
                completion(false)
                return
            }
            if self.viewModel.deleteEmployeeRecord(employeeRecord) {
                self.employeesList?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .none)
                completion(true)
            } else {
                completion(false)
            }
        }
        let swipeActionConfiguration = UISwipeActionsConfiguration(actions: [action])
        return swipeActionConfiguration
    }
}

extension EmployeeListViewController {

    private func makeModifyEmployeeRecordViewController(with viewModel: AddEmployeeRecordViewModel) {
        let modifyEmployeeRecordViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AddEmployeeViewController") as! AddEmployeeViewController
        viewModel.delegate = self
        modifyEmployeeRecordViewController.viewModel = viewModel
        self.navigationController?.pushViewController(modifyEmployeeRecordViewController, animated: true)
    }
}

extension EmployeeListViewController: AddEmployeeRecordViewModelDelegate {

    func addEmployeeRecordViewModel(_ viewModel: AddEmployeeRecordViewModel, didFinishCreatingRecord employeeRecord: Employee) {
        self.employeesList?.append(employeeRecord)
        self.employeeTableView.reloadData()
    }
    
    func addEmployeeRecordViewModel(_ viewModel: AddEmployeeRecordViewModel, didFinishUpdatingRecord updatedRecord: Employee) {
        guard
            let employeesList = self.employeesList else {
            return
        }
        for (index, existingEmployee) in employeesList.enumerated() {
            if existingEmployee.id == updatedRecord.id {
                self.employeesList?[index] = updatedRecord
                self.employeeTableView.reloadData()
            }
        }
    }
}
