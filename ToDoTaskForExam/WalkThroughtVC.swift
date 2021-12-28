//
//  WalkThroughtVC.swift
//  exam
//
//  Created by Zokirov Firdavs on 5/1/21.
//

import UIKit

class WalkThroughtVC: UIViewController {

    @IBOutlet weak var pageControllerOutlet: UIPageControl!
    @IBOutlet weak var nextBtnOutlet: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
       
        
        if pageControllerOutlet.currentPage == 0 {
            count = 0
            scrollView.contentOffset.x = 0
        }
        count += 1
        if count == 1 {
            pageControllerOutlet.currentPage = 1
            scrollView.contentOffset.x = self.view.frame.size.width
        } else if count == 2 {
            scrollView.contentOffset.x = 2 * self.view.frame.size.width
            pageControllerOutlet.currentPage = 2
            self.nextBtnOutlet.setTitle("Go", for: .normal)
        }
        
        if nextBtnOutlet.titleLabel?.text == "Go"{
            let vc = HomeVC(nibName: "HomeVC", bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }else{
            
        }
        
    }
    
    @IBAction func pageControlleerPressed(_ sender: UIPageControl) {
        
        if  sender.currentPage == 0 {
            self.scrollView.contentOffset.x = 0
        } else if sender.currentPage == 1 {
            self.scrollView.contentOffset.x = self.view.frame.size.width
        } else if sender.currentPage == 2 {
            self.scrollView.contentOffset.x = 2 * self.view.frame.size.width
        }
        
    }
    
    
}


extension WalkThroughtVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageControllerOutlet.currentPage = Int(round(Double(scrollView.contentOffset.x) / Double(scrollView.frame.size.width)))
        
        if pageControllerOutlet.currentPage == 2 {
            count = 0
            self.nextBtnOutlet.setTitle("Go", for: .normal)
        } else {
            self.nextBtnOutlet.setTitle("Next", for: .normal)
        }
        
    }
    
}
