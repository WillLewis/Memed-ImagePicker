//
//  MemeTableViewController.swift
//  MemeMe0.1-ImagePicker
//
//  Created by William Lewis on 10/28/19.
//  Copyright © 2019 William Lewis. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
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
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        let specificMeme = memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = specificMeme.topText
        cell.imageView?.image =  specificMeme.memedImage
        return cell
    }
    

    

  
    
}
