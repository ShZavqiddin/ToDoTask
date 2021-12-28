//
//  InfoVC.swift
//  ToDoTaskForExam}
//
//  Created by Zokirov Firdavs on 08/05/21.
//

import UIKit

protocol PriorityDelegate1 {
    func didChoosePriority(priority: TaskPriority, color: UIColor, title: String)
}

class InfoVC: UIViewController {

    
    var delegate: PriorityDelegate1?
   
    
    @IBOutlet weak var infoVIew: UIView!
    
    @IBOutlet weak var taskLbl: UILabel!
    
    @IBOutlet weak var desLbl: UILabel!
    var task = ""
    var des = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()

        taskLbl.text = task
        desLbl.text = des
       // dateLbl.text = date
        infoVIew.layer.cornerRadius = infoVIew.frame.height/10
    }


    
    @IBAction func dissmisBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
}



