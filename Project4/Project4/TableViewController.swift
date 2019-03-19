//
//  TableViewController.swift
//  Project4
//
//  Created by Mabast on 3/19/19.
//  Copyright © 2019 Mabast. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var websites = ["google.com", "twitter.com", "github.com", "linkedin.com", "hackingwithswift.com"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row].dropLast(4).uppercased()
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebView") as? ViewController{
            vc.websiteSelected = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
