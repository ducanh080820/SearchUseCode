//
//  TableViewController.swift
//  SearchUseCode
//
//  Created by Trần Đức Anh on 10/23/18.
//  Copyright © 2018 Trần Đức Anh. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    var nameCity = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                     "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                     "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                     "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                     "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filterData = [String]()
    
    let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        filterData = nameCity
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detaiViewController = segue.destination as? MasterViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
            detaiViewController.dataDetail = String(filterData[indexPath.row])
            }
        }
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        if let fromDetail = unwindSegue.source as? MasterViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let index = nameCity.index(of: filterData[indexPath.row]) {
                    nameCity[index] = fromDetail.dataDetail!
                    filterData[indexPath.row] = fromDetail.dataDetail!
                    search.isActive = true
                }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                filterData.append(fromDetail.dataDetail!)
                filterData = nameCity
                search.isActive = true
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = filterData[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            filterData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
         let searchText = searchController.searchBar.text
        filterData = (searchText?.isEmpty)! ? nameCity : nameCity.filter { (item: String) -> Bool in
            return item.range(of: searchText!, options: .caseInsensitive, range: nil, locale: nil) != nil
        
        }
//        guard let text = searchController.searchBar.text else { return }
//        print(text)
        
           tableView.reloadData()
    }

}
