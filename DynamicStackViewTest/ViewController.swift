//
//  ViewController.swift
//  DynamicStackViewTest
//
//  Created by Adam Teale on 9/10/18.
//  Copyright © 2018 Adam Teale. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var logo: UIImageView!
    
    var bottomButtonExposed = false
    var bottomButtonExposedTriggered = false
    var logoContraintBottom = NSLayoutConstraint()
    
    @IBOutlet weak var scrollViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonBottomConstraint: NSLayoutConstraint!
    
    var hamburgerOpened = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for a in 0...50 {
            makeView(withText: "hola hola \(a)")
        }
        //setupViewA()
        scrollView.delegate = self
        self.logo.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addConstraint(NSLayoutConstraint(item: logo, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.5, constant: 100))
        view.addConstraint(NSLayoutConstraint(item: logo, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        logoContraintBottom = NSLayoutConstraint(item: logo, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        view.addConstraint(logoContraintBottom)
        
        bottomButtonBottomConstraint.constant = -50

    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.translatesAutoresizingMaskIntoConstraints = false	
        scrollView.contentSize.height = stackView.frame.height
        print(scrollView.contentSize)
        
    }

    func makeView(withText text: String){

        // Number of cases in SubItemType enum
        let totalSubItemTypes : UInt32 = 2
        let randomIndex : Int = Int(arc4random_uniform(totalSubItemTypes))
        let subItem = SubItem(name: "blah", age: 122, type: SubItemType(rawValue: randomIndex)! )


        let viewA = SubItemView.init(withSubItem: subItem)

        self.stackView.addArrangedSubview(viewA)

        viewA.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        viewA.widthAnchor.constraint(equalToConstant: view.frame.width ).isActive = true
//        viewA.widthAnchor.constraint(equalToConstant: view.frame.width + 100 ).isActive = true
//        viewA.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -100)

    }

//    func setupViewA(){
//        let viewA = SubItemView.init(withText: "hola hola")
////        viewA.clipsToBounds = true
////        viewA.translatesAutoresizingMaskIntoConstraints = false
//
//        self.view.addSubview(viewA)
//
//        let heightConstraint = NSLayoutConstraint(item: viewA, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 150)
//        let leadingConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: viewA, attribute: .leading, multiplier: 1.0, constant: 0)
//        let topConstraint = NSLayoutConstraint(item: viewA, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 200)
//        let trailingConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: viewA, attribute: .trailing, multiplier: 1.0, constant: 0)
//        view.addConstraints([leadingConstraint, topConstraint, trailingConstraint, heightConstraint])
//
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//          self.logo.frame.origin.y = 0.5 + (sin(scrollView.contentOffset.y/100) / 2) * view.bounds.height/2

        logoContraintBottom.constant = -((sin(scrollView.contentOffset.y/200) / 2) * view.bounds.height/2)

//        if scrollView.contentOffset.y < 100 {
//            self.logo.frame.origin.y = scrollView.contentOffset.y
//        }else {
//            self.logo.frame.origin.x = self.logo.frame.origin.y - scrollView.contentOffset.y
//        }
        
        for aView in self.stackView.subviews{
            let itemIndex = self.stackView.subviews.index(of: aView)! + 1
            let amount = (scrollView.contentOffset.y / CGFloat(itemIndex)) / 5
            if amount > 0{
                aView.center.x = view.frame.width/2 + sin( amount ) * 50
            }
        }
        
        if scrollView.contentOffset.y < 0 {
            if bottomButtonExposedTriggered == false {
                UIView.animate(withDuration: 0.25) {
                    self.bottomButtonBottomConstraint.constant = self.bottomButtonExposed ? -50 : 50
                    self.bottomButtonExposed = !self.bottomButtonExposed
                    //IMPORTANT
                    self.view.layoutIfNeeded()
                }
            }
            bottomButtonExposedTriggered = true
            
        }else {
            if bottomButtonExposedTriggered == true {
                bottomButtonExposedTriggered = false
            }
        }
    }

        

    @IBAction func hamgburgerClicked(_ sender: Any) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.5)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))

        UIView.animate(withDuration: 0.5) {
            self.scrollViewLeadingConstraint.constant = self.hamburgerOpened ? 0 : 100
            //IMPORTANT
            self.view.layoutIfNeeded()
        }
        
        CATransaction.commit()
        
        hamburgerOpened = !hamburgerOpened
    }
    
    @IBAction func doSomething(_ sender: Any) {
        print("hello from the side")
    }
    
}

