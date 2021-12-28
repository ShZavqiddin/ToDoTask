//
//  TaskCell.swift
//  ToDoTaskForExam
//
//  Created by Zokirov Firdavs on 01/05/21.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDesc: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var priorityView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func updateCell(with task: Task){
        
   //     self.dateLbl.text = task.date
        self.taskTitle.text = task.title
        self.taskDesc.text = task.description
        if task.state == .new {
            backView.backgroundColor = .systemBlue
        } else if task.state == .finished {
           backView.backgroundColor = .systemIndigo
        } else if task.state == .archived {
          backView.backgroundColor = .systemGray2
        }
        
        
        switch task.priority {
        case .heigh:
            self.priorityView.backgroundColor = .red
        case .medium:
            self.priorityView.backgroundColor = .yellow
        case .low:
            self.priorityView.backgroundColor = .green
        case .none:
            self.priorityView.backgroundColor = .systemGray6
        }
    }
    
}



