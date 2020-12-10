//
//  LoginEmailInteractor.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

protocol LoginEmailInteractorInput: AnyObject {
    
    func login(email: String, password: String)
}

protocol LoginEmailInteractorOutput: AnyObject {
    
    func didLogin()
    func didFailToLogin(_ error: ResponseError)
}

final class LoginEmailInteractor {
    
    private let authenticationAPIService: AuthenticationAPIServiceProtocol
    
    weak var output: LoginEmailInteractorOutput?
    
    init(
        authenticationAPIService: AuthenticationAPIServiceProtocol
    ) {
        self.authenticationAPIService = authenticationAPIService
    }
}

// MARK: - LoginEmailInteractorInput

extension LoginEmailInteractor: LoginEmailInteractorInput {
    
    func login(email: String, password: String) {
        let request = LoginRequest(
            email: email,
            password: password
        )
        authenticationAPIService.login(with: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                UserManager.shared.user = user
                self.output?.didLogin()
            case .failure(let error):
                self.output?.didFailToLogin(error)
            }
        }
    }
}
