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
    
    // This method return user readable string according to the  the error codes
    static func getErrorMessageForErrorCode(errorCode:ErrorCodes)->String{
        var msg = ""
        
        // Dont use hard coded string, apply localization using NSLocalized  by putting respective strings in the already added localization files
        switch errorCode{
        case .dataNotExist:
            msg = "Data is not available for this request!"
        case .decodingError:
            // Dont use hard coded string, apply localization using NSLocalized
            msg = "Data decoing error!"
        case .invalidURL(let info):
            msg = info
        case .serverError(let serverCode):
            // Dont use hard coded string, apply localization using NSLocalized
            msg = "Server error (code:\(serverCode)"
        case .error(error: let error):
            msg = error
        }
        msg = msg + errorCode.localizedDescription
        return msg
    }
}
