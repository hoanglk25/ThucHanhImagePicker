//
//  ViewController.swift
//  ThucHanhImagePicker
//
//  Created by Hoàng Đức on 18/11/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var infomations:[Infomation] = fetch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Informations"
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = addButton
        
        
    }
    @objc func didTapAddButton() {
        let vc1 = PickImageViewController()
        
        vc1.handelSave = { newInfo in
            self.infomations.append(newInfo)
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(vc1, animated: true)
    }


}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc2 = VideoViewController()
        let vc3 = TableViewController()
        navigationController?.pushViewController(vc3, animated: true)
    }
}
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infomations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.nameLabel.text = infomations[indexPath.row].name
        cell.avatarImageView.image = infomations[indexPath.row].imageName?.image
        cell.ageLable.text = infomations[indexPath.row].age
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { context, view, closure in
            self.infomations.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        deleteAction.backgroundColor = .red
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { context, view, closure in
            let vc = PickImageViewController()
            vc.infomation = self.infomations[indexPath.row]
            vc.index = indexPath.row
            vc.handelSave = { newInfo in
                self.infomations[indexPath.row] = newInfo
                self.tableView.reloadData()
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
           
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

