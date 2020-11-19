//
//  LoginEmailInteractor.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

protocol LoginEmailInteractorInput: AnyObject {
    
    // TODO: Add login logic functions
}

protocol LoginEmailInteractorOutput: AnyObject {
    
    // TODO: Add login completion callbacks functions
}

final class LoginEmailInteractor: LoginEmailInteractorInput {
    
    weak var output: LoginEmailInteractorOutput?
    
    init(
        // TODO: Add shared managers here
    ) {
        
    }
}

// MARK: - Private Helper

extension LoginEmailInteractor {
    
}
