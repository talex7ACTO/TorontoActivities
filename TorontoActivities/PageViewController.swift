//
//  PageViewController.swift
//  TorontoActivities
//
//  Created by Hamza Lakhani on 2017-01-04.
//  Copyright © 2017 Tomza. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController(name: "Filter"),
                self.newColoredViewController(name: "Facilities")]
        
    }()
    
    private func newColoredViewController(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(name)ViewController")
    }


// MARK: UIPageViewControllerDataSource


public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
        return nil
    }
    
    let previousIndex = viewControllerIndex - 1
    
    guard previousIndex >= 0 else {
        return nil
    }
    
    guard orderedViewControllers.count > previousIndex else {
        return nil
    }
    
    return orderedViewControllers[previousIndex]
    }

public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
        return nil
    }
    
    let nextIndex = viewControllerIndex + 1
    let orderedViewControllersCount = orderedViewControllers.count
    
    guard orderedViewControllersCount != nextIndex else {
        return nil
    }
    
    guard orderedViewControllersCount > nextIndex else {
        return nil
    }
    
    return orderedViewControllers[nextIndex]
    }
    
public func presentationCount(for pageViewController: UIPageViewController) -> Int{
        return orderedViewControllers.count
        
    }
public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    guard let firstViewController = viewControllers?.first,
        let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
            return 0
    }
    
    return firstViewControllerIndex
    
    }
    

}
