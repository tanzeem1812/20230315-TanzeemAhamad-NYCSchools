//
//  SchoolExtraDBNData.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//

import Foundation

// Extra School Data Model ... Created Hashable to search object fast
// CodingKeys can be used here to keep fieldname short
struct SchoolExtraDataModel:Decodable,Hashable{
    var dbn:String?
    var num_of_sat_test_takers:String?
    var sat_critical_reading_avg_score:String?
    var sat_math_avg_score:String?
    var sat_writing_avg_score:String?
}
