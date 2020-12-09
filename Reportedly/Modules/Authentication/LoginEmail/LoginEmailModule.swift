//
//  LoginEmailModule.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

protocol LoginEmailInput: AnyObject {
    
}

protocol LoginEmailOutput: AnyObject {
    
}

final class LoginEmailModule {
    
    let view: LoginEmailViewController
    let presenter: LoginEmailPresenter
    let interactor: LoginEmailInteractor
    let router: LoginEmailRouter
    
    var output: LoginEmailOutput? {
        get { presenter.output }
        set { presenter.output = newValue }
    }
    
    var input: LoginEmailInput { presenter }
    
    init() {
        view = LoginEmailViewController()
        interactor = LoginEmailInteractor(
            authenticationAPIService: AuthenticationAPIService()
        )
        router = LoginEmailRouter(urlOpener: UIApplication.shared)
        presenter = LoginEmailPresenter(interactor: interactor, router: router)
        
        view.output = presenter
        presenter.view = view
        presenter.output = output
        interactor.output = presenter
        router.view = view
    }
}
