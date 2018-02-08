//
//  CompaniesTableViewController.swift
//  Quests
//
//  Created by Dmitry Valov on 01/04/2017.
//  Copyright © 2017 Dmitry Valov. All rights reserved.
//

import UIKit
import CoreData


class CompaniesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        loadQuests()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults = UserDefaults.standard
        let wasIntroWatched = userDefaults.bool(forKey: "wasIntroWatched")
        
        guard !wasIntroWatched else { return }
        
//        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as? PageViewController {
//            present(pageViewController, animated: true, completion: nil)
//        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate.listOfQuests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CompaniesTableViewCell
        let company:Company = delegate.listOfQuests[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named:company.icon)
        cell.thumbnailImageView.layer.cornerRadius = 5
        cell.thumbnailImageView.clipsToBounds = true
        cell.nameLabel.text = company.name
        cell.locationLabel.text = company.address
        cell.typeLabel.text = company.phone
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let share = UITableViewRowAction(style: .default, title: "Поделиться") { (action, indexPath) in
            let defaultText = "Я был в " + self.delegate.listOfQuests[indexPath.row].name
            if let image = UIImage(named: self.delegate.listOfQuests[indexPath.row].icon) {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        
        share.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return [share]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! CompanyDetailsViewController
                dvc.company =  delegate.listOfQuests[indexPath.row]
            }
        }
    }
    
    func loadQuests() {
        let path = Bundle.main.path(forResource: "quests", ofType: "plist")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        
        let companies = plist as! Array<Dictionary<String, AnyObject>>
        
        for company in companies {
            let _company = Company()
            _company.name = (company["Name"] as! String)
            _company.address = (company["Address"] as! String)
            _company.phone = (company["Phone"] as! String)
            _company.site = (company["Site"] as! String)
            _company.vk = (company["VK"] as! String)
            _company.email = (company["Email"] as! String)
            _company.icon = (company["Icon"] as! String)

            let quests =  (company["Quests"] as! Array<Dictionary<String, AnyObject>>)
            for quest in quests {
                let _quest = Quest()
                _quest.name = (quest["Name"] as! String)
                _quest.shortName = (quest["ShortName"] as! String)
                _quest.capacity = (quest["Capacity"] as! String)
                _quest.duration = (quest["Duration"] as! String)
                _quest.complexity = (quest["Complexity"] as! String)
                _quest.definition = (quest["Description"] as! String)
                _quest.link = (quest["Link"] as! String)

                let images =  (quest["Images"] as! Array<String>)
                for image in images {
                    _quest.addImage(image: image)
                }
                _company.addQuest(quest: _quest)
            }
            
            delegate.listOfQuests.append(_company)
        }
    }
}








