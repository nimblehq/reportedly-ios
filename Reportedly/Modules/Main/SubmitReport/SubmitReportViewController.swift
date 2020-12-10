//
//  SubmitReportViewController.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

// sourcery: AutoMockable
protocol SubmitReportViewInput: AnyObject, CommonViewInput {

    var plansForTodayText: String? { get }
    var blockingIssuesText: String? { get }
    var isValidReport: Bool { get }
    
    func configure()
    func setSubmitReportButtonEnabled(_ isEnabled: Bool)
}

// sourcery: AutoMockable
protocol SubmitReportViewOutput: AnyObject {

    func viewDidLoad()
    
    func textViewsDidChange()
    func didTapSubmitReportButton()
}

final class SubmitReportViewController: ViewController {

    private let backgroundImageView = UIImageView()
    private let transparentLayerView = UIView()
    private let containerScrollView = UIScrollView()
    private let plansForTodayLabel = UILabel()
    private let plansForTodayTextView = UITextView()
    private let transparentVerticalSeparatorView = UIView()
    private let blockingIssuesLabel = UILabel()
    private let blockingIssuesTextView = UITextView()
    private let submitReportButton = UIButton(type: .system)
    
    var output: SubmitReportViewOutput?
    
    private var currentScrollViewContentHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        plansForTodayTextView.roundCorners(.allCorners, radius: .spacer2)
        blockingIssuesTextView.roundCorners(.allCorners, radius: .spacer2)
        submitReportButton.roundCorners(.allCorners, radius: .spacer2)
    }
    
    override func setUpColors() {
        super.setUpColors()
        view.backgroundColor = .background
        
        transparentLayerView.backgroundColor = .overlayLight
        
        containerScrollView.backgroundColor = .clear
        
        transparentVerticalSeparatorView.backgroundColor = .clear
        
        submitReportButton.setTitleColor(.darkGray, for: .disabled)
        submitReportButton.setTitleColor(.black, for: .normal)
        submitReportButton.setBackgroundColor(.lightGray, for: .disabled)
        submitReportButton.setBackgroundColor(.primary, for: .normal)
    }
    
    override func setUpTexts() {
        super.setUpTexts()
        title = Localize.moduleSubmitReportSubmitReportTitle.localized()
        
        plansForTodayLabel.text = Localize.moduleSubmitReportPlansForTodayTitle.localized()
        
        plansForTodayTextView.tintColor = .primary
        plansForTodayTextView.backgroundColor = .forms
        plansForTodayTextView.textColor = .textPrimary
        
        blockingIssuesLabel.text = Localize.moduleSubmitReportBlockingIssuesTitle.localized()
        
        blockingIssuesTextView.tintColor = .primary
        blockingIssuesTextView.backgroundColor = .forms
        blockingIssuesTextView.textColor = .textPrimary
        
        submitReportButton.setTitle(Localize.moduleSubmitReportSubmitReportButton.localized(), for: .normal)
    }
}

// MARK: - SubmitReportViewInput

extension SubmitReportViewController: SubmitReportViewInput {

    var plansForTodayText: String? {
        plansForTodayTextView.text
    }
    
    var blockingIssuesText: String? {
        blockingIssuesTextView.text
    }
    
    var isValidReport: Bool {
        let plansText = plansForTodayText ?? ""
        let issuesText = blockingIssuesText ?? ""
        return !plansText.isEmpty && !issuesText.isEmpty
    }
    
    func configure() {
        setUpLayouts()
        setUpViews()
    }
    
    func setSubmitReportButtonEnabled(_ isEnabled: Bool) {
        submitReportButton.isEnabled = isEnabled
    }
}

// MARK: - Actions

extension SubmitReportViewController {
    
    @objc private func didTapSubmitReportButton() {
        output?.didTapSubmitReportButton()
    }
    
    @objc private func dismissKeyboard(_ gesture: UIGestureRecognizer? = nil) {
        view.endEditing(true)
    }
}

// MARK: - UITextView Delegates

