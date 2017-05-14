//
//  PopupViewController.swift
//  Boil Clock
//
//  Created by Katya on 05.05.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit
import ImageIO


class PopupViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupTransparentView()
    }

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    var backgroundImage: UIImage?
    private func setupTransparentView()
    {

        let context = CIContext(options: nil)
            
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: backgroundImage!)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(5, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
        
        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        backgroundImageView.image = processedImage
    }

    @IBAction func dismissButtonTapped(_ sender: UIButton)
    {
       dismiss(animated: true) 
    }
    
    

}

