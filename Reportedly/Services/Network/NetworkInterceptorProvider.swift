//
//  NetworkInterceptorProvider.swift
//  Reportedly
//
//  Created by Mikey Pham on 12/3/20.
//  Copyright © 2020 NimbleHQ. All rights reserved.
//

import Apollo

struct NetworkInterceptorProvider: InterceptorProvider {
    
    // These properties will remain the same throughout the life of the `InterceptorProvider`, even though they
    // will be handed to different interceptors.
    private let store: ApolloStore
    private let client: URLSessionClient
    
    init(store: ApolloStore,
         client: URLSessionClient) {
        self.store = store
        self.client = client
    }
    
    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        return [
            MaxRetryInterceptor(),
            LegacyCacheReadInterceptor(store: self.store),
            // TODO: - Uncomment below code for handling refresh token flow when API supports it
//            UserManagementInterceptor(), 
            RequestLoggingInterceptor(),
            NetworkFetchInterceptor(client: self.client),
            ResponseLoggingInterceptor(),
            ResponseCodeInterceptor(),
            LegacyParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
            AutomaticPersistedQueryInterceptor(),
            LegacyCacheWriteInterceptor(store: self.store)
        ]
    }
}