extension SubmitReportViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        output?.textViewsDidChange()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if currentScrollViewContentHeight == 0 { currentScrollViewContentHeight = containerScrollView.contentSize.height }
        containerScrollView.contentSize = CGSize(width: containerScrollView.contentSize.width, height: currentScrollViewContentHeight + 350)
        containerScrollView.isScrollEnabled = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        containerScrollView.contentSize = CGSize(width: containerScrollView.contentSize.width, height: currentScrollViewContentHeight)
        containerScrollView.contentOffset = CGPoint(x: 0, y: containerScrollView.contentOffset.y)
        containerScrollView.isScrollEnabled = false
    }
}

// MARK: - UIScrollView Delegates

extension SubmitReportViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
}

// MARK: - Configure

extension SubmitReportViewController {
    
    private func setUpLayouts() {
        view.addSubview(backgroundImageView)
        view.addSubview(transparentLayerView)
        view.addSubview(containerScrollView)
        view.addSubview(submitReportButton)
        view.addSubview(plansForTodayLabel)
        
        containerScrollView.addSubview(plansForTodayLabel)
        containerScrollView.addSubview(plansForTodayTextView)
        containerScrollView.addSubview(blockingIssuesLabel)
        containerScrollView.addSubview(blockingIssuesTextView)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        transparentLayerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerScrollView.snp.makeConstraints {
            $0.leading.trailing.width.equalToSuperview()
            $0.top.equalTo(view.snp.topMargin)
            $0.bottom.equalTo(submitReportButton.snp.top).offset(-CGFloat.spacer4)
        }
        
        submitReportButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.spacer9)
            $0.bottom.equalTo(view.snp.bottomMargin).inset(CGFloat.spacer7)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
        }
        
        plansForTodayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(CGFloat.spacer4)
        }
        
        plansForTodayTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(plansForTodayLabel.snp.bottom).offset(CGFloat.spacer4)
            $0.height.equalTo(view.bounds.height / 4.5)
        }
        
        blockingIssuesLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(plansForTodayTextView.snp.bottom).offset(CGFloat.spacer6)
        }
        
        blockingIssuesTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(CGFloat.spacer4)
            $0.trailing.equalToSuperview().inset(CGFloat.spacer4)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(blockingIssuesLabel.snp.bottom).offset(CGFloat.spacer4)
            $0.height.equalTo(view.bounds.height / 4.5)
            $0.bottom.equalToSuperview().offset(CGFloat.spacer4)
        }
        
        view.layoutIfNeeded()
    }
    
    private func setUpViews() {
        setUpSuperview()
        setUpBackgroundImageView()
        setUpContainerScrollView()
        setUpPlansForTodayLabel()
        setUpPlansForTodayTextView()
        setUpBlockingIssuesLabel()
        setUpBlockingIssuesTextView()
        setUpSubmitReportButton()
    }
}

// MARK: - Main View

extension SubmitReportViewController {
    
    private func setUpSuperview() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func setUpBackgroundImageView() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = Asset.background.submitReportScreen()
    }
    
    private func setUpContainerScrollView() {
        containerScrollView.isScrollEnabled = false
        containerScrollView.delegate = self
        containerScrollView.showsHorizontalScrollIndicator = false
        containerScrollView.alwaysBounceHorizontal = false
        containerScrollView.canCancelContentTouches = true
    }
    
    private func setUpSubmitReportButton() {
        submitReportButton.isEnabled = false
        submitReportButton.titleLabel?.font = UIFont.appBoldFont(ofSize: .regular)
        submitReportButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: CGFloat.spacer3, bottom: 0, right: CGFloat.spacer3)
        submitReportButton.addTarget(self, action: #selector(didTapSubmitReportButton), for: .touchUpInside)
    }
    
    private func setUpPlansForTodayLabel() {
        plansForTodayLabel.font = UIFont.appBoldFont(ofSize: .regular)
        plansForTodayLabel.numberOfLines = 0
    }
    
    private func setUpPlansForTodayTextView() {
        plansForTodayTextView.font = UIFont.appFont(ofSize: .small)
        plansForTodayTextView.delegate = self
    }
    
    private func setUpBlockingIssuesLabel() {
        blockingIssuesLabel.font = UIFont.appBoldFont(ofSize: .regular)
        blockingIssuesLabel.numberOfLines = 0
    }
    
    private func setUpBlockingIssuesTextView() {
        blockingIssuesTextView.font = UIFont.appFont(ofSize: .small)
        blockingIssuesTextView.delegate = self
    }
}
