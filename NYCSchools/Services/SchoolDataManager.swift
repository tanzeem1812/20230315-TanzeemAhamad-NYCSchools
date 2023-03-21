//
//  SchoolDataManager.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import Foundation

class SchoolDataManager{
   
    private  var schoolsExtraData = Set<SchoolExtraDataModel>()
    private  var schoolsData = [SchoolDataModel]()
    
    func getSchoolsData() -> [SchoolDataModel] {
        return schoolsData
    }
    
    func setSchoolsData(data:[SchoolDataModel]?){
        if data != nil {
            schoolsData = data!
        }
    }
    
     func getSchoolDataFor(dbn: String) -> SchoolDataModel? {
        guard let data = schoolsData.first(where: {$0.dbn == dbn} ) else { return nil }
        return data
    }
    
     func getSchoolDataForIndex(index:Int)->SchoolDataModel?{
        if index >= 0, index <= schoolsData.count - 1 {
            let data = schoolsData[index]
            return data
        }
        return nil
    }
    
     func addSchoolData(data:SchoolDataModel?){
        if data != nil{
            schoolsData.append(data!)
        }
    }
    
    func getExtraSchoolsData() -> Set<SchoolExtraDataModel> {
        return schoolsExtraData
    }
    
    func setExtraSchoolsData(data:Set<SchoolExtraDataModel>?){
        if data != nil {
            schoolsExtraData = data!
        }
    }
    
     func getExtraSchoolDataFor(dbn: String) -> SchoolExtraDataModel? {
        guard let data = schoolsExtraData.first(where: {$0.dbn == dbn} ) else { return nil }
        return data
    }
    
     func addExtraSchoolData(data:SchoolExtraDataModel?){
        if data != nil{
            schoolsExtraData.insert(data!)
        }
    }
}
