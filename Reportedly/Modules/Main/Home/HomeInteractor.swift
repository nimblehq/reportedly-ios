//
//  HomeInteractor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

// sourcery: AutoMockable
protocol HomeInteractorInput: AnyObject {
}

// sourcery: AutoMockable
protocol HomeInteractorOutput: AnyObject {
}

final class HomeInteractor {

    weak var output: HomeInteractorOutput?
}

// MARK: - HomeInteractorInput

extension HomeInteractor: HomeInteractorInput {
}
