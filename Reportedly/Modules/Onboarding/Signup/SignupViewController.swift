//
//  SignupViewController.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/1/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

protocol SignupViewInput: AnyObject, CommonViewInput {
    
    var emailFieldText: String? { get }
    var passwordFieldText: String? { get }
    var confirmPasswordFieldText: String? { get }
    var slackIdFieldText: String? { get }
    var isValidSignupData: Bool { get }
    
    func configure()
    func dismissKeyboard()
    func setSignupButtonEnabled(_ isEnabled: Bool)
}

protocol SignupViewOutput: AnyObject {
    
    func viewDidLoad()
    func didTapSignupButton()
    func textFieldsDidChange()
}

final class SignupViewController: ViewController {
    
    private let backgroundImageView = UIImageView()
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    private let titleLabel = UILabel()
    private let containerStackView = UIStackView()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let confirmPasswordField = UITextField()
    private let slackIdField = UITextField()
    private let signupButton = UIButton(type: .system)
    
    var output: SignupViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailField.roundCorners(.allCorners, radius: .spacer2)
        passwordField.roundCorners(.allCorners, radius: .spacer2)
        confirmPasswordField.roundCorners(.allCorners, radius: .spacer2)
        slackIdField.roundCorners(.allCorners, radius: .spacer2)
        signupButton.roundCorners(.allCorners, radius: .spacer2)
    }
    
    override func setUpTexts() {
        super.setUpTexts()
        titleLabel.text = Localize.moduleSignupHeaderTitle.localized()
        emailField.placeholder = Localize.moduleSignupEmailPlaceholder.localized()
        passwordField.placeholder = Localize.moduleSignupPasswordPlaceholder.localized()
        confirmPasswordField.placeholder = Localize.moduleSignupConfirmPasswordPlaceholder.localized()
        slackIdField.placeholder = Localize.moduleSignupSlackIdPlaceholder.localized()
        signupButton.setTitle(Localize.moduleSignupSignupButton.localized(), for: .normal)
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
        
        confirmPasswordField.tintColor = .primary
        confirmPasswordField.backgroundColor = .forms
        confirmPasswordField.textColor = .textPrimary
        
        slackIdField.tintColor = .primary
        slackIdField.backgroundColor = .forms
        slackIdField.textColor = .textPrimary
        
        signupButton.setTitleColor(.darkGray, for: .disabled)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.setBackgroundColor(.lightGray, for: .disabled)
        signupButton.setBackgroundColor(.primary, for: .normal)
    }
}

// MARK: - SignupViewInput

extension SignupViewController: SignupViewInput {
    
    var emailFieldText: String? {
        emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var passwordFieldText: String? {
        passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var confirmPasswordFieldText: String? {
        confirmPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var slackIdFieldText: String? {
        slackIdField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var isValidSignupData: Bool {
        let emailText = emailFieldText ?? ""
        let passwordText = passwordFieldText ?? ""
        let confirmPasswordText = confirmPasswordFieldText ?? ""
        let slackIdText = slackIdFieldText ?? ""
        return emailText.isEmail
            && !passwordText.isEmpty
            && !confirmPasswordText.isEmpty
            && passwordText == confirmPasswordText
            && !slackIdText.isEmpty
    }
    
    func configure() {
        setUpLayouts()
        setUpViews()
    }
    
    func dismissKeyboard() {
        dismissKeyboard(nil)
    }
    
    func setSignupButtonEnabled(_ isEnabled: Bool) {
        signupButton.isEnabled = isEnabled
    }
}

// MARK: - UITextField Delegates

extension SignupViewController: UITextFieldDelegate {
    
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
        case passwordField:
            confirmPasswordField.becomeFirstResponder()
        case confirmPasswordField:
            slackIdField.becomeFirstResponder()
        default:
            if isValidSignupData { output?.didTapSignupButton() }
            dismissKeyboard()
        }
        return true
    }
}

// MARK: - Actions

extension SignupViewController {
    
    @objc private func didTapSignupButton() {
        output?.didTapSignupButton()
    }
    
    @objc private func dismissKeyboard(_ gesture: UIGestureRecognizer? = nil) {
        view.endEditing(true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        output?.textFieldsDidChange()
    }
}

// MARK: - Private Functions

extension SignupViewController {
    
    private func setUpLayouts() {
        let titleContainerView = UIView()
        titleContainerView.addSubview(titleLabel)
        
        containerStackView.addArrangedSubview(emailField)
        containerStackView.addArrangedSubview(passwordField)
        containerStackView.addArrangedSubview(confirmPasswordField)
        containerStackView.addArrangedSubview(slackIdField)
        containerStackView.addArrangedSubview(signupButton)
        
        view.addSubview(backgroundImageView)
        view.addSubview(blurEffectView)
        view.addSubview(titleContainerView)
        view.addSubview(containerStackView)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        blurEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleContainerView.snp.makeConstraints {
            $0.centerX.leading.equalToSuperview()
            $0.top.equalTo(view.snp.top)
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
        
        confirmPasswordField.snp.makeConstraints {
            $0.height.equalTo(emailField.snp.height)
        }
        
        slackIdField.snp.makeConstraints {
            $0.height.equalTo(emailField.snp.height)
        }
        
        signupButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.spacer9)
        }
    }
    
    private func setUpViews() {
        setUpSuperview()
        setUpBackgroundImageView()
        setUpTitleLabel()
        setUpContainerStackView()
        setUpEmailField()
        setUpPasswordField()
        setUpConfirmPasswordField()
        setUpSlackIdField()
        setUpSignupButton()
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
        passwordField.autocorrectionType = .no
        passwordField.isSecureTextEntry = true
        passwordField.textContentType = .newPassword
        passwordField.returnKeyType = .next
        passwordField.addHorizontalPadding(withValue: CGFloat.spacer2)
        passwordField.autocorrectionType = .no
        passwordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordField.delegate = self
    }
    
    private func setUpConfirmPasswordField() {
        confirmPasswordField.autocorrectionType = .no
        confirmPasswordField.isSecureTextEntry = true
        confirmPasswordField.textContentType = .newPassword
        confirmPasswordField.returnKeyType = .next
        confirmPasswordField.addHorizontalPadding(withValue: CGFloat.spacer2)
        confirmPasswordField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        confirmPasswordField.delegate = self
    }
    
    private func setUpSlackIdField() {
        slackIdField.returnKeyType = .go
        slackIdField.addHorizontalPadding(withValue: CGFloat.spacer2)
        slackIdField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        slackIdField.delegate = self
    }
    
    private func setUpSignupButton() {
        signupButton.isEnabled = false
        signupButton.titleLabel?.font = UIFont.appBoldFont(ofSize: .regular)
        signupButton.addTarget(self, action: #selector(didTapSignupButton), for: .touchUpInside)
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
