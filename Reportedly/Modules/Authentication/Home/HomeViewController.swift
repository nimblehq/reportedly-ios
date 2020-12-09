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
}

// sourcery: AutoMockable
protocol HomeViewOutput: AnyObject {

    func viewDidLoad()
    func viewWillAppear()
    func didTapStartReportingButton()
}

final class HomeViewController: ViewController {

    private let backgroundImageView = UIImageView()
    private let transparentLayerView = UIView()
    private let timeLabel = UILabel()
    private let todayLabel = UILabel()
    private let userAvatarImageView = UIImageView()
    private let startReportingButton = UIButton(type: .system)
    
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
        userAvatarImageView.roundCorners(.allCorners, radius: .spacer7 / 2)
    }
    
    override func setUpTexts() {
        super.setUpTexts()
        timeLabel.text = ""
        todayLabel.text = Localize.moduleHomeTodayTitle.localized()
        startReportingButton.setTitle(Localize.moduleHomeStartReportingButton.localized(), for: .normal)
    }
    
    override func setUpColors() {
        super.setUpColors()
        view.backgroundColor = .background
        
        transparentLayerView.backgroundColor = .overlayLight
        
        timeLabel.textColor = .textPrimary
    
        todayLabel.textColor = .textPrimary
        
        startReportingButton.setTitleColor(.black, for: .normal)
        startReportingButton.setBackgroundColor(.primary, for: .normal)
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
}

// MARK: - Actions

extension HomeViewController {
    
    @objc private func didTapStartReportingButton() {
        output?.didTapStartReportingButton()
    }
}

// MARK: - Private Functions

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
            $0.top.equalToSuperview().offset(CGFloat.spacer11)
        }
        
        todayLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
            $0.top.equalTo(timeLabel.snp.bottom).offset(CGFloat.spacer1)
        }
        
        userAvatarImageView.snp.makeConstraints {
            $0.height.width.equalTo(CGFloat.spacer7)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
            $0.top.equalToSuperview().offset(CGFloat.spacer11)
        }
        
        startReportingButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.spacer9)
            $0.bottom.equalTo(view.snp.bottomMargin).inset(CGFloat.spacer7)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
        }
    }
    
    private func setUpViews() {
        setUpBackgroundImageView()
        setUpTimeLabel()
        setUpTodayLabel()
        setUpUserAvatarImageView()
        setUpStartReportingButton()
    }
    
    private func setUpBackgroundImageView() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = Asset.background.homeScreen()
    }
    
    private func setUpTimeLabel() {
        timeLabel.font = UIFont.appBoldFont(ofSize: .regular)
        timeLabel.numberOfLines = 1
    }
    
    private func setUpTodayLabel() {
        todayLabel.font = UIFont.appBoldFont(ofSize: .xLarge)
        todayLabel.numberOfLines = 1
    }
    
    private func setUpUserAvatarImageView() {
        userAvatarImageView.contentMode = .scaleAspectFit
        userAvatarImageView.clipsToBounds = true
        userAvatarImageView.image = Asset.default.userAvatar()
    }
    
    private func setUpStartReportingButton() {
        startReportingButton.titleLabel?.font = UIFont.appBoldFont(ofSize: .regular)
        startReportingButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat.spacer3, bottom: 0, right: CGFloat.spacer3)
        startReportingButton.addTarget(self, action: #selector(didTapStartReportingButton), for: .touchUpInside)
    }
}
