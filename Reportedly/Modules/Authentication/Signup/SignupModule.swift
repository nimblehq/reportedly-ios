//
//  SignupModule.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/1/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

// sourcery: AutoMockable
protocol SignupInput: AnyObject {
}

// sourcery: AutoMockable
protocol SignupOutput: AnyObject {
}

final class SignupModule {

    let view: SignupViewController
    let presenter: SignupPresenter
    let router: SignupRouter
    let interactor: SignupInteractor

    var output: SignupOutput? {
        get { presenter.output }
        set { presenter.output = newValue }
    }

    var input: SignupInput { presenter }

    init() {
        view = SignupViewController()
        router = SignupRouter()
        interactor = SignupInteractor()
        presenter = SignupPresenter(
            router: router,
            interactor: interactor
        )

        view.output = presenter

        presenter.view = view

        interactor.output = presenter

        router.view = view
    }
}
