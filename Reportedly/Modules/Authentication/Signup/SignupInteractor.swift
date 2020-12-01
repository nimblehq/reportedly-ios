//
//  SignupInteractor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/1/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

// sourcery: AutoMockable
protocol SignupInteractorInput: AnyObject {
}

// sourcery: AutoMockable
protocol SignupInteractorOutput: AnyObject {
}

final class SignupInteractor {

    weak var output: SignupInteractorOutput?
}

// MARK: - SignupInteractorInput

extension SignupInteractor: SignupInteractorInput {
}
