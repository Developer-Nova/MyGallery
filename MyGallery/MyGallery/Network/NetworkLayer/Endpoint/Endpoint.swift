//
//  Endpoint.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//

import Foundation

protocol RequestResponsable: Requestable, Responsable { }

class Endpoint<Response>: RequestResponsable {
    typealias Response = Response
    var baseURL: String
    var path: String
    var method: HTTPMethod
    var queryParameters: Encodable?
    var bodyParameters: Encodable?
    var headers: [String : String]?
   
    init(
        baseURL: String,
        path: String,
        method: HTTPMethod,
        queryParameters: Encodable? = nil,
        bodyParameters: Encodable? = nil,
        headers: [String : String]? = [:]
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
        self.headers = headers
    }
}
