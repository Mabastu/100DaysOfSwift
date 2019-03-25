//
//  ViewController.swift
//  Project7
//
//  Created by Mabast on 3/23/19.
//  Copyright © 2019 Mabast. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetiton = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Petition"
      
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredit))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPetitions))
        
        let urlString: String
            
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                return
            }
        }
            showError()
        
    }
    
    @objc func showCredit(){
        let ac = UIAlertController(title: nil, message: "This data comes from the 'We The People API of the whitehouse!", preferredStyle: .alert)
        ac.addAction((UIAlertAction(title: "Ok", style: .default)))
        present(ac, animated: true)
    }
    
    @objc func filterPetitions(){
        let ac = UIAlertController(title: "Filter With a Word", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Filter", style: .default) {
            _ in
            guard let answer = ac.textFields?[0].text else { return }
            self.petitions = self.filter(answer)
            self.tableView.reloadData()
        })
        present(ac, animated: true)
    }
    
    func showError() {
       let ac = UIAlertController(title: "Loading error", message: "There is a problem loading data, please check your connection and try again!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetition = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetition.results
            tableView.reloadData()
        }
    }
    
    func filter(_ answer: String) -> [Petition]{
        
        for petition in petitions {
            let body = petition.body
            let title = petition.title
            
            if body.contains(answer.lowercased()) || title.contains(answer.lowercased()) {
                filteredPetiton.append(petition)
            }
        }
        return filteredPetiton
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

