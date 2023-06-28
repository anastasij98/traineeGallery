//
//  FormattedString.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 02.06.23.
//

import Foundation

class FormattedDateString {
    
    ///  Преобразует дату из  "yyyy-MM-dd'T'HH:mm:ssZ" в "dd.MM.yyyy"
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
    
    /// Метод возвращающий текущую дату в виде "yyyy-MM-dd'T'HH:mm:ssZ"
    static func getCurrentDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: currentDate)
        let currentFormattedDate = Self.setFormattedDateString(string: result)
        return currentFormattedDate
    }
}
