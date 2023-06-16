//
//  FormattedString.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 02.06.23.
//

import Foundation

class FormattedDateString {
    
    ///  Преобразует дату из  "yyyy-MM-dd'T'HH:mm:ssZ" в "dd.MM.yyyy"
    /// - Parameter string: <#string description#>
    /// - Returns: <#description#>
    static func getFormattedDateString(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: string) else {
            return ""
        }
        
        let neededDate = DateFormatter()
        neededDate.dateFormat = "dd.MM.yyyy"
        let dateString = neededDate.string(from: date)
        
        return dateString
    }
    
    /// Преобразует дату из "dd.MM.yyyy" в "yyyy-MM-dd'T'HH:mm:ssZ"
    /// - Parameter string: <#string description#>
    /// - Returns: <#description#>
    static func setFormattedDateString(string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        guard let date = dateFormatter.date(from: string) else {
            return ""
        }
        
        let neededDate = DateFormatter()
        neededDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = neededDate.string(from: date)
        
        return dateString
    }
    
    static func getCurrentDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: currentDate)
        let currentFormattedDate = Self.setFormattedDateString(string: result)
        return currentFormattedDate
    }
}
