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
        
        //call nib
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
        
    }
    
    struct TableView {
        struct CellIdentifiers {
            static let searchResultCell = "SearchResultCell"
            static let nothingFoundCell = "NothingFoundCell"
        }
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
        
       // let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
        if searchResults.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
            
            let searchResult = searchResults[indexPath.row]
            cell.nameLabel.text = searchResult.name
            cell.artistNameLabel.text = searchResult.artistName
            return cell
        }
        
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}










//      pro code with                TableView.CellIdentifiers.searchResultCell

//extension UITableViewCell {
//
//    var identifier: String {
//        return String(describing: Self.self)
//    }
//    static var identifier: String {
//        return String(describing: Self.self)
//    }
//
//    var nib: UINib {
//        return UINib(nibName: identifier, bundle: nil)
//    }
//    static var nib: UINib {
//        return UINib(nibName: identifier, bundle: nil)
//    }
//
//
//}
