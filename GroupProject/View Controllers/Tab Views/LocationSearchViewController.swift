//
//  LocationSearchViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class LocationSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    let debouncer = Debouncer(timeInterval: 2.0)
    
    var locations: [Business] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //Need outlet for map
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        debouncer.handler = {
            guard let searchText = self.searchBar.text else { return }
            BusinessController.shared.fetchBusinessesFromYelp(location: searchText) { (locations) in
                self.locations = locations
                BusinessController.shared.businesses = locations
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                }
            }
        }
    }
    
    //MARK: - TableView Data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }
        let business = locations[indexPath.row]
        let openStatus = business.isClosed ? "CLOSED" : "OPEN"
        let buttonText = "\(business.name)\nJuiceNow™ Rating: \(business.rating)\nCurrently \(openStatus)"
        cell.locationInfo.text = buttonText
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationToLocationDetailVC" {
            if let index = tableView.indexPathForSelectedRow?.row {
                let destinationVC = segue.destination as? LocationDetailsViewController
                //passing location
                let location = locations[index]
                destinationVC?.location = location
                //passing yelp reviews
                
            }
        }
    }
}

//END OF Location Search View Controller

//MARK: - Search bar functionality
extension LocationSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debouncer.renewInterval()
    }
    
}
