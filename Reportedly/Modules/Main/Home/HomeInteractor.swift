//
//  HomeInteractor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/9/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol HomeInteractorInput: AnyObject {
    
    var user: User? { get }
    
    func cleanupUserSession()
}

// sourcery: AutoMockable
protocol HomeInteractorOutput: AnyObject {
    
    func didReceieveTokenExpiredEvent()
}

final class HomeInteractor {
    
    private let userManager: UserManager
    
    weak var output: HomeInteractorOutput?
    
    init(
        userManager: UserManager
    ) {
        self.userManager = userManager
        
        // Observe for token expired event
        NotificationCenter.default.addObserver(
            forName: Notification.Name.UserTokenExpired,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                self?.output?.didReceieveTokenExpiredEvent()
            }
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - HomeInteractorInput

extension HomeInteractor: HomeInteractorInput {
    
    var user: User? {
        userManager.user
    }
    
    func cleanupUserSession() {
        userManager.cleanupUserSession()
    }
}
