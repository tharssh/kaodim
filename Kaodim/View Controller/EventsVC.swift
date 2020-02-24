//
//  EventsVC.swift
//  Kaodim
//
//  Created by InsightzClub on 22/02/2020.
//  Copyright © 2020 Tharsshinee. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire

class EventsVC: UIViewController{
    
    var events = [List]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EventsCell")
         //number of cells equals number of elements displayes. No extra cells
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Services.getServices(path: "events"){ (results) in
            
            if results != nil {
                
                self.events = results!
                self.tableView.reloadData()
            }else {
                self.events = []
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension EventsVC: UITableViewDelegate, UITableViewDataSource{
    //custom header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
        myLabel.font = UIFont.boldSystemFont(ofSize: 18)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return events.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return events[section].name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if events[section].serviceTypes.count > 4 {
            return 4
        }else{
            return events[section].serviceTypes.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  numberOfRows = numberOfSections(in: tableView.self)
        //multiple cell types
        if (indexPath.row == 3 && numberOfRows > 3){
            let morecell = tableView.dequeueReusableCell(withIdentifier: "more", for:  indexPath) as UITableViewCell
            morecell.textLabel?.textColor = .red
            return morecell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell", for: indexPath) as UITableViewCell;

            let sections = events[indexPath.section].serviceTypes
            let type = sections[indexPath.row].name
            let image = sections[indexPath.row].imageThumbURL?.lg ?? ""

            if image != "" {
                Services.setImageFromUrl(image: image, cell: cell)
            }else{
                cell.imageView?.image = UIImage(named: "no_image")
            }
            cell.textLabel!.text = type
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let  numberOfRows = numberOfSections(in: tableView.self)
        if (indexPath.row == 3 && numberOfRows > 3){
            self.events = [events[indexPath.section]]
            self.performSegue(withIdentifier: "moreEvents", sender: indexPath.row)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreEvents"{
            let destinationVC = segue.destination as! MoreVC
            destinationVC.moreList = self.events
        }
    }
}
