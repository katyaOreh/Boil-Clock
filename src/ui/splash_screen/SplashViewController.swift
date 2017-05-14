//
//  SplashViewController.swift
//  Boil Clock
//
//  Created by Katya on 08.05.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, DataModelProtocol {

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        DataModel.sharedInstance.createCategories()
        DataModel.sharedInstance.delegate = self
        

        DataModel.sharedInstance.getAllDataFromServer
        {
            performSegue(withIdentifier: "showMainScreen", sender: self)
        }
        
        
    }
    
    
    func dataWasLoad()
    {
        performSegue(withIdentifier: "showMainScreen", sender: self)
    }
    
    func dataNotLoad()
    {
        performSegue(withIdentifier: "showMainScreen", sender: self)
    }

}
