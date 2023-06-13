//
//  String.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 13.06.23.
//

import Foundation

extension String {
    
    //Validate Email
    var isEmailValid: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Za-z0-9]{3,}+@[A-Za-z0-9]{2,}+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    //Validate Password
    var isPasswordValid: Bool {
            let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
            let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$"
            let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
            return passwordCheck.evaluate(with: password)
    }
}
