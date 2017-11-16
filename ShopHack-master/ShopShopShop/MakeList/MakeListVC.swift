//
//  ViewController.swift
//  ShopShopShop
//
//  Created by Krystyna Swider on 11/15/17.
//  Copyright © 2017 Krystyna Swider. All rights reserved.
//

import UIKit

class MakeListVC: UITableViewController {
    
    var tableData = ["Delicious Apple", "Granny Smith", "Fuji Apple", "California Apple"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "StoreListSegue" {
            let dest = segue.destination as! StoreListVC
            dest.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemsTableViewCell")!
        let oneitem = tableData[indexPath.row]
        cell.textLabel?.text = oneitem
        return cell
        
    }
    
    
        
        
        
        
        
        
        
        

        
        
        
        
}
