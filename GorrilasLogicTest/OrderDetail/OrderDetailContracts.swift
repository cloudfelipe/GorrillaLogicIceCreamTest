//
//  OrderDetailContracts.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import Foundation

protocol OrderDetailViewType: AnyObject {
    func setData(with data: [OrderDetailViewData])
    func setTotalPrice(with price: String)
}

protocol OrderDetailPresenterType: AnyObject {
    func bindView(view: OrderDetailViewType)
    func startOver()
    func viewDidLoad()
}

protocol OrderDetailCoordinator {
    func startOver()
}
