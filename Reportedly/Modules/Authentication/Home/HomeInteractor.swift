//
//  HomeInteractor.swift
//  Reportedly
//
//  Created by Minh Pham on 09/12/2020.
//  
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
