//
//  RegisterUserInterface.swift
//  Domain
//
//  Created by Moyses Miranda do Vale Azevedo on 17/03/24.
//

import Foundation

public protocol RegisterUserErrorsInterface {
    func handleError(_ error: Error) -> RegisterUserErrors
}
