//
//  SignupPresenter.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/1/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

final class SignupPresenter {

    private let router: SignupRouterInput
    private let interactor: SignupInteractorInput

    weak var view: SignupViewInput?
    weak var output: SignupOutput?

    init(
        router: SignupRouterInput,
        interactor: SignupInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SignupViewOutput

extension SignupPresenter: SignupViewOutput {
    
    func viewDidLoad() {
        view?.configure()
    }
    
    func didTapSignupButton() {
        guard let email = view?.emailFieldText,
              let password = view?.passwordFieldText,
              let confirmedPassword = view?.confirmPasswordFieldText,
              let slackId = view?.slackIdFieldText
        else { return }
        view?.dismissKeyboard()
        view?.showLoadingView(message: Localize.moduleLoadingMessage.localized())
        interactor.signup(email: email, password: password, confirmedPassword: confirmedPassword, slackId: slackId)
        log.debug("Signup button pressed with\nemail: \(email)\npassword: \(password)\nconfirmPassword: \(confirmedPassword)\nslackId: \(slackId)")
    }
    
    func textFieldsDidChange() {
        let shouldEnableSignupButton = view?.isValidSignupData ?? false
        view?.setSignupButtonEnabled(shouldEnableSignupButton)
    }
}

// MARK: - SignupInteractorOutput

extension SignupPresenter: SignupInteractorOutput {
    
    func didSignup() {
        view?.hideLoadingView()
        view?.showSuccessOverlayView { [weak self] in
            self?.router.popToRootViewController()
        }
    }
    
    func didFailToSignup(error: ResponseError) {
        view?.hideLoadingView()
        view?.showToastNotification(message: error.message)
    }
}

// MARK: - SignupInput

extension SignupPresenter: SignupInput {
}
