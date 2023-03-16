//
//  SchoolDataManager.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import Foundation

// If more time will be given, proper wrappers(functions) can be introduced in this class to access following data objects (Set and Array)
// Business logic to fetch the data from the data source or makeing API call can be moved in this class

class SchoolDataManager{
    var schoolsExtraData = Set<SchoolExtraDataModel>()
    var schoolsData = [SchoolDataModel]()
}
