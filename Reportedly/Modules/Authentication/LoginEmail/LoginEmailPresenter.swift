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
        let shouldEnableLoginButton = view?.isValidEmailAndPassword ?? false
        view?.setLoginButtonEnabled(shouldEnableLoginButton)
    }
    
    func didTapLoginButton() {
        guard let email = view?.emailFieldText, let password = view?.passwordFieldText else { return }
        // TODO: Implement login logic here
        view?.showToastNotification(message: "Login button pressed with\nemail: \(email)\npassword: \(password)")
    }
    
    func didTapSignupLinkView() {
        router.pushSignupScreen()
    }
}

// MARK: - LoginEmailInput

extension LoginEmailPresenter: LoginEmailInput {
    
}

// MARK: - LoginEmailInput

extension LoginEmailPresenter: LoginEmailInteractorOutput {
    
}
