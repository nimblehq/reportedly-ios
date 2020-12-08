//
//  ReachabilityManager.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/8/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Reachability

class ReachabilityManager {

    // MARK: - Public Constants & Variables
    static let shared = ReachabilityManager()

    // MARK: - Public Variables
    var reachability: Reachability!

    // MARK: - Public Computed Variable
    var hasInternet: Bool { reachability.connection == .wifi || reachability.connection == .cellular }

    // MARK: - Init Functions
    init() {
        do {
            // Instantiate reachability
            reachability = try Reachability()
        } catch {
            print("Unable to assign new instance of Reachability")
        }

        // Register an observer for the network status
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)

        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    // MARK: - Private Functions
    @objc private func networkStatusChanged(_ notification: Notification) {
        NotificationCenter.default.post(name: .NetworkStatusChanged, object: nil)
    }
}
