//  ViewController.swift
//  LightTunes

//  Created by George Garcia on 4/15/19.
//  Copyright © 2019 GeeTeam. All rights reserved.

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults = [SearchResult]()
    var hasSearched   = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()    // after search button clicked, dismiss the keyboard
        
        searchResults = []
        
        if searchBar.text != "test" {
        for i in 0...2 {
            
            let searchResult        = SearchResult()
            searchResult.name       = String(format: "Fake result %d for ", i)
            searchResult.artistName = searchBar.text!
            
            searchResults.append(searchResult)
          }
        }
        hasSearched = true
        tableView.reloadData() //reloads the table view to make the new rows visible
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached // adds background color of the search bar where it will extend to the top of device making it look cleaner
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        } else {
            return indexPath
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !hasSearched {
            return 0
        } else if searchResults.count == 0 {
            return 1
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SearchResultCell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if searchResults.count == 0 {
            cell.textLabel!.text       = "No results..."
            cell.detailTextLabel!.text = ""
        } else {
            let searchResult           = searchResults[indexPath.row]
            cell.textLabel!.text       = searchResult.name
            cell.detailTextLabel!.text = searchResult.artistName
        }
        
        return cell
    }
    
    
}
