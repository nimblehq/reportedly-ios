//
//  ReportsHistoryInteractor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

// sourcery: AutoMockable
protocol ReportsHistoryInteractorInput: AnyObject {
}

// sourcery: AutoMockable
protocol ReportsHistoryInteractorOutput: AnyObject {
}

final class ReportsHistoryInteractor {

    weak var output: ReportsHistoryInteractorOutput?
}

// MARK: - ReportsHistoryInteractorInput

extension ReportsHistoryInteractor: ReportsHistoryInteractorInput {
}
