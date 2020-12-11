//
//  IceCreamRepository.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import Foundation

protocol IceCreamRepositoryType {
    func getIceScreams(completion: @escaping RequestResultable<[IceCream]>)
}

final class IceCreamRepository: IceCreamRepositoryType {
    private var iceCreamService: IceCreamServiceType
    
    init(service: IceCreamServiceType) {
        self.iceCreamService = service
    }
    
    func getIceScreams(completion: @escaping RequestResultable<[IceCream]>) {
        iceCreamService.getIceScreams { (result) in
            switch result {
            case .success(let apiItems):
                completion(.success(apiItems.map { IceCreamWrapper.map(input: $0) }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

fileprivate final class IceCreamWrapper {
    class func map(input: APIIceCream) -> IceCream {
        IceCream(name1: input.name1, name2: input.name2,
                 price: input.price, bg_color: input.bg_color,
                 type: IceCreamType(rawValue: input.type) ?? IceCreamType.undefined)
    }
}
