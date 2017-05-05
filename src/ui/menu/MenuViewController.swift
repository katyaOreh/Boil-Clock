//
//  MenuViewController.swift
//  Boil Clock
//
//  Created by Katya on 21.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil)
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.selectionStyle  = .none
            cell?.textLabel?.text = "1222"
            cell?.backgroundColor = UIColor.clear
        }
 


        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return CGFloat(30)
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return UIView()
    }


}
