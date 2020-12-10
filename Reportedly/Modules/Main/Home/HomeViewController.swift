//
//  HomeViewController.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

// sourcery: AutoMockable
protocol HomeViewInput: AnyObject, CommonViewInput {

    func configure()
    func setCurrentTime(_ time: String)
    func setUser(_ user: User)
}

// sourcery: AutoMockable
protocol HomeViewOutput: AnyObject {

    func viewDidLoad()
    func viewWillAppear()
    func didTapStartReportingButton()
    
    func didTapMenuOptionReportHistoryButton()
    func didTapMenuOptionChannelSubscriptionButton()
    func didTapMenuOptionUserSettingsButton()
    func didTapMenuOptionLogoutButton()
}

final class HomeViewController: ViewController {

    private let backgroundImageView = UIImageView()
    private let transparentLayerView = UIView()
    private let timeLabel = UILabel()
    private let todayLabel = UILabel()
    private let userAvatarImageView = UIImageView()
    private let startReportingButton = UIButton(type: .system)
    
    // Right menu
    private let menuContainerView = UIView()
    private let menuUserEmailLabel = UILabel()
    private let menuUserAvatarImageView = UIImageView()
    private let menuHorizontalSeperatorView = UIView()
    private let menuOptionsContainerStackView = UIStackView()
    private let menuOptionReportHistoryButton = UIButton(type: .system)
    private let menuOptionChannelSubscriptionButton = UIButton(type: .system)
    private let menuOptionUserSettingsButton = UIButton(type: .system)
    private let menuOptionLogoutButton = UIButton(type: .system)
    
    private var rightMenuIsShowing = false
    
    var output: HomeViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar = true
        output?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startReportingButton.roundCorners(.allCorners, radius: .spacer2)
    }
    
    override func setUpTexts() {
        super.setUpTexts()
        timeLabel.text = ""
        todayLabel.text = Localize.moduleHomeTodayTitle.localized()
        startReportingButton.setTitle(Localize.moduleHomeStartReportingButton.localized(), for: .normal)
        
        // Right Menu
        // TODO: Update with actual user's email
        menuUserEmailLabel.text = "User"
        menuOptionReportHistoryButton.setTitle(Localize.moduleHomeMenuReportHistoryOption.localized(), for: .normal)
        menuOptionChannelSubscriptionButton.setTitle(Localize.moduleHomeMenuChannelSubscriptionOption.localized(), for: .normal)
        menuOptionUserSettingsButton.setTitle(Localize.moduleHomeMenuUserSettingsOption.localized(), for: .normal)
        menuOptionLogoutButton.setTitle(Localize.moduleHomeMenuLogoutOption.localized(), for: .normal)
    }
    
    override func setUpColors() {
        super.setUpColors()
        view.backgroundColor = .background
        
        transparentLayerView.backgroundColor = .overlayLight
        
        timeLabel.textColor = .textPrimary
    
        todayLabel.textColor = .textPrimary
        
        startReportingButton.setTitleColor(.black, for: .normal)
        startReportingButton.setBackgroundColor(.primary, for: .normal)
        
        // Right Menu
        menuContainerView.backgroundColor = .overlay
        
        menuUserEmailLabel.textColor = .textPrimary
        
        menuHorizontalSeperatorView.backgroundColor = .gray
        
        menuOptionReportHistoryButton.setTitleColor(.lightGray, for: .normal)
        menuOptionReportHistoryButton.setBackgroundColor(.clear, for: .normal)
        
        menuOptionChannelSubscriptionButton.setTitleColor(.lightGray, for: .normal)
        menuOptionChannelSubscriptionButton.setBackgroundColor(.clear, for: .normal)
        
        menuOptionUserSettingsButton.setTitleColor(.lightGray, for: .normal)
        menuOptionUserSettingsButton.setBackgroundColor(.clear, for: .normal)
        
        menuOptionLogoutButton.setTitleColor(.lightGray, for: .normal)
        menuOptionLogoutButton.setBackgroundColor(.clear, for: .normal)
    }
}

// MARK: - HomeViewInput

extension HomeViewController: HomeViewInput {

    func configure() {
        setUpLayouts()
        setUpViews()
    }
    
    func setCurrentTime(_ time: String) {
        timeLabel.text = time
    }
    
    func setUser(_ user: User) {
        menuUserEmailLabel.text = user.email
    }
}

// MARK: - Actions

extension HomeViewController {
    
    @objc private func didTapStartReportingButton() {
        output?.didTapStartReportingButton()
    }
    
