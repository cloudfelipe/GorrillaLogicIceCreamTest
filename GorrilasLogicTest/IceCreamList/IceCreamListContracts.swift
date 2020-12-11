//
//  IceCreamListContracts.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import Foundation

protocol IceCreamListViewType: AnyObject {
    func setIceCreams(with: [IceCreamViewData])
    func startLoadingData()
    func stopLoadingData()
    func reload(item: IceCreamViewData, at indexPath: IndexPath)
}

protocol IceCreamListPresenterType: AnyObject {
    func bindView(view: IceCreamListViewType)
    func startOrder()
    func selectElement(at indexPath: IndexPath)
    func startProcess()
}
