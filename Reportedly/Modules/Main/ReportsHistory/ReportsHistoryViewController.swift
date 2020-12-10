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

    var output: ReportsHistoryViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override func setUpColors() {
        super.setUpColors()
        view.backgroundColor = .background
    }
}

// MARK: - ReportsHistoryViewInput

extension ReportsHistoryViewController: ReportsHistoryViewInput {

    func configure() {
        
    }
}
