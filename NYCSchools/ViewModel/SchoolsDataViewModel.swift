//
//  SchoolsListViewModel.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import Foundation

class SchoolsDataViewModel{
    var apiService:DataAPIServiceProtocol?
    var schoolDataManager = SchoolDataManager()
    init(apiService:DataAPIServiceProtocol? = nil){
        self.apiService = apiService
    }
        
    func fetchSchoolsData(completion:@escaping (Result<[(String,String)],ErrorCodes>)->Void){
        var fetchDataResult: Result<[(String,String)],ErrorCodes>?
        
        let urlStr = Utility.infoForKey("SCHOOLS_DATA_API_URL")!
        if !Utility.isValidURLString(urlStr: urlStr){
            let infoStr = "Function: \(#function), line: \(#line) - Request failed as \(urlStr) is not a valid URL"
            fetchDataResult = .failure(.invalidURL(info: infoStr))
            completion(fetchDataResult!)
            return
        }
        
        let url:URL = URL(string: urlStr)!
        
        apiService?.fetchDataRequest(url:url){[weak self] (result: Result<[SchoolDataModel],ErrorCodes>) in
            switch result{
            case .success(let data):
                self?.schoolDataManager.schoolsData  = data
                let scoolData = self?.schoolDataManager.schoolsData.map {($0.dbn,$0.school_name)}
                fetchDataResult = .success(scoolData!)
            case .failure(let error):
                fetchDataResult = .failure(error)
            }
            completion(fetchDataResult!)
        }
    }
    
    func fetchSchoolsExtraData(dbnStr:String,completion:@escaping (Result<String,ErrorCodes>)->Void){
        var fetchDataResult: Result<String,ErrorCodes>?
        
        let index = self.schoolDataManager.schoolsExtraData.firstIndex(where: {$0.dbn == dbnStr})
        if(index != nil){
            fetchDataResult = .success("DataAvailable")
            completion(fetchDataResult!)
            return
        }
        
        let baseUrlStr = Utility.infoForKey("SCHOOL_EXTRA_DATA_API_URL")!
        let queryStr = baseUrlStr + "?dbn=" + dbnStr
        
        if !Utility.isValidURLString(urlStr: queryStr){
            let infoStr = "Function: \(#function), line: \(#line) - Request failed as \(queryStr) is not a valid URL"
            fetchDataResult = .failure(.invalidURL(info: infoStr))
            completion(fetchDataResult!)
            return
        }
        
        let url:URL = URL(string: queryStr)!
        
        apiService?.fetchDataRequest(url: url){[weak self] (result: Result<[SchoolExtraDataModel],ErrorCodes>) in
            switch result{
            case .success(let data):
                if data.count > 0 {
                    self?.schoolDataManager.schoolsExtraData.insert(data[0])
                    fetchDataResult = .success("DataAvailable")
                }
                else{
                    fetchDataResult = .failure(.dataNotExist)
                }
                
            case .failure(let error):
                fetchDataResult = .failure(error)
            }
            completion(fetchDataResult!)
        }
    }
}

