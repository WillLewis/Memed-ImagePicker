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

        let space:CGFloat = 2.0
        let dimension = (view.frame.size.width - (2 * space)) / 2.0
        let dimension2 = (view.frame.size.height - (2 * space)) / 4.0

        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space  //spacing btw rows
        //item size based on the view frame size so it can easily work for other size screens
        flowLayout.itemSize = CGSize(width: dimension, height: dimension2)
        //flowLayout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.reloadData()
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.specificMeme = self.memes[(indexPath as NSIndexPath).row]
       
        //self.present(detailController, animated: true, completion: nil)
        self.navigationController!.popViewController(animated: true)
        self.navigationController!.pushViewController(detailController, animated: true)
        
        
    }
    

 
}
