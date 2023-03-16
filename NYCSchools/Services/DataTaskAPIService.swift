//
//  DataAPIService.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import Foundation

enum ErrorCodes:Error{
    case serverError(ServerCode:Int)
    case error(error:String)
    case decodingError
    case invalidURL(info:String)
    case dataNotExist
}


protocol DataAPIServiceProtocol{
    var fetchDataResult:Result<Data, ErrorCodes>? {get set}
    func fetchDataRequest(url:URL,completion:@escaping (Result<Data,ErrorCodes>)->Void)
}


class DataTaskAPIService:DataAPIServiceProtocol{
    var fetchDataResult : Result<Data,ErrorCodes>?
    
    func fetchDataRequest(url:URL,completion:@escaping (Result<Data,ErrorCodes>)->Void){
        
        URLSession.shared.dataTask(with: url){ data,response,error in
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                self.fetchDataResult = .failure(.serverError(ServerCode: response.statusCode))
            }
            if let error = error{
                self.fetchDataResult = .failure(.error(error: error.localizedDescription))
            }
            if let data = data{
                self.fetchDataResult = .success(data)
            }
            
            completion(self.fetchDataResult!)
        }.resume()
    }
}
