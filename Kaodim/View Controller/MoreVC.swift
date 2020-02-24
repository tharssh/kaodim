//
//  MoreVC.swift
//  Kaodim
//
//  Created by InsightzClub on 24/02/2020.
//  Copyright © 2020 Tharsshinee. All rights reserved.
//

import UIKit

class MoreVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var moreList = [List]()
    
    @IBOutlet weak var tableView: UITableView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
         //number of cells equals number of elements displayes. No extra cells
        self.tableView.tableFooterView = UIView()

        self.tableView.reloadData()
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreList[0].serviceTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell;
        
        let sections = moreList[indexPath.section].serviceTypes
        let name = sections[indexPath.row].name
        let image = sections[indexPath.row].imageThumbURL?.md ?? ""

        if image != "" {
            Services.setImageFromUrl(image: image, cell: cell)
        }
        else{
            cell.imageView?.image = UIImage(named: "no_image")
        }

        cell.textLabel!.text = name
        
        return cell
    }
}
