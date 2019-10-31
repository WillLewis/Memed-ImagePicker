//
//  MemeTableViewController.swift
//  MemeMe0.1-ImagePicker
//
//  Created by William Lewis on 10/28/19.
//  Copyright © 2019 William Lewis. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    //MARK: Properties
    var memes: [AppDelegate.Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memesArray
    }
    
    private let image = UIImage(named: "Docs Icon")!.withRenderingMode(.alwaysTemplate)
    private let topMessage = "Saved Memes"
    private let bottomMessage = "You don't have any saved memes yet. Click the plus sign to create one."
    
    private var rows = [String]()
    private let cellIdentifier = "Cell"

    
    //MARK: Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        //load the placeholder background if table is empty
        func setupEmptyBackgroundView() {
            let emptyBackgroundView = EmptyBackgroundView(image: image, top: topMessage, bottom: bottomMessage)
            self.tableView.backgroundView = emptyBackgroundView
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
        //toggle visibility of EmptyBackground view if table is empty
        if memes.count == 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
    }
    
    //MARK: Helper Functions
    func setupTableView() {
        tableView = UITableView.newAutoLayout()
       // view.addSubview(tableView)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.specificMeme = self.memes[(indexPath as NSIndexPath).row]
        //self.navigationController!.popToViewController(MemeDetailViewController() as UIViewController, animated: true)
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    

    

  
    
}
