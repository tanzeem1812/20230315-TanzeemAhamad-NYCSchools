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
    func fetchJsonData<T:Decodable>(url:URL,completion:@escaping (Result<[T],ErrorCodes>)->Void)
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
    
    func fetchJsonData<T:Decodable>(url:URL,completion:@escaping (Result<[T],ErrorCodes>)->Void){
        var fetchDataResult: Result<[T],ErrorCodes>?
        
        fetchDataRequest(url: url){ result in
            switch result{
            case .success(let data):
                do{
                    let tmpData  = try JSONDecoder().decode([T].self, from: data)
                    fetchDataResult = .success(tmpData)
                }
                catch{
                    fetchDataResult = .failure(.decodingError)
                }
            case .failure(let error):
                fetchDataResult = .failure(error)
            }
            completion(fetchDataResult!)
        }
    }
}
