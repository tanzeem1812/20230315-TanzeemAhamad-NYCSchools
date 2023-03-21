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
    func fetchDataRequest<T:Decodable>(url:URL,completion:@escaping (Result<T,ErrorCodes>)->Void)
}


class DataTaskAPIService:DataAPIServiceProtocol{

    func fetchDataRequest<T:Decodable>(url:URL,completion:@escaping (Result<T,ErrorCodes>)->Void){
      
        URLSession.shared.dataTask(with: url){ data,response,error in
            var fetchDataResult : Result<T,ErrorCodes>?
       
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode){
                fetchDataResult = .failure(.serverError(ServerCode: response.statusCode))
            }
            if let error = error{
                fetchDataResult = .failure(.error(error: error.localizedDescription))
            }
            if let data = data{
                do{
                    let tmpData  = try JSONDecoder().decode(T.self, from: data)
                    fetchDataResult = .success(tmpData )
                }
                catch{
                    fetchDataResult = .failure(.decodingError)
                }

            }
            completion(fetchDataResult!)
        }.resume()
    }
}
