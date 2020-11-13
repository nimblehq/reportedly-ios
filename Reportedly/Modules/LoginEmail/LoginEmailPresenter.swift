//
//  LoginEmailPresenter.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

final class LoginEmailPresenter {
    
    weak var view: LoginEmailViewInput?
    weak var output: LoginEmailOutput?

    private let interactor: LoginEmailInteractorInput
    private let router: LoginEmailRouterInput

    init(interactor: LoginEmailInteractorInput, router: LoginEmailRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - LoginEmailViewOutput

extension LoginEmailPresenter: LoginEmailViewOutput {
    
    func viewDidLoad() {
        view?.configure()
    }

    func textFieldsDidChange() {
        let email = view?.emailFieldText ?? ""
        let password = view?.passwordFieldText ?? ""
        view?.setLoginButtonEnabled(email.isEmail && !password.isEmpty)
    }

    func didTapLoginButton() {
        guard let email = view?.emailFieldText, let password = view?.passwordFieldText else { return }
        // TODO: Implement login logic here
    }
}

// MARK: - LoginEmailInput

extension LoginEmailPresenter: LoginEmailInput {

    
}

// MARK: - LoginEmailInput

extension LoginEmailPresenter: LoginEmailInteractorOutput {

    
}
