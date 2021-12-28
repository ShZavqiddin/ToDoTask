//
//  PriorityVC.swift
//  ToDoTaskForExam
//
//  Created by Zokirov Firdavs on 30/04/21.
//

import UIKit

protocol PriorityDelegate {
    func didChoosePriority(priority:TaskPriority, color:UIColor, title:String )
}

class PriorityVC: UIViewController {

    
    var delegate:PriorityDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    @IBAction func priorityChoosen(_ sender: UIButton) {
        var choosenPriority:TaskPriority = .none
        
        if sender.tag == 0{
            choosenPriority = .none
        }else if sender.tag == 1{
            choosenPriority = .low
        }else if sender.tag == 2{
            choosenPriority = .medium
        }else{
            choosenPriority = .heigh
        }
        self.delegate?.didChoosePriority(priority: choosenPriority, color: sender.backgroundColor!, title: sender.currentTitle!)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func dismissBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

