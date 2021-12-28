//
//  LoginVC.swift
//  ToDoTaskForExam}
//
//  Created by Zokirov Firdavs on 07/05/21.
//

import UIKit
import MobileCoreServices
import SafariServices

class LoginVC: UIViewController{
    
    
    var datePicker = UIDatePicker()
    var pickerView = UIPickerView()
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var dataTF: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var profilImage: UIImageView!
    
    @IBOutlet weak var safariTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        saveBtn.layer.cornerRadius = saveBtn.frame.height/2
        profilImage.layer.cornerRadius = profilImage.frame.height/2
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        dataTF.inputView = datePicker
        datePicker.addTarget(self, action: #selector(pickerDateChengedValue), for: .valueChanged)
        toolbar()
    }
    @objc func pickerDateChengedValue() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        dataTF.text = dateFormatter.string(from: datePicker.date)
        
    }
    func toolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolbar.isTranslucent = true
        let selectedBtn = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(selectBtnPressed))
        let spaceBtn =  UIBarButtonItem(systemItem: .flexibleSpace)
        selectedBtn.tintColor = .black
        dataTF.inputAccessoryView = toolbar
        
        toolbar.items = [spaceBtn,selectedBtn]
    }
    @objc func selectBtnPressed() {
        if nameTF.isFirstResponder {
            dataTF.resignFirstResponder()
            dataTF.becomeFirstResponder()
        } else {
            dataTF.resignFirstResponder()
        }
    }
    
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        UserDefaults.standard.setValue(true, forKey: "isLogged")
        let vc = TabBarVC(nibName: "TabBarVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
        
        UserDefaults.standard.setValue(nameTF.text!, forKey: "name")
        UserDefaults.standard.setValue(dataTF.text!, forKey: "data")
        if let data = profilImage.image?.jpegData(compressionQuality: 1){
            UserDefaults.standard.setValue(data, forKey: "image")
        }
        UserDefaults.standard.setValue(safariTF.text!, forKey: "safari")
        
        
    }
    
    
    
    
    @IBAction func choosenBtnPressed(_ sender: Any) {
        let vc = UIImagePickerController()
        
        
        vc.sourceType = .photoLibrary
        
        vc.mediaTypes =  [kUTTypeImage as String, kUTTypeMovie as String]
        vc.allowsEditing = true
        vc.delegate = self
        
        present(vc, animated: true, completion: nil)
        vc.modalPresentationStyle = .fullScreen
    }
    
    
}
extension LoginVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaaType = info[UIImagePickerController.InfoKey.mediaType] as! CFString
        
        switch mediaaType {
        case kUTTypeImage:
            print("selected media is image")
            
            let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
            
            profilImage.image = editedImage
            
            
        case kUTTypeMovie:
            print("selected media is movie")
            
            
        default:
            break
        }
        dismiss(animated: true, completion: nil)
    }
}



extension LoginVC : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        4
    }
    
    
}
