//
//  SchoolsListViewModel.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import Foundation

class SchoolsDataViewModel{
    var apiService:DataAPIServiceProtocol?
    var dataManager = SchoolDataManager()
    init(apiService:DataAPIServiceProtocol? = nil){
        self.apiService = apiService
    }
        
    func fetchSchoolsData(completion:@escaping (Result<[(String?,String?)],ErrorCodes>)->Void){
        var fetchDataResult: Result<[(String?,String?)],ErrorCodes>?
        
        let urlStr = Utility.infoForKey("SCHOOLS_DATA_API_URL")!
        if !Utility.isValidURLString(urlStr: urlStr){
            fetchDataResult = .failure(.invalidURL(info: urlStr))
            completion(fetchDataResult!)
            return
        }
        
        let url:URL = URL(string: urlStr)!
        apiService?.fetchDataRequest(url:url){[weak self] (result: Result<[SchoolDataModel],ErrorCodes>) in
            switch result{
            case .success(let data):
                self?.dataManager.setSchoolsData(data:data)
                let schoolData = data.map {($0.dbn,$0.school_name)}
                fetchDataResult = .success(schoolData)
            case .failure(let error):
                fetchDataResult = .failure(error)
            }
            completion(fetchDataResult!)
        }
    }
    
    func fetchSchoolsExtraData(dbnStr:String,completion:@escaping (Result<String,ErrorCodes>)->Void){
        var fetchDataResult: Result<String,ErrorCodes>?
        
        let data = self.dataManager.getExtraSchoolDataFor(dbn: dbnStr)
        if(data != nil){
            fetchDataResult = .success("DataAvailable")
            completion(fetchDataResult!)
            return
        }
        
        let baseUrlStr = Utility.infoForKey("SCHOOL_EXTRA_DATA_API_URL")!
        let urlStr = baseUrlStr + "?dbn=" + dbnStr
        
        if !Utility.isValidURLString(urlStr: urlStr){
             fetchDataResult = .failure(.invalidURL(info: urlStr))
            completion(fetchDataResult!)
            return
        }
        
        let url:URL = URL(string: urlStr)!
        
        apiService?.fetchDataRequest(url: url){[weak self] (result: Result<[SchoolExtraDataModel],ErrorCodes>) in
            switch result{
            case .success(let data):
                if data.count > 0 {
                    self?.dataManager.addExtraSchoolData(data:data[0])
                    fetchDataResult = .success("DataAvailable")
                }
                else{
                    fetchDataResult = .failure(.dataNotFound)
                }
                
            case .failure(let error):
                fetchDataResult = .failure(error)
            }
            completion(fetchDataResult!)
        }
    }
}

