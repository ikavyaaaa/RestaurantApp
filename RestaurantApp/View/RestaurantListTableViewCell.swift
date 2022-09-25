//
//  RestaurantListTableViewCell.swift
//  RestaurantApp
//
//  Created by Kavya on 23/09/22.
//

import UIKit

protocol PriceProtocol {
    func itemChanged(price : Int, isAdding : Bool)
}

class RestaurantListTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var viewActions: UIView!
    
    var price : Int = 0
    var delegate : PriceProtocol?
    
    var quantity: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetupUI()
    }

    func initialSetupUI() {
        viewActions.layer.borderColor = UIColor.orange.cgColor
        viewActions.layer.borderWidth = 1.0
        viewActions.layer.cornerRadius = 15
    }
    
    @IBAction func updateCartItemQuantity(_ sender: UIButton) {
        if (sender).tag == 0 {
            quantity = quantity + 1
        } else if quantity > 0 {
            quantity = quantity - 1
        }
        
        btnRemove.isEnabled = quantity > 0
        btnRemove.backgroundColor = !btnRemove.isEnabled ? .white : .white
        self.lblCount.text = String(describing: quantity)
        delegate?.itemChanged(price: price, isAdding: sender.tag == 0 ? true : false)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
