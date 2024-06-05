//
//  URLError.swift
//  MyGallery
//
//  Created by Nova on 6/4/24.
//

import Foundation

enum URLError: Error {
    case URLcomponentsError
    case isEmpty
}

extension URLError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .URLcomponentsError:
            "URL 구성 요소를 생성하는데 실패했습니다."
        case .isEmpty:
            "URL 이 비어 있습니다."
        }
    }
}
