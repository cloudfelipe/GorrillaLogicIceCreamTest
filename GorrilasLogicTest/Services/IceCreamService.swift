//
//  IceCreamService.swift
//  GorrilasLogicTest
//
//  Created by Felipe Correa on 10/12/20.
//  Copyright © 2020 Felipe & Co. Studios. All rights reserved.
//

import Foundation

protocol IceCreamServiceType {
    func getIceScreams(completion: @escaping RequestResultable<[APIIceCream]>)
}

final class IceCreamService: IceCreamServiceType {
    
    private var client: ServiceClientType
    
    init(client: ServiceClientType) {
        self.client = client
    }
    
    func getIceScreams(completion: @escaping RequestResultable<[APIIceCream]>) {
        let urlRequest = URLRequest(url: URL(string: "https://gl-endpoint.herokuapp.com/products")!)
        client.loadRequest(urlRequest: urlRequest, completion: completion)
    }
}
