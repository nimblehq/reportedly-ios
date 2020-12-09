//
//  HomeViewController.swift
//  Reportedly
//
//  Created by Minh Pham on 09/12/2020.
//  
//

import UIKit

// sourcery: AutoMockable
protocol HomeViewInput: AnyObject {

    func configure()
}

// sourcery: AutoMockable
protocol HomeViewOutput: AnyObject {

    func viewDidLoad()
}

final class HomeViewController: UIViewController {

    var output: HomeViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - HomeViewInput

extension HomeViewController: HomeViewInput {

    func configure() {
    }
}
