//
//  IntroViewController.swift
//  UIPageViewController Post
//
//  Created by Jeffrey Burt on 2/3/16.
//  Copyright © 2016 Seven Even. All rights reserved.
//

import UIKit
import Material

class IntroViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    
    var IntroPageController: IntroPageController? {
        didSet {
            IntroPageController?.introDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.addTarget(self, action: #selector(IntroViewController.didChangePageControlValue), for: .valueChanged)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let IntroPageController = segue.destination as? IntroPageController {
            self.IntroPageController = IntroPageController
        }
    }
    
    func didChangePageControlValue() {
        IntroPageController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension IntroViewController: IntroPageControllerDelegate {
    
    func IntroPageController(IntroPageController: IntroPageController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func IntroPageController(IntroPageController: IntroPageController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}

class SecondIntroController: UIViewController{
    @IBOutlet weak var firstCircleView:UIView!
    @IBOutlet weak var firstIcon:UIImageView!
    @IBOutlet weak var secondCircleView:UIView!
    @IBOutlet weak var secondIcon:UIImageView!
    @IBOutlet weak var thirdCircleView:UIView!
    @IBOutlet weak var thirdIcon:UIImageView!
    override func viewDidLoad() {
        firstIcon.image = Icon.add
        secondIcon.image = Icon.home
        thirdIcon.image = Icon.star
        
        firstCircleView.cornerRadius = firstCircleView.frame.size.width / 2
        firstCircleView.clipsToBounds = true
        secondCircleView.cornerRadius = secondCircleView.frame.size.width / 2
        secondCircleView.clipsToBounds = true
        thirdCircleView.cornerRadius = thirdCircleView.frame.size.width / 2
        thirdCircleView.clipsToBounds = true
    }

}
