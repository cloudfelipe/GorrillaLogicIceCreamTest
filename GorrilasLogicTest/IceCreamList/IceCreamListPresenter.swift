//
//  IceCreamListPresenter.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import Foundation

final class IceCreamListPresenter: IceCreamListPresenterType {
    private weak var view: IceCreamListViewType?
    
    private var dependencies: InputDependencies
    private var items = [IceCream]()
    
    init(dependencies: InputDependencies) {
        self.dependencies = dependencies
    }
    
    func getIceCreamList() {
        view?.startLoadingData()
        DispatchQueue.global(qos: .background).async {
            self.dependencies.getIceCreamListUseCase.getIceScreams { [weak self] (result) in
                self?.view?.stopLoadingData()
                print(result)
                switch result {
                case .success(let list):
                    self?.items = list
                    self?.prepareIceCreamList(list)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func bindView(view: IceCreamListViewType) {
        self.view = view
    }
    
    func startOrder() {
        let selectedItems = items.filter { $0.selection > 0 }
        dependencies.coordinator.goToOrder(with: selectedItems)
    }
    
    func selectElement(at indexPath: IndexPath) {
        let iceCream = items[indexPath.row]
        iceCream.select()
        if iceCream.selection > 3 {
            iceCream.restartSelection()
        }
        view?.reload(item: iceCreamViewDataFromModel(iceCream), at: indexPath)
    }
    
    func startProcess() {
        getIceCreamList()
    }
    
    func prepareIceCreamList(_ list: [IceCream] ) {
        let data = list.map { iceCreamViewDataFromModel($0) }
        DispatchQueue.main.async {
            self.view?.setIceCreams(with: data)
        }
    }
    
    func iceCreamViewDataFromModel(_ model: IceCream) -> IceCreamViewData {
        return IceCreamViewData(iconImage: model.type.rawValue, name: model.name1,
                                price: model.price, color: model.bg_color, selection: String(model.selection))
    }
}

struct IceCreamViewData {
    let iconImage: String
    let name: String
    let price: String
    let color: String
    let selection: String
}

extension IceCreamListPresenter {
    struct InputDependencies {
        let getIceCreamListUseCase: GetIceCreamListUseCaseType
        let coordinator: IceCreamCoordinatorType
    }
}
