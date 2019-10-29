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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let specificMeme = memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = specificMeme.topText
        cell.imageView?.image =  specificMeme.memedImage
        return cell
    }
    

    

  
    
}
