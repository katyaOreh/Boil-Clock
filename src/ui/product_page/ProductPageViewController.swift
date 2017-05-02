//
//  ProductPageViewController.swift
//  Boil Clock
//
//  Created by Katya on 19.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit
import AlamofireImage
import UserNotifications

class ProductPageViewController: UIViewController
{
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var isGrantedNotificationAccess:Bool = false
    
    let starButton = UIButton.init()
    
    var product : Product?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                self.isGrantedNotificationAccess = granted
        })
        
        
        let backButton = UIBarButtonItem.init(image: UIImage.init(named: "back_btn"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(backBtnTapped))
        
        starButton.setImage(UIImage.init(named: "fav_add"), for: .normal)
        
        starButton.addTarget(self, action: #selector(starBtnTapped(_:)), for: .touchUpInside)
        
        starButton.setImage(UIImage.init(named: "fav_del"), for: .selected)
        starButton.sizeToFit()
        let barButton = UIBarButtonItem.init(customView: starButton)
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = barButton
        
        self.descriptionTextView.text = product?.product_description
        self.productNameLabel.text    = product?.title
        
        self.productImageView.af_setImage(withURL: URL.init(string: (product?.image_url!)!)!)

    }
    
    func backBtnTapped()
    {
        _ = navigationController?.popViewController(animated: true)
    }

    
    func starBtnTapped(_ sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
    }

    @IBAction func startTapped(_ sender: UIButton)
    {
        if isGrantedNotificationAccess{
            //add notification code here
            
            //Set the content of the notification
            let content = UNMutableNotificationContent()
            content.title = "10 Second Notification Demo"
            content.subtitle = "From MakeAppPie.com"
            content.body = "Notification after 10 seconds - Your pizza is Ready!!"
            
            //Set the trigger of the notification -- here a timer.
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: 10.0,
                repeats: false)
            
            //Set the request for the notification from the above
            let request = UNNotificationRequest(
                identifier: "10.second.message",
                content: content,
                trigger: trigger
            )
            
            //Add the notification to the currnet notification center
            UNUserNotificationCenter.current().add(
                request, withCompletionHandler: nil)
         //  let alert =  UIAlertController.init(title: "___", message:"" , preferredStyle: .alert)
            
        }
    }

}
