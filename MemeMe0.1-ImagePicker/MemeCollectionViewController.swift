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
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [AppDelegate.Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memesArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let space:CGFloat = 1.5
        let dimension = (view.frame.size.width - (2 * space)) / 3.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space   //spacing btw rows
        //item size based on the view frame size so it can easily work for other size screens
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        self.tabBarController?.tabBar.isHidden = false
      
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell
        let specificMeme = self.memes[(indexPath as NSIndexPath).row]

        // Set the name and image
        cell.memeImageView.image = specificMeme.memedImage

        return cell
    }
    
    
    

 
}
