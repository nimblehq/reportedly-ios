//
//  Configurable.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

protocol Configurable: AnyObject {
    
    associatedtype ViewModel
    
    func configure(with viewModel: ViewModel)
    
}
