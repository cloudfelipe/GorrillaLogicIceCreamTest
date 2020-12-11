//
//  OrdenDetailPresenter.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import Foundation

final class OrderDetailPresenter: OrderDetailPresenterType {
 
    private var selectedItems: [IceCream]
    private weak var view: OrderDetailViewType?
    private var coordinator: OrderDetailCoordinator
    
    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    init(items: [IceCream], coordinator: OrderDetailCoordinator) {
        self.selectedItems = items
        self.coordinator = coordinator
    }
    
    func prepareOrder() {
        var totalPrice = 0.0
        let viewData = selectedItems.map { (iceCream) -> OrderDetailViewData in
            let name = iceCream.name1 + " (\(iceCream.selection))"
            let originalPrice = currencyFormatter.number(from: iceCream.price)?.doubleValue ?? 0.0
            let calculatedPrice = originalPrice * Double(iceCream.selection)
            totalPrice += calculatedPrice
            let finalPrice = toCurrency(calculatedPrice)
            return OrderDetailViewData(name: name, price: finalPrice)
        }
        view?.setData(with: viewData)
        view?.setTotalPrice(with: toCurrency(totalPrice))
    }
    
    func toCurrency(_ value: Double) -> String {
        return currencyFormatter.string(from: NSNumber(value: value))!
    }
    
    func bindView(view: OrderDetailViewType) {
        self.view = view
    }
    
    func viewDidLoad() {
        prepareOrder()
    }
    
    func startOver() {
        coordinator.startOver()
    }
}

struct OrderDetailViewData {
    let name: String
    let price: String
}
