//
//  LoginEmailViewController.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit
import SnapKit

protocol LoginEmailViewInput: AnyObject {
    
    var emailFieldText: String { get }
    var passwordFieldText: String { get }

    func configure()
    func setLoginButtonEnabled(_ isEnabled: Bool)
    // TODO: Add loading states functions here
}

protocol LoginEmailViewOutput: AnyObject {
    
    func viewDidLoad()
    func textFieldsDidChange()
    func didTapLoginButton()
}

final class LoginEmailViewController: ViewController {

    private let backgroundImageView = UIImageView()
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let containerStackView = UIStackView()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .custom)
    
    var output: LoginEmailViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar = true
        output?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        emailField.roundCorners(.allCorners, radius: 8)
        passwordField.roundCorners(.allCorners, radius: 8)
        loginButton.roundCorners(.allCorners, radius: 8)
    }
    
    override func setTexts() {
        super.setTexts()
        emailField.placeholder = "Email"
        passwordField.placeholder = "Password"
        loginButton.setTitle("Login", for: .normal)
    }
    
    override func setColors() {
        super.setColors()
        view.backgroundColor = .background
        
        emailField.tintColor = .primary
        emailField.backgroundColor = .forms
        emailField.textColor = .textPrimary
        
        passwordField.tintColor = .primary
        passwordField.backgroundColor = .forms
        passwordField.textColor = .textPrimary
        
        loginButton.setTitleColor(.darkGray, for: .disabled)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.setBackgroundColor(.gray, for: .disabled)
        loginButton.setBackgroundColor(.primary, for: .normal)
    }
}

// MARK: - UsernameInputViewInput

extension LoginEmailViewController: LoginEmailViewInput {
    
    var emailFieldText: String {
        emailField.text ?? ""
    }
    
    var passwordFieldText: String {
        passwordField.text ?? ""
    }
    
    func configure() {
        setUpLayouts()
        setUpViews()
    }

    func setLoginButtonEnabled(_ isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
    }
}

// MARK: - Actions

extension LoginEmailViewController {
    
    @objc private func didTapLoginButton() {
        output?.didTapLoginButton()
    }

    @objc private func dismissKeyboard(_ gesture: UIGestureRecognizer? = nil) {
        view.endEditing(true)
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        output?.textFieldsDidChange()
    }
}

// MARK: - UITextField Delegates

extension LoginEmailViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateContainerStackView(shouldMoveUp: false)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateContainerStackView(shouldMoveUp: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        default:
            output?.didTapLoginButton()
            dismissKeyboard()
        }
        return true
    }
}

// MARK: - Private Functions

extension LoginEmailViewController {
    
    private func setUpLayouts() {
        view.addSubview(backgroundImageView)
        view.addSubview(blurEffectView)
        view.addSubview(containerStackView)
        
        backgroundImageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
        }
        
        containerStackView.addArrangedSubview(emailField)
        containerStackView.addArrangedSubview(passwordField)
        containerStackView.addArrangedSubview(loginButton)
        
        emailField.snp.makeConstraints {
            $0.height.equalTo(56.0)
        }
        
        passwordField.snp.makeConstraints {
            $0.height.equalTo(emailField.snp.height)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(56.0)
        }
    }

    private func setUpViews() {
        setUpSuperview()
        setUpBackgroundImageView()
        setUpContainerStackView()
        setUpEmailField()
        setUpPasswordField()
        setUpLoginButton()
    }

    private func setUpSuperview() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func setUpBackgroundImageView() {
        backgroundImageView.backgroundColor = .red
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = Asset.bg_launch_screen()
    }
    
    private func setUpContainerStackView() {
        containerStackView.axis = .vertical
        containerStackView.spacing = 20
    }

    private func setUpEmailField() {
        emailField.keyboardType = .emailAddress
        emailField.returnKeyType = .next
        emailField.addHorizontalPadding(withValue: 8)
        emailField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailField.delegate = self
    }
    
    private func setUpPasswordField() {
        passwordField.isSecureTextEntry = true
        passwordField.returnKeyType = .go
        passwordField.addHorizontalPadding(withValue: 8)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.delegate = self
    }

    private func setUpLoginButton() {
        loginButton.isEnabled = false
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    private func animateContainerStackView(shouldMoveUp: Bool) {
        containerStackView.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(shouldMoveUp ? 0.75 : 1)
            $0.width.equalToSuperview().multipliedBy(0.85)
        }
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
