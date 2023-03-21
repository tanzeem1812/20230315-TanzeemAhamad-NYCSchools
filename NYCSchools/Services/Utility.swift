//
//  Utility.swift
//  NYCSchools
//
//  Created by Tanzeem Ahamad on 3/15/23.
//


import Foundation

struct Utility{
    // This method validates the URL
    static func isValidURLString(urlStr:String)->Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: urlStr, options: [], range: NSRange(location: 0, length: urlStr.utf16.count)) {
            return match.range.length == urlStr.utf16.count
        } else {
            return false
        }
    }
    
    // This method return key values mentioned in XCConfig File for Prod and dev environment as selected
    static func infoForKey(_ key: String) -> String? {
            return (Bundle.main.infoDictionary?[key] as? String)?
                .replacingOccurrences(of: "\\", with: "")
     }

}
