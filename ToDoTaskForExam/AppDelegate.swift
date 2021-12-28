//
//  AppDelegate.swift
//  ToDoTaskForExam
//
//  Created by Zokirov Firdavs on 30/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        var vc: UIViewController?
        if !UserDefaults.standard.bool(forKey: "isRead") {
            vc = WalkThroughtVC(nibName: "WalkThroughtVC", bundle: nil)
        }else {
            vc = HomeVC(nibName: "HomeVC", bundle: nil)
        }
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        
        return true
        
    }
    
    
    
    
}

