//
//  MemeCollectionViewController.swift
//  MemeMe0.1-ImagePicker
//
//  Created by William Lewis on 10/28/19.
//  Copyright © 2019 William Lewis. All rights reserved.
//

import UIKit
import Foundation

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        self.tabBarController?.tabBar.isHidden = false
      
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        let specificMeme = memesArray[(indexPath as NSIndexPath).row]

        // Set the name and image
        cell.memeImageView.image = specificMeme.memedImage

        return cell
    }
    

 
}
