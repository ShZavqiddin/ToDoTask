//
//  ProfilVC.swift
//  ToDoTaskForExam}
//
//  Created by Zokirov Firdavs on 07/05/21.
//

import UIKit
import SafariServices

class ProfilVC: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var birthDateLbl: UILabel!
    @IBOutlet weak var profilImg: UIImageView!
    @IBOutlet weak var safariBtn: UIButton!
    
    
    var a = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilImg.layer.cornerRadius = profilImg.frame.height/2
        safariBtn.layer.cornerRadius = safariBtn.frame.height/2
        
        nameLbl.text =  UserDefaults.standard.string(forKey: "name")
        birthDateLbl.text =  UserDefaults.standard.string(forKey: "data")
        safariBtn.setTitle(UserDefaults.standard.string(forKey: "safari"), for: .normal)
        
        profilImg.image = getImage()
        
        a = UserDefaults.standard.string(forKey: "userName") ?? ""
       
    }

    func getImage() -> UIImage?{
        if let imageData = UserDefaults.standard.value(forKey: "image") as? Data{
            if let imageFromData = UIImage(data: imageData){
            return imageFromData
            }
        }
        return nil
    }
    
    

    @IBAction func safariBtnPressed(_ sender: Any) {
        let urlApple = "https://" + a
                if let url = URL(string: urlApple){
                    let vc = SFSafariViewController(url: url)
                    vc.delegate = self
                    present(vc, animated: true)
                }
    }
}
