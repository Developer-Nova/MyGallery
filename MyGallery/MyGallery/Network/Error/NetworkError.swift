//
//  NetworkError.swift
//  MyGallery
//
//  Created by Nova on 6/2/24.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case decodingFailed
    case badResponse(statusCode: Int)
    case emptyData
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "유효하지 않은 URL 입니다."
        case .requestFailed:
            "요청에 실패했습니다. 다시 시도하세요."
        case .invalidResponse:
            "응답이 유효하지 않습니다."
        case .decodingFailed:
            "응답을 디코딩하는데 실패하였습니다. 데이터 타입을 확인하세요."
        case .badResponse(let statusCode):
            "잘못된 응답을 받았습니다. 상태 코드: \(statusCode)"
        case .emptyData:
            "응답 데이터가 비어 있습니다."
        case .unknown:
            "알 수 없는 에러입니다."
        }
    }
}
