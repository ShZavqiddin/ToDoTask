//
//  NewTaskVC.swift
//  ToDoTaskForExam
//
//  Created by Zokirov Firdavs on 30/04/21.
//

import UIKit

protocol NewTaskDelegate {
    func didFinishWithTask(task: Task)
}

class NewTaskVC: UIViewController, PriorityDelegate {

    var datePicker = UIDatePicker()
    var pickerView = UIPickerView()
    var pickerViewData = ["Heigh", "Medium", "Low", "None"]
    
    @IBOutlet weak var priorityTF: UITextField!
    @IBOutlet weak var dataTF: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descTxtView: UITextView!
    @IBOutlet weak var priorityBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    var delegate: NewTaskDelegate?
    
    var currentTaskPriority : TaskPriority = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    
        pickerView.delegate = self
        pickerView.dataSource = self
        priorityTF.inputView = pickerView
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        dataTF.inputView = datePicker
        datePicker.addTarget(self, action: #selector(pickerDateChengedValue), for: .valueChanged)
        toolbar()

    }

    @objc func pickerDateChengedValue() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY , HH:mm"
        dataTF.text = dateFormatter.string(from: datePicker.date)
        
    }

    func toolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolbar.isTranslucent = true
        let selectedBtn = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(selectBtnPressed))
        let spaceBtn =  UIBarButtonItem(systemItem: .flexibleSpace)
        selectedBtn.tintColor = .black
        dataTF.inputAccessoryView = toolbar
        priorityTF.inputAccessoryView = toolbar
        toolbar.items = [spaceBtn,selectedBtn]
    }
    
    func setupViews(){
        self.descTxtView.layer.borderWidth = 0.5
        self.descTxtView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    @IBAction func priorityBtnPressed(_ sender: Any) {
        let vc = PriorityVC(nibName: "PriorityVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        if !titleField.text!.isEmpty {
            let task = Task(date: dataTF.text!, title: titleField.text ?? "", description: descTxtView.text ?? "", priority: currentTaskPriority, subtasks: [])
            self.delegate?.didFinishWithTask(task: task)
            dismiss(animated: true, completion: nil)
        } else{
            let alert = UIAlertController(title: "Task title can not be empty", message: "Please write the task title in order to create new task.", preferredStyle: .alert)
            let okBtn = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(okBtn)
            present(alert, animated: true, completion: nil)
        }

    }
    
    
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
       
    @objc func selectBtnPressed() {
        if priorityTF.isFirstResponder {
            priorityTF.resignFirstResponder()
            dataTF.becomeFirstResponder()
        } else {
            dataTF.resignFirstResponder()
        }
    }
    
   
  
    
}




extension NewTaskVC: PriorityDelegate1 {
    func didChoosePriority(priority: TaskPriority, color: UIColor, title: String) {
        self.currentTaskPriority = priority
        self.priorityBtn.setTitle(title, for: .normal)
        self.priorityBtn.backgroundColor = color
}
}


extension NewTaskVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerViewData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerViewData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var choosenPriority: TaskPriority = .none
        if row == 3{
            choosenPriority = .none
        } else if row == 2{
            choosenPriority = .low
        }  else if row == 1{
            choosenPriority = .medium
        }  else if row == 0{
            choosenPriority = .heigh
        }
        
        if choosenPriority == .heigh {
            self.priorityTF.backgroundColor = .systemRed
            self.priorityTF.text = "Heigh"
        } else if choosenPriority == .medium {
            self.priorityTF.backgroundColor = .systemYellow
            self.priorityTF.text = "Medium"
        } else if choosenPriority == .low {
            self.priorityTF.backgroundColor = .systemGreen
            self.priorityTF.text = "Low"
        } else if choosenPriority == .none {
            self.priorityTF.backgroundColor = .systemGray
            self.priorityTF.text = "None"
        }

        self.currentTaskPriority = choosenPriority

    }
    
}




