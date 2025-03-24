//
//  DrinkListViewController.swift
//  Coffe
//
//  Created by macbook on 22.03.2025.
//

import UIKit
import SwiftUI

class DrinkListViewController: UIViewController {
    var drinks: [Drink] = DummyData.drinks

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension DrinkListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkTableViewCell", for: indexPath)
        let drink = drinks[indexPath.row]
        
        cell.contentConfiguration = UIHostingConfiguration(content: {
            DrinkRow(drink: drink, didClickRow: { })
        })
        
        return cell
    }
}

extension DrinkListViewController: UITableViewDelegate {
    
}
