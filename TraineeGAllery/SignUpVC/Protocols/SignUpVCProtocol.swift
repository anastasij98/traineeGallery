//
//  SignUpVCProtocol.swift
//  TraineeGAllery
//
//  Created by LUNNOPARK on 27.06.23.
//

import Foundation

protocol SignUpViewProtocol: AnyObject, AlertMessageProtocol {
    
    func showEmailError()
    func showUserNameError()
    func showBirthdayError()
    func passwordError()
    func confirmPasswordError()
    func showAlertControl()
}
