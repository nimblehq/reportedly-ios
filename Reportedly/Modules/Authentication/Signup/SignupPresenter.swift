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
              let confirmPassword = view?.confirmPasswordFieldText,
              let slackId = view?.slackIdFieldText
        else { return }
        log.debug("Signup button pressed with\nemail: \(email)\npassword: \(password)\nconfirmPassword: \(confirmPassword)\nslackId: \(slackId)")
        
        // TODO: Implement signup API call here
        view?.dismissKeyboard()
        view?.showSuccessOverlayView { [weak self] in
            self?.router.popToRootViewController()
        }
    }
    
    func textFieldsDidChange() {
        let shouldEnableSignupButton = view?.isValidSignupData ?? false
        view?.setSignupButtonEnabled(shouldEnableSignupButton)
    }
}

// MARK: - SignupInteractorOutput

extension SignupPresenter: SignupInteractorOutput {
}

// MARK: - SignupInput

extension SignupPresenter: SignupInput {
}
