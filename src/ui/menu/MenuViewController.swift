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
    var cells = [[]]
    var categories : [ProductCategory] = []
    var texts = ["Категории", "Настройки", "О нас"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        categories = CoreDataManager.sharedInstance.getAllCategories()!
        cells = [categories, [],  []]
    }
    
    @IBAction func homeTapped(_ sender: Any)
    {
        sideViewController()!.hideLeftViewController()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return cells.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cells[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if (cell == nil)
        {
            cell = MenuTableViewCell(style: .default, reuseIdentifier: "cell")
            cell?.selectionStyle       = .none
            cell?.backgroundColor      =  UIColor.clear
            cell?.textLabel?.font      =  UIFont.systemFont(ofSize: 12)
            cell?.textLabel?.textColor =  UIColor.lightGray
        }
        let category = categories[indexPath.row]
        cell?.imageView?.image = UIImage.init(named:category.image_name!)
        cell?.textLabel?.text  = categories[indexPath.row].title
        cell?.separatorInset   = UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 0)
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return CGFloat(45)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.1
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let view = UIView.init(frame: CGRect.init(x: 10, y: 0, width: tableView.frame.width - 10, height: 20))
        let label = UILabel.init(frame: view.frame)
        view.addSubview(label)
        label.text = texts[section]
        label.font = UIFont.systemFont(ofSize: 12)
        
        let line = UIView.init(frame: CGRect.init(x: 12, y: 29.5, width: tableView.frame.width - 12, height: 0.5))
        line.backgroundColor = UIColor.lightGray
        view.addSubview(line)
        
        return view
    }



}
