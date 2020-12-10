//
//  SubmitReportInteractor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

// sourcery: AutoMockable
protocol SubmitReportInteractorInput: AnyObject {
}

// sourcery: AutoMockable
protocol SubmitReportInteractorOutput: AnyObject {
}

final class SubmitReportInteractor {

    weak var output: SubmitReportInteractorOutput?
}

// MARK: - SubmitReportInteractorInput

extension SubmitReportInteractor: SubmitReportInteractorInput {
}
