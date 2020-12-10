//
//  ReportsHistoryViewController.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import UIKit

// sourcery: AutoMockable
protocol ReportsHistoryViewInput: AnyObject, CommonViewInput {

    func configure()
}

// sourcery: AutoMockable
protocol ReportsHistoryViewOutput: AnyObject {

    func viewDidLoad()
}

final class ReportsHistoryViewController: ViewController {

    private let backgroundImageView = UIImageView()
    private let transparentLayerView = UIView()
    
    var output: ReportsHistoryViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override func setUpColors() {
        super.setUpColors()
        view.backgroundColor = .background
        
        transparentLayerView.backgroundColor = .overlayLight
    }
}

// MARK: - ReportsHistoryViewInput

extension ReportsHistoryViewController: ReportsHistoryViewInput {

    func configure() {
        setUpLayouts()
        setUpViews()
    }
}

// MARK: - Configure

extension ReportsHistoryViewController {
    
    private func setUpLayouts() {
        view.addSubview(backgroundImageView)
        view.addSubview(transparentLayerView)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        transparentLayerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setUpViews() {
        setUpBackgroundImageView()
    }
}

// MARK: - Main View

extension ReportsHistoryViewController {
    
    private func setUpBackgroundImageView() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.image = Asset.background.reportsHistoryScreen()
    }
}
