//
//  MemeDetailViewController.swift
//  MemeMe0.1-ImagePicker
//
//  Created by William Lewis on 10/30/19.
//  Copyright © 2019 William Lewis. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var specificMeme: AppDelegate.Meme!
    
    var memes: [AppDelegate.Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memesArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.parent!.navigationController!.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = true
        self.imageView!.image = specificMeme.memedImage
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
       
    }

}
