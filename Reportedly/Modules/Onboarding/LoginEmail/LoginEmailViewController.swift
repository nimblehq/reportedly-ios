//
//  LoginEmailViewController.swift
//  Reportedly
//
//  Created by Mikey Pham on 11/13/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit
import SnapKit

protocol LoginEmailViewInput: AnyObject, CommonViewInput {
    
    var emailFieldText: String? { get }
    var passwordFieldText: String? { get }
    var isValidEmailAndPassword: Bool { get }
    
    func configure()
    func dismissKeyboard()
    func setLoginButtonEnabled(_ isEnabled: Bool)
    // TODO: Add loading states functions here
}

protocol LoginEmailViewOutput: AnyObject {
    
    func viewDidLoad()
    func textFieldsDidChange()
    func didTapLoginButton()
    func didTapSignupLinkView()
}

final class LoginEmailViewController: ViewController {
    
    private let backgroundImageView = UIImageView()
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    private let titleLabel = UILabel()
    private let containerStackView = UIStackView()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let signupLabelWithLinkView = LabelWithLinkView()
    
    var output: LoginEmailViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar = true
        output?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailField.roundCorners(.allCorners, radius: .spacer2)
        passwordField.roundCorners(.allCorners, radius: .spacer2)
        loginButton.roundCorners(.allCorners, radius: .spacer2)
    }
    
    override func setUpTexts() {
        super.setUpTexts()
        titleLabel.text = Localize.moduleLoginEmailHeaderTitle.localized()
        emailField.placeholder = Localize.moduleLoginEmailEmailPlaceholder.localized()
        passwordField.placeholder = Localize.moduleLoginEmailPasswordPlaceholder.localized()
        loginButton.setTitle(Localize.moduleLoginEmailLoginButton.localized(), for: .normal)
        signupLabelWithLinkView.setText(
            labelText: Localize.moduleLoginEmailSignupDescription.localized(),
            linkText: Localize.moduleLoginEmailSignupLink.localized()
        )
        
        // TODO: - Testing purposes, remove when no longer needed
        emailField.text = "minh@nimblehq.co"
        passwordField.text = "12345678"
    }
    
    override func setUpColors() {
        super.setUpColors()
        view.backgroundColor = .background
        
        titleLabel.textColor = .textPrimary
        
        emailField.tintColor = .primary
        emailField.backgroundColor = .forms
        emailField.textColor = .textPrimary
        
        passwordField.tintColor = .primary
        passwordField.backgroundColor = .forms
        passwordField.textColor = .textPrimary
        
        loginButton.setTitleColor(.darkGray, for: .disabled)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.setBackgroundColor(.lightGray, for: .disabled)
        loginButton.setBackgroundColor(.primary, for: .normal)
    }
}

// MARK: - UsernameInputViewInput

extension LoginEmailViewController: LoginEmailViewInput {
    
    var emailFieldText: String? {
        emailField.text
    }
    
    var passwordFieldText: String? {
        passwordField.text
    }
    
    var isValidEmailAndPassword: Bool {
        let emailText = emailFieldText ?? ""
        let passwordText = passwordFieldText ?? ""
        return emailText.isEmail && !passwordText.isEmpty
    }
    
    func configure() {
        setUpLayouts()
        setUpViews()
    }
    
    func dismissKeyboard() {
        dismissKeyboard(nil)
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
            if isValidEmailAndPassword { output?.didTapLoginButton() }
            dismissKeyboard()
        }
        return true
    }
}

// MARK: - LabelLinkView Delegates

extension LoginEmailViewController: LabelLinkViewDelegate {
    
    func labelWithLinkViewDidTapLink(_ linkView: LabelWithLinkView) {
        output?.didTapSignupLinkView()
    }
}

// MARK: - Private Functions

extension LoginEmailViewController {
    
    private func setUpLayouts() {
        let titleContainerView = UIView()
        titleContainerView.addSubview(titleLabel)
        
        containerStackView.addArrangedSubview(emailField)
        containerStackView.addArrangedSubview(passwordField)
        containerStackView.addArrangedSubview(loginButton)
        
        view.addSubview(backgroundImageView)
        view.addSubview(blurEffectView)
        view.addSubview(titleContainerView)
        view.addSubview(containerStackView)
        view.addSubview(signupLabelWithLinkView)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleContainerView.snp.makeConstraints {
            $0.centerX.leading.equalToSuperview()
            $0.top.equalTo(view.snp.topMargin)
            $0.bottom.equalTo(containerStackView.snp.top)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.leading.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
        }
        
        emailField.snp.makeConstraints {
            $0.height.equalTo(CGFloat.spacer9)
        }
        
        passwordField.snp.makeConstraints {
            $0.height.equalTo(emailField.snp.height)
        }
        
        loginButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.spacer9)
        }
        
        signupLabelWithLinkView.snp.makeConstraints {
            $0.leading.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(CGFloat.spacer5)
        }
    }
    
    private func setUpViews() {
        setUpSuperview()
        setUpBackgroundImageView()
        setUpTitleLabel()
        setUpContainerStackView()
        setUpEmailField()
        setUpPasswordField()
        setUpLoginButton()
        setUpSignupLabelWithLinkView()
    }
    
    private func setUpSuperview() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func setUpBackgroundImageView() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = Asset.background.launchScreen()
    }
    
    private func setUpTitleLabel() {
        titleLabel.font = UIFont.appBoldFont(ofSize: .xLarge)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
    }
    
    private func setUpContainerStackView() {
        containerStackView.axis = .vertical
        containerStackView.spacing = .spacer4
    }
    
    private func setUpEmailField() {
        emailField.keyboardType = .emailAddress
        emailField.textContentType = .emailAddress
        emailField.returnKeyType = .next
        emailField.addHorizontalPadding(withValue: CGFloat.spacer2)
        emailField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailField.delegate = self
    }
    
    private func setUpPasswordField() {
        passwordField.isSecureTextEntry = true
        passwordField.textContentType = .password
        passwordField.returnKeyType = .go
        passwordField.addHorizontalPadding(withValue: CGFloat.spacer2)
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.delegate = self
    }
    
    private func setUpLoginButton() {
        // TODO: - Testing purposes, uncomment the below line when no longer needed
//        loginButton.isEnabled = false
        loginButton.titleLabel?.font = UIFont.appBoldFont(ofSize: .regular)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    private func setUpSignupLabelWithLinkView() {
        signupLabelWithLinkView.delegate = self
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

