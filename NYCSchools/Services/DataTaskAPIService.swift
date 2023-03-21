//
//  DataAPIService.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import Foundation

public enum ErrorCodes: Error {
    case serverError(serverCode:Int)
    case error(error:String)
    case decodingError
    case invalidURL(info:String)
    case dataNotFound
}

extension ErrorCodes: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .serverError(let serverCode):
            return NSLocalizedString("Server Error:Code-\(serverCode)", comment: "")
        case .error(let error):
            return NSLocalizedString("Error: \(error)", comment: "")
        case .decodingError:
            return NSLocalizedString("Decoding Error", comment: "")
        case .invalidURL(let info):
            return NSLocalizedString("Invalid URL:\(info)", comment: "")
        case .dataNotFound:
            return NSLocalizedString("Data not found", comment: "")
        }
    }
}

protocol DataAPIServiceProtocol{
    func fetchDataRequest<T:Decodable>(url:URL,completion:@escaping (Result<T,ErrorCodes>)->Void)
}


class DataTaskAPIService:DataAPIServiceProtocol{

    func fetchDataRequest<T:Decodable>(url:URL,completion:@escaping (Result<T,ErrorCodes>)->Void){
      
        URLSession.shared.dataTask(with: url){ data,response,error in
            var fetchDataResult : Result<T,ErrorCodes>?
          
            if let data = data{
                do{
                    let tmpData  = try JSONDecoder().decode(T.self, from: data)
                    fetchDataResult = .success(tmpData )
                }
                catch{
                    fetchDataResult = .failure(.decodingError)
                }
            }
            else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                fetchDataResult = .failure(.serverError(serverCode: response.statusCode))
            }
            else if let error = error{
                fetchDataResult = .failure(.error(error: error.localizedDescription))
            }
          
            completion(fetchDataResult!)
            
        }.resume()
    }
}
