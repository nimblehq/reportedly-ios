//
//  RequestLoggingInterceptor.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/3/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Apollo

final class RequestLoggingInterceptor: ApolloInterceptor {
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        log.debug("Outgoing request: \(request)")
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}

