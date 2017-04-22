//
//  RootViewController.swift
//  Boil Clock
//
//  Created by Katya on 21.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit
import LFSideViewController

class RootViewController: LFSideViewController, LFSideViewDelegate
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.contentViewController = storyboard.instantiateViewController(withIdentifier: "NavigationViewController")

        self.leftViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
        
        if let sideViewController = self.sideViewController()
        {
            sideViewController.delegate = self
        }

    }


}
