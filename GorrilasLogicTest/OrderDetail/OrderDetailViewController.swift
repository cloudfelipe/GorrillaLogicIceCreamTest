//
//  OrderDetailViewController.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import UIKit

final class OrderDetailViewController: UIViewController, OrderDetailViewType {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var startOrderButton: UIButton!
    
    private var data = [OrderDetailViewData]()
    var presenter: OrderDetailPresenterType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        totalLabel.text = "TOTAL:"
        startOrderButton.setTitle("COMPLETE ORDER", for: .normal)
        startOrderButton.layer.borderWidth = 2.0
        startOrderButton.layer.borderColor = UIColor.white.cgColor
    }
    
    @IBAction func startOrder(_ sender: Any) {
        presenter.startOver()
    }
    
    func setData(with data: [OrderDetailViewData]) {
        self.data = data
        tableView.reloadData()
    }
    
    func setTotalPrice(with price: String) {
        totalPriceLabel.text = price
    }
}

extension OrderDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailCell", for: indexPath) as? OrderDetailCell else {
            preconditionFailure("Cell not registered")
        }
        cell.setup(with: data[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

final class OrderDetailCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setup(with data: OrderDetailViewData) {
        nameLabel.text = data.name
        priceLabel.text = data.price
    }
}
