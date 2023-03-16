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
    var dbn:String
    var num_of_sat_test_takers:String
    var sat_critical_reading_avg_score:String
    var sat_math_avg_score:String
    var sat_writing_avg_score:String
    
    init(dbn: String, testTakers: String, critReading: String, mathAvgScore:String, writingAvgScore:String) {
        self.dbn = dbn
        self.num_of_sat_test_takers = testTakers
        self.sat_critical_reading_avg_score = critReading
        self.sat_math_avg_score = mathAvgScore
        self.sat_writing_avg_score = writingAvgScore
    }
    
    static func == (lhs: SchoolExtraDataModel, rhs: SchoolExtraDataModel) -> Bool {
        return lhs.dbn == rhs.dbn
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(dbn)
    }
    
    init(withDbn dbn: String) {
        self.dbn = dbn
        self.num_of_sat_test_takers = ""
        self.sat_critical_reading_avg_score = ""
        self.sat_math_avg_score = ""
        self.sat_writing_avg_score = ""
    }
}
