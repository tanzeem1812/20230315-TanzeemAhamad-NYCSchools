//
//  SchoolDataModel.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

// School  Data Model. More fields can be added as per the requirements
struct SchoolDataModel:Decodable{
    var dbn:String
    var school_name:String
    var location:String
    var total_students:String
    // add more fields as per the requirements
 }
