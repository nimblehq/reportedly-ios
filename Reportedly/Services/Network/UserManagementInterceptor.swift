//
//  UserManagementInterceptor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/3/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Apollo

class UserManagementInterceptor: ApolloInterceptor {
    
    enum UserError: Error {
        case noUserLoggedIn
    }
    
    /// Helper function to add the token then move on to the next step
    private func addTokenAndProceed<Operation: GraphQLOperation>(
        _ token: Token,
        to request: HTTPRequest<Operation>,
        chain: RequestChain,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        request.addHeader(name: "Authorization", value: "Bearer \(token.value)")
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        guard let token = UserManager.shared.token else {
            // In this instance, no user is logged in, so we want to call
            // the error handler, then return to prevent further work
            chain.handleErrorAsync(UserError.noUserLoggedIn,
                                   request: request,
                                   response: response,
                                   completion: completion)
            return
        }
        
        
        // If we've gotten here, there is a token!
        if token.isExpired {
            // TODO: - Uncomment below code for handling refresh token flow when API supports it
//            // Call an async method to renew the token
//            UserManager.shared.renewToken { [weak self] tokenRenewResult in
//                guard let self = self else {
//                    return
//                }
//
//                switch tokenRenewResult {
//                case .failure(let error):
//                    // Pass the token renewal error up the chain, and do
//                    // not proceed further. Note that you could also wrap this in a
//                    // `UserError` if you want.
//                    chain.handleErrorAsync(error,
//                                           request: request,
//                                           response: response,
//                                           completion: completion)
//                case .success(let token):
//                    // Renewing worked! Add the token and move on
//                    self.addTokenAndProceed(token,
//                                            to: request,
//                                            chain: chain,
//                                            response: response,
//                                            completion: completion)
//                }
//            }
//        } else {
//            // We don't need to wait for renewal, add token and move on
//            self.addTokenAndProceed(token,
//                                    to: request,
//                                    chain: chain,
//                                    response: response,
//                                    completion: completion)
        }
    }
}

