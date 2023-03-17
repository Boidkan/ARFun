//
//  ARModel.swift
//  ARFun
//
//  Created by e on 3/16/23.
//

import SwiftUI
import RealityKit
import Combine

class ARModel: Identifiable {
    var id: String {
        name
    }
    
    var name: String
    var image: Image
    var entity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(name: String) {
        self.name = name
        self.image = Image(name)
        
        let fileName = name + ".usdz"
        
        cancellable = ModelEntity.loadModelAsync(named: fileName)
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    print("FAILED TO FETCH FILE NAME \(fileName)")
                    print("FAILED TO FETCH \(error)")
                }
            }, receiveValue: { result in
                self.entity = result
            })
    }
}
