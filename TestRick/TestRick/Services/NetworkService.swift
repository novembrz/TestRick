//
//  NetworkService.swift
//  TestRick
//
//  Created by Kurilova Daria Kirillovna on 07.05.2023.
//

import Foundation

actor NetworkService {
    
    //MARK: - get data
    
    func fetchData<T: Decodable>(urlString: String, model: T.Type) async throws -> T? {
        guard let url = URL(string: urlString) else { return nil}
        let (data, response) = try await URLSession.shared.data(from: url)
        
        return try await decodedResponse(data: data, response: response, type: model.self)
    }
    
    //MARK: - decoded Response
    
    private func decodedResponse<T: Decodable>(data: Data, response: URLResponse, type: T.Type) async throws -> T? {
        guard let httpResponse = response as? HTTPURLResponse
        else { return nil }
        
        guard httpResponse.statusCode == 200
        else { throw try await handleNetworkResponse(httpResponse) }
        
        guard let decodedResponse = try? JSONDecoder().decode(type.self, from: data)
        else { throw NetworkResponseError.unableToDecode }
        
        return decodedResponse
    }
    
    
    //MARK: - handle Network Response
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) async throws -> NetworkResponseError {
        print("🥩", response.statusCode)
        switch response.statusCode {
        case 400...499: return NetworkResponseError.clientError
        case 500...599: return NetworkResponseError.serverError
        default: return NetworkResponseError.unknownError
        }
    }
}
