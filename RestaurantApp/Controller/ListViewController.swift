//
//  ViewController.swift
//  RestaurantApp
//
//  Created by Kavya on 23/09/22.
//

import UIKit

class ListViewController: UIViewController, PriceProtocol {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPlaceOrder: UIButton!
    
    var restDict : [[RestaurantData]] = []
    var sections: [String] = []
    var totalPrice : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetching()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //Fetching data from JSON
    func dataFetching() {
        if let url = Bundle.main.url(forResource: "menu", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let restaurantList = try decoder.decode(DataList.self, from: jsonData)
                for key in restaurantList.keys.sorted() {
                    sections.append(key)
                    let arr = restaurantList[key]!
                    restDict.append(arr)

                }
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    func itemChanged(price: Int, isAdding: Bool) {
        if isAdding {
            totalPrice = totalPrice + price
        } else {
            totalPrice = totalPrice - price
        }
        self.btnPlaceOrder.setTitle("Plce Order $\(self.totalPrice)", for: .normal)
    }
    
    @IBAction func btnPlaceOrderAction(_ sender: Any) {
        
    }
}

//MARK: - Tableview Datasource and Delegate methods
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return restDict.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restDict[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.text = sections[section]
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantListTableViewCell", for: indexPath) as! RestaurantListTableViewCell
        let arr = restDict[indexPath.section]
        cell.lblName.text = arr[indexPath.row].name
        cell.lblPrice.text = "$\(arr[indexPath.row].price)"
        cell.price = arr[indexPath.row].price
        cell.delegate = self
        return cell
    }
}
