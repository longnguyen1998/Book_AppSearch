//
//  ViewController.swift
//  AppSearch
//
//  Created by Nguyễn Đình Thành Long on 12/17/19.
//  Copyright © 2019 Nguyễn Đình Thành Long. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchResults = [SearchResult]()
    var hasSearched = false

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        searchBarSearchButtonClicked(searchBar)
    }


}

extension SearchViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked( _ searchBar : UISearchBar){
        print("The search text is : '\(searchBar.text!)'")
        
        searchBar.resignFirstResponder()
        searchResults = []
        if searchBar.text != "ThanhLong"{
            for i in 0 ... 2 {
                let searchResult = SearchResult()
                searchResult.name = String(format: "Exa %d ", i)
                searchResult.artistName = searchBar.text!
                searchResults.append(searchResult)
            }
        }
        hasSearched = true
        tableView.reloadData()
    }
}

extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    func position(for bar: UIBarPositioning) -> UIBarPosition {     // make better for search bar
        return .topAttached
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasSearched{
            return 0
        }else if searchResults.count == 0 {
            return 1
        }else{
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SearchResultCell"
        
        var cell : UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        if searchResults.count == 0 {
            cell.textLabel!.text = "NotFound"
            cell.detailTextLabel!.text = ""
        }else{
            let searchResult = searchResults[indexPath.row]
            cell.textLabel!.text = searchResult.name
            cell.detailTextLabel!.text = searchResult.artistName
        }
        return cell
    }
    
    //  method will simply deselect the row with an animation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //  you can only select rows when you have actual search results.
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0 {
            return nil
        }else{
            return indexPath
        }
    }

    
}
