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

    func configure()
}

// sourcery: AutoMockable
protocol SubmitReportViewOutput: AnyObject {

    func viewDidLoad()
}

final class SubmitReportViewController: ViewController {

    var output: SubmitReportViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override func setUpColors() {
        super.setUpColors()
        view.backgroundColor = .background
    }
}

// MARK: - SubmitReportViewInput

extension SubmitReportViewController: SubmitReportViewInput {

    func configure() {
        
    }
}
