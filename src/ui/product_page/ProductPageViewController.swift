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

class ProductPageViewController: UIViewController, UNUserNotificationCenterDelegate
{
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var viewWithButton: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var timerLabel: UILabel!
    
    var isGrantedNotificationAccess:Bool = false
    
    
    let center = UNUserNotificationCenter.current()
    
    var product : Product?

    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        center.requestAuthorization( options: [.alert,.sound,.badge],
                           completionHandler: { (granted,error) in
                self.isGrantedNotificationAccess = granted
        })
        
        
        let backButton = UIBarButtonItem.init(image: UIImage.init(named: "back_btn"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(backBtnTapped))
        
        let starButton = UIButton()
        
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
        
        center.delegate = self
        reloadUI()

    }
    
    
    func reloadUI()
    {
        var y = 10
        let btnHeight = 30
        for timer in (product?.timers)!
        {
            let btn = UIButton.init(frame: CGRect.init(x: 0, y: y, width: Int(viewWithButton.frame.width), height: btnHeight))
            viewWithButton.addSubview(btn)
            btn.backgroundColor = Constants.Color.lightGreen
            btn.tag = Int((timer as! ProductTimer).duration)
            btn.setTitle((timer as! ProductTimer ).title, for: .normal)
            btn.addTarget(self, action: #selector(startTapped(_:)), for: .touchUpInside)
            btn.layer.cornerRadius = CGFloat(btnHeight / 2)
            
            btn.autoresizingMask = .flexibleWidth
            
            y += 45
        }
        
        heightConstraint.constant = descriptionTextView.frame.height + CGFloat(100 - y);
    }
    
    
    func backBtnTapped()
    {
        _ = navigationController?.popViewController(animated: true)
    }

    
    func starBtnTapped(_ sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
        product?.isFavorite = sender.isSelected
        
    }

    func startTapped(_ sender: UIButton)
    {
        if sender.isSelected == true
        {
            center.removeAllPendingNotificationRequests()
            sender.backgroundColor = Constants.Color.lightGreen
            sender.isSelected = false
        }else{
            sender.backgroundColor = Constants.Color.darkGreen
            sender.isSelected = true
        }
        
        if isGrantedNotificationAccess
        {
            let content = UNMutableNotificationContent()
            content.title = "10 Second Notification Demo"
            content.body = "Notification after 10 seconds - Your pizza is Ready!!"
            content.sound = UNNotificationSound.default()
      
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0,
                                                            repeats: false)

            let request = UNNotificationRequest(identifier: "10.second.message",
                                                   content: content,
                                                   trigger: trigger)
            
            center.add(request, withCompletionHandler: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "productReady"
        {
            let destinationVC = segue.destination as! PopupViewController
            destinationVC.backgroundImage = takeSnapshotOfView()
        }
    }
    
    
    //MARK: - "UNUserNotificationCenterDelegate"
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        performSegue(withIdentifier: "productReady", sender: nil)
    }
    
    
    func takeSnapshotOfView() -> UIImage
    {
        
        UIGraphicsBeginImageContext(CGSize.init(width: view.frame.size.width, height: view.frame.size.height))
        view.drawHierarchy(in: CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
