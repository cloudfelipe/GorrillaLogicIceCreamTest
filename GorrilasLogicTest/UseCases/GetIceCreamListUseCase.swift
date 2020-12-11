//
//  GetIceCreamListUseCase.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import Foundation

protocol GetIceCreamListUseCaseType {
    func getIceScreams(completion: @escaping RequestResultable<[IceCream]>)
}

final class GetIceCreamListUseCase: GetIceCreamListUseCaseType {
    private var repository: IceCreamRepositoryType
    
    init(repository: IceCreamRepositoryType) {
        self.repository = repository
    }
    
    func getIceScreams(completion: @escaping RequestResultable<[IceCream]>) {
        repository.getIceScreams(completion: completion)
    }
}
