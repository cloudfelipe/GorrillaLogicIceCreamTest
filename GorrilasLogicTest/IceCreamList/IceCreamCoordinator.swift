//
//  IceCreamCoordinator.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import UIKit

protocol IceCreamCoordinatorType {
    func goToOrder(with items: [IceCream])
}

final class IceCreamCoordinator: IceCreamCoordinatorType {
    
    private var router: UINavigationController
    
    init(router: UINavigationController) {
        self.router = router
    }
    
    func start() {
        let client = ServiceClient()
        let service = IceCreamService(client: client)
        let repository = IceCreamRepository(service: service)
        let getIceCreamUseCase = GetIceCreamListUseCase(repository: repository)
        let dependencies = IceCreamListPresenter.InputDependencies(getIceCreamListUseCase: getIceCreamUseCase, coordinator: self)
        let presenter = IceCreamListPresenter(dependencies: dependencies)
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "IceCreamListViewController") as! IceCreamListViewController
        presenter.bindView(view: viewController)
        viewController.presenter = presenter
        
        router.pushViewController(viewController, animated: false)
    }
    
    func goToOrder(with items: [IceCream]) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "OrderDetailViewController") as! OrderDetailViewController
        let presenter = OrderDetailPresenter(items: items, coordinator: self)
        presenter.bindView(view: viewController)
        viewController.presenter = presenter
        
        router.pushViewController(viewController, animated: true)
    }
    
    func showCompletedOrder() {
        let alert = UIAlertController(title: "Completed!", message: "Order sent", preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .destructive, handler: nil))
        router.present(alert, animated: true, completion: nil)
    }
}

extension IceCreamCoordinator: OrderDetailCoordinator {
    func startOver() {
        router.popViewController(animated: true)
        showCompletedOrder()
        (router.viewControllers.first as? IceCreamListViewController)?.start()
    }
}
