//
//  HomeUserViewModel.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/10/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Foundation

struct HomeUserViewModel {

    var email: String = ""
    var avatarUrl: String = ""

    init(from user: User) {
        email = user.email
        avatarUrl = user.avatarUrl
    }
}