    @objc private func didTapMenuOptionReportHistoryButton() {
        output?.didTapMenuOptionReportHistoryButton()
    }
    
    @objc private func didTapMenuOptionChannelSubscriptionButton() {
        output?.didTapMenuOptionChannelSubscriptionButton()
    }
    
    @objc private func didTapMenuOptionUserSettingsButton() {
        output?.didTapMenuOptionUserSettingsButton()
    }
    
    @objc private func didTapMenuOptionLogoutButton() {
        output?.didTapMenuOptionLogoutButton()
    }
    
    @objc private func handleGesture(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            toggleRightMenu(shouldShow: false)
            break
        case .left:
            toggleRightMenu(shouldShow: true)
        default: break
        }
    }
    
    @objc private func handleUserAvatarTap(_ gesture: UIGestureRecognizer) {
        toggleRightMenu(shouldShow: true)
    }
}

// MARK: - Configure

extension HomeViewController {
    
    private func setUpLayouts() {
        view.addSubview(backgroundImageView)
        view.addSubview(transparentLayerView)
        view.addSubview(timeLabel)
        view.addSubview(todayLabel)
        view.addSubview(userAvatarImageView)
        view.addSubview(startReportingButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        transparentLayerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
            $0.top.equalTo(view.snp.topMargin).offset(CGFloat.spacer11)
        }
        
        todayLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
            $0.top.equalTo(timeLabel.snp.bottom).offset(CGFloat.spacer1)
        }
        
        userAvatarImageView.snp.makeConstraints {
            $0.height.width.equalTo(CGFloat.spacer7)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
            $0.top.equalTo(view.snp.topMargin).offset(CGFloat.spacer11)
        }
        
        startReportingButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.spacer9)
            $0.bottom.equalTo(view.snp.bottomMargin).inset(CGFloat.spacer7)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
        }
        
        // Right menu
        view.addSubview(menuContainerView)
        menuContainerView.addSubview(menuUserEmailLabel)
        menuContainerView.addSubview(menuUserAvatarImageView)
        menuContainerView.addSubview(menuHorizontalSeperatorView)
        menuContainerView.addSubview(menuOptionsContainerStackView)
        menuOptionsContainerStackView.addArrangedSubview(menuOptionReportHistoryButton)
        menuOptionsContainerStackView.addArrangedSubview(menuOptionChannelSubscriptionButton)
        menuOptionsContainerStackView.addArrangedSubview(menuOptionUserSettingsButton)
        menuOptionsContainerStackView.addArrangedSubview(menuOptionLogoutButton)
        
        menuContainerView.snp.makeConstraints {
            $0.centerY.top.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.63)
        }
        menuContainerView.layoutIfNeeded()
        hideRightMenu()
        // Hide the menu beyond the right of the phone's screen by default
        
        
        menuHorizontalSeperatorView.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.4)
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
            $0.height.equalTo(1)
        }
        
        menuUserAvatarImageView.snp.makeConstraints {
            $0.height.width.equalTo(CGFloat.spacer7)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
            $0.bottom.equalTo(menuHorizontalSeperatorView.snp.top).offset(-CGFloat.spacer5)
        }
        
        menuUserEmailLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
            $0.height.equalTo(CGFloat.spacer7)
            $0.top.equalTo(menuUserAvatarImageView.snp.top)
            $0.trailing.equalTo(menuUserAvatarImageView.snp.leading).inset(CGFloat.spacer2)
        }
        
        menuOptionsContainerStackView.snp.makeConstraints {
            $0.leading.centerX.equalToSuperview()
            $0.top.equalTo(menuHorizontalSeperatorView.snp.bottom).offset(CGFloat.spacer6)
        }
        
        menuOptionReportHistoryButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.spacer8)
        }
        
        menuOptionChannelSubscriptionButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.spacer8)
        }
        
        menuOptionUserSettingsButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.spacer8)
        }
        
        menuOptionLogoutButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.spacer8)
        }
    }
    
    private func setUpViews() {
        setUpSuperview()
        setUpBackgroundImageView()
        setUpTimeLabel()
        setUpTodayLabel()
        setUpUserAvatarImageView()
        setUpStartReportingButton()
        
        // Right menu
        setUpMenuUserEmailLabel()
        setUpMenuUserAvatarImageView()
        setUpMenuContainerStackView()
        setUpStartReportingButton()
        setUpMenuOptionReportHistoryButton()
        setUpMenuOptionChannelSubscriptionButton()
        setUpMenuOptionUserSettingsButton()
        setUpMenuOptionLogoutButton()
    }
}

// MARK: - Main View

extension HomeViewController {
    
