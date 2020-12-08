//
//  SignupInteractor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/1/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

// sourcery: AutoMockable
protocol SignupInteractorInput: AnyObject {
    
    func signup(email: String, password: String, confirmedPassword: String, slackId: String)
}

// sourcery: AutoMockable
protocol SignupInteractorOutput: AnyObject {
    
    func didSignup()
    func didFailToSignup(error: ResponseError)
}

final class SignupInteractor {
    
    private let authenticationAPIService: AuthenticationAPIServiceProtocol

    weak var output: SignupInteractorOutput?
    
    init(
        authenticationAPIService: AuthenticationAPIServiceProtocol
    ) {
        self.authenticationAPIService = authenticationAPIService
    }
}

// MARK: - SignupInteractorInput

extension SignupInteractor: SignupInteractorInput {
    
    func signup(email: String, password: String, confirmedPassword: String, slackId: String) {
        let request = SignupRequest(
            email: email,
            password: password,
            passwordConfirmation: confirmedPassword,
            slackId: slackId
        )
        authenticationAPIService.signUp(with: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success: self.output?.didSignup()
            case .failure(let error): self.output?.didFailToSignup(error: error)
            }
        }
    }
}
