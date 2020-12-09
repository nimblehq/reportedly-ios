//
//  HomePresenter.swift
//  Reportedly
//
//  Created by Minh Pham on 09/12/2020.
//  
//

final class HomePresenter {

    private let router: HomeRouterInput
    private let interactor: HomeInteractorInput

    weak var view: HomeViewInput?
    weak var output: HomeOutput?

    init(
        router: HomeRouterInput,
        interactor: HomeInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - HomeViewOutput

extension HomePresenter: HomeViewOutput {

    func viewDidLoad() {
        view?.configure()
    }
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
}

// MARK: - HomeInput

extension HomePresenter: HomeInput {
}
