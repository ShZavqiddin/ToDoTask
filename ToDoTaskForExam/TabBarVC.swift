//
//  TabBarVC.swift
//  ToDoTaskForExam}
//
//  Created by Zokirov Firdavs on 07/05/21.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
     
        let vc1 = HomeVC(nibName: "HomeVC", bundle: nil)
        vc1.tabBarItem.title = "New Task"
        vc1.tabBarItem.image = UIImage(systemName: "message")
        vc1.tabBarItem.badgeColor = .blue
        
        let vc2 = ProfilVC(nibName: "ProfilVC", bundle: nil)
        vc2.tabBarItem.title = "Profil"
        vc2.tabBarItem.image = UIImage(systemName: "person.fill")
        vc2.tabBarItem.badgeColor = .red
        
        viewControllers = [vc1, vc2]
    }
    
    
    
}
