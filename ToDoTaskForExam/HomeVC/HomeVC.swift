//
//  HomeVC.swift
//  ToDoTaskForExam
//
//  Created by Zokirov Firdavs on 30/04/21.
//

import UIKit
import MessageUI

class HomeVC: UIViewController, NewTaskDelegate, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate {
    func didFinishWithTask(task: Task) {
        self.newTasks.append(task)
        self.tableView.reloadData()
    }
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var timearr: [String] = []
    var newTasks : [Task] = []
    var finishedTasks : [Task] = []
    var archivedTasks : [Task] = []
    
    var allTasks : [[Task]] = []
    var filteredTasks: [Task] = []
    var isSearching: Bool = false // search bar qidirilgan qidirilmaganligi uchun
    
    var sectionTitles : [String] = ["New Tasks", "Finished Tasks", "Archived Tasks"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchBar.delegate  = self
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        let vc = NewTaskVC(nibName: "NewTaskVC", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}

// MARK - TableView methods



extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return newTasks.count
        } else if section == 1 {
            return finishedTasks.count
        } else{
            return archivedTasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0{
            cell.updateCell(with: newTasks[indexPath.row])
        } else if indexPath.section == 1 {
            cell.updateCell(with: finishedTasks[indexPath.row])
        } else if indexPath.section == 2 {
            cell.updateCell(with: archivedTasks[indexPath.row])
        }
        // cell.backgroundColor = .blue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var choosenTask: Task!
        
        if indexPath.section == 0{
            choosenTask = newTasks[indexPath.row]
        } else if indexPath.section == 1 {
            choosenTask = finishedTasks[indexPath.row]
        } else if indexPath.section == 2 {
            choosenTask = archivedTasks[indexPath.row]
        }
        
        let alert = UIAlertController(title: "Choose What to do", message: nil, preferredStyle: .actionSheet)
        
        
        let finish = UIAlertAction(title: "Finish 🎉", style: .default) { _ in
            choosenTask.state = .finished
            self.finishedTasks.append(choosenTask)
            self.newTasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        
        let shareMassge = UIAlertAction(title: "Share Massege", style: .default) { _ in
            let vc = UIActivityViewController(activityItems: [self.newTasks[indexPath.row],self.newTasks[indexPath.row].description], applicationActivities: nil)
            self.present(vc, animated: true, completion: nil)
        }
        let shareMassge2 = UIAlertAction(title: "Share Massege", style: .default) { _ in
            let vc = UIActivityViewController(activityItems: [self.finishedTasks[indexPath.row],self.finishedTasks[indexPath.row].description], applicationActivities: nil)
            self.present(vc, animated: true, completion: nil)
        }
        let shareMassge3 = UIAlertAction(title: "Share Massege", style: .default) { _ in
            let vc = UIActivityViewController(activityItems: [self.archivedTasks[indexPath.row],self.archivedTasks[indexPath.row].description], applicationActivities: nil)
            self.present(vc, animated: true, completion: nil)
        }
        
        let info1 = UIAlertAction(title: "Info", style: .default) { _ in
            let vc = InfoVC(nibName: "InfoVC", bundle: nil)
           vc.modalPresentationStyle = .overFullScreen
            vc.task = self.newTasks[indexPath.row].title
            vc.des = self.newTasks[indexPath.row].description
            self.present(vc, animated: true, completion: nil)
            
        }
        let info2 = UIAlertAction(title: "Info", style: .default) { _ in
            let vc = InfoVC(nibName: "InfoVC", bundle: nil)
            vc.modalPresentationStyle = .overFullScreen
            vc.task = self.finishedTasks[indexPath.row].title
            vc.des = self.finishedTasks[indexPath.row].description
            self.present(vc, animated: true, completion: nil)
            
        }
        let info3 = UIAlertAction(title: "Info", style: .default) { _ in
            let vc = InfoVC(nibName: "InfoVC", bundle: nil)
            vc.modalPresentationStyle = .overFullScreen
            vc.task = self.archivedTasks[indexPath.row].title
            vc.des = self.archivedTasks[indexPath.row].description
            self.present(vc, animated: true, completion: nil)
            
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style:.cancel, handler: nil )
        
        let archive = UIAlertAction(title: "Archived", style: .default) { _ in
            choosenTask.state = .archived
            self.archivedTasks.append(choosenTask)
            if indexPath.section == 0 {
                self.newTasks.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                self.finishedTasks.remove(at: indexPath.row)
            }
            self.tableView.reloadData()
        }
        
        let unArchive = UIAlertAction(title: "Unarchived", style: .default) { _ in
            choosenTask.state = .new
            self.newTasks.append(choosenTask)
            self.archivedTasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        
        let unfinish = UIAlertAction(title: "Unfinish ⬆️", style: .default) { _ in
            choosenTask.state = .new
            self.newTasks.append(choosenTask)
            self.finishedTasks.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        let shareByEmailAction = UIAlertAction(title: "Share by Email", style: .default) { action in
            
            if MFMailComposeViewController.canSendMail() {
                let message: String = "This is a mail message"
                let composePicker = MFMailComposeViewController()
                composePicker.mailComposeDelegate = self
                composePicker.delegate = self
                composePicker.setToRecipients(["fedyazokirov60@gmail.com"])
                composePicker.setSubject("To do app email message")
                composePicker.setMessageBody(message, isHTML: false)
                self.present(composePicker, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Could not send email", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        if indexPath.section == 0{
            alert.addAction(shareMassge)
            alert.addAction(shareByEmailAction)
            alert.addAction(info1)
            alert.addAction(finish)
            alert.addAction(archive)
            
            let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.newTasks.remove(at: indexPath.row )
                self.tableView.reloadData()
            }
            
            alert.addAction(delete)
        } else if indexPath.section == 1 {
            alert.addAction(shareMassge2)
            alert.addAction(shareByEmailAction)
            alert.addAction(info2)
            alert.addAction(unfinish)
            alert.addAction(archive)
            
            let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.finishedTasks.remove(at: indexPath.row )
                self.tableView.reloadData()
            }
            
            alert.addAction(delete)
        } else if indexPath.section == 2 {
            alert.addAction(unArchive)
            alert.addAction(shareByEmailAction)
            alert.addAction(info3)
            alert.addAction(shareMassge3)
            
            let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.archivedTasks.remove(at: indexPath.row )
                self.tableView.reloadData()
            }
            
            alert.addAction(delete)
        }
        
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView(frame: .zero)
        v.backgroundColor = .clear
        
        let lbl = UILabel(frame: CGRect(x: self.view.frame.width/2 - 75, y: 8, width: 150, height: 30))
        v.addSubview(lbl)
        lbl.text = sectionTitles[section]
        lbl.backgroundColor = .systemGray6
        lbl.layer.cornerRadius = 15
        lbl.clipsToBounds = true
        lbl.font = .systemFont(ofSize: 17, weight: .semibold)
        lbl.textColor = .green
        lbl.textAlignment = .center
        if tableView.numberOfRows(inSection: section) == 0 {
            lbl.alpha = 0
        } else {
            lbl.alpha = 1
        }
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAc = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            if indexPath.section == 0{
                self.newTasks.remove(at: indexPath.row)
                self.tableView.reloadData()
            } else if indexPath.section == 1{
                self.finishedTasks.remove(at: indexPath.row)
                self.tableView.reloadData()
            } else if indexPath.section == 2{
                self.archivedTasks.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        }
        let config = UISwipeActionsConfiguration(actions: [deleteAc])
        return config
    }
    
}


extension HomeVC: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            isSearching = false
        } else {
            isSearching = true
        }
        
        filteredTasks = []
        for i in allTasks {
            for j in i {
                if j.title.lowercased().contains(searchText.lowercased()){
                    filteredTasks.append(j)
                    print("search Bar textDid CHange")
                }
            }
            
        }
        tableView.reloadData()
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTasks.count
        print("update search results")
    }
    
    
}
