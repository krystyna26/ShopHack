//
//  ViewController.swift
//  ShopShopShop
//
//  Created by Krystyna Swider on 11/15/17.
//  Copyright © 2017 Krystyna Swider. All rights reserved.
//

import UIKit

class MakeListVC: UIViewController { //it's not a table view controller, it's a view controller with a table view inside of it
    
    var tableData = ["Delicious Apple", "Granny Smith", "Fuji Apple", "California Apple"]
    //test to
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "StoreListSegue" {
            let dest = segue.destination as! StoreListVC
            //            let dest.shoppingList = tableData  comment out for now, but I do need this
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension MakeListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemsTableViewCell")!
        let oneitem = tableData[indexPath.row]
        cell.textLabel?.text = oneitem
        return cell
        
    }
}
