    private func setUpSuperview() {
        let swipe1 = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        swipe1.direction = .right
        view.addGestureRecognizer(swipe1)
        let swipe2 = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        swipe2.direction = .left
        view.addGestureRecognizer(swipe2)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleUserAvatarTap(_:)))
        userAvatarImageView.addGestureRecognizer(tap)
    }
    
    private func setUpBackgroundImageView() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = Asset.background.homeScreen()
    }
    
    private func setUpTimeLabel() {
        timeLabel.font = UIFont.appBoldFont(ofSize: .xSmall)
        timeLabel.numberOfLines = 1
    }
    
    private func setUpTodayLabel() {
        todayLabel.font = UIFont.appBoldFont(ofSize: .large)
        todayLabel.numberOfLines = 1
    }
    
    private func setUpUserAvatarImageView() {
        userAvatarImageView.contentMode = .scaleAspectFit
        userAvatarImageView.isUserInteractionEnabled = true
        userAvatarImageView.image = Asset.default.userAvatar()
    }
    
    private func setUpStartReportingButton() {
        startReportingButton.titleLabel?.font = UIFont.appBoldFont(ofSize: .regular)
        startReportingButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat.spacer3, bottom: 0, right: CGFloat.spacer3)
        startReportingButton.addTarget(self, action: #selector(didTapStartReportingButton), for: .touchUpInside)
    }
}

// MARK: - Right Menu

extension HomeViewController {
    
    private func toggleRightMenu(shouldShow: Bool) {
        guard rightMenuIsShowing != shouldShow else { return }
        
        rightMenuIsShowing = shouldShow
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 4.0, initialSpringVelocity: 0.8, options: .curveEaseInOut) { [weak self] in
            if shouldShow {
                self?.menuContainerView.transform = .identity
            } else {
                self?.hideRightMenu()
            }
        }
        
    }
    
    private func hideRightMenu() {
        let menuContainerViewWidth = menuContainerView.bounds.width
        menuContainerView.transform = .translation(x: menuContainerViewWidth)
    }
    
    private func setUpMenuUserEmailLabel() {
        menuUserEmailLabel.font = UIFont.appBoldFont(ofSize: .large)
        menuUserEmailLabel.numberOfLines = 1
    }
    
    private func setUpMenuUserAvatarImageView() {
        menuUserAvatarImageView.contentMode = .scaleAspectFit
        menuUserAvatarImageView.image = Asset.default.userAvatar()
    }
    
    private func setUpMenuContainerStackView() {
        menuOptionsContainerStackView.axis = .vertical
        menuOptionsContainerStackView.spacing = 0
    }
    
    private func setUpMenuOptionReportHistoryButton() {
        menuOptionReportHistoryButton.titleLabel?.font = UIFont.appFont(ofSize: .medium)
        menuOptionReportHistoryButton.contentHorizontalAlignment = .left
        menuOptionReportHistoryButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat.spacer4, bottom: 0, right: 0)
        menuOptionReportHistoryButton.addTarget(self, action: #selector(didTapMenuOptionReportHistoryButton), for: .touchUpInside)
    }
    
    private func setUpMenuOptionChannelSubscriptionButton() {
        menuOptionChannelSubscriptionButton.titleLabel?.font = UIFont.appFont(ofSize: .medium)
        menuOptionChannelSubscriptionButton.contentHorizontalAlignment = .left
        menuOptionChannelSubscriptionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat.spacer4, bottom: 0, right: 0)
        menuOptionChannelSubscriptionButton.addTarget(self, action: #selector(didTapMenuOptionChannelSubscriptionButton), for: .touchUpInside)
    }
    
    private func setUpMenuOptionUserSettingsButton() {
        menuOptionUserSettingsButton.titleLabel?.font = UIFont.appFont(ofSize: .medium)
        menuOptionUserSettingsButton.contentHorizontalAlignment = .left
        menuOptionUserSettingsButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat.spacer4, bottom: 0, right: 0)
        menuOptionUserSettingsButton.addTarget(self, action: #selector(didTapMenuOptionUserSettingsButton), for: .touchUpInside)
    }
    
    private func setUpMenuOptionLogoutButton() {
        menuOptionLogoutButton.titleLabel?.font = UIFont.appFont(ofSize: .medium)
        menuOptionLogoutButton.contentHorizontalAlignment = .left
        menuOptionLogoutButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat.spacer4, bottom: 0, right: 0)
        menuOptionLogoutButton.addTarget(self, action: #selector(didTapMenuOptionLogoutButton), for: .touchUpInside)
    }
}
