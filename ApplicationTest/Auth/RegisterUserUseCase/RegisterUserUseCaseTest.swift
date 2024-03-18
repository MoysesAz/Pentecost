//
//  ApplicationTest.swift
//  ApplicationTest
//
//  Created by Moyses Miranda do Vale Azevedo on 14/03/24.
//

import XCTest
import Domain
import Infra
import FirebaseAuth

@testable import Application

final class RegisterUserUseCaseTest: XCTestCase {

    func test_registerUser_should_complete_with_sucess()  {
        let (sut, repository, error) = makeSut()
        let exp = expectation(description: "waiting")
        sut.handler(makeRegisterUserInput()) { result in
            switch result {
            case .success(let sucess): XCTAssert(sucess == true)
            case .failure: XCTFail("Expected sucess received \(result) instead")
            }
            exp.fulfill()
        }
        repository.completionWithSucess()
        wait(for: [exp], timeout: 1)
    }


}

extension RegisterUserUseCaseTest {
    func makeSut() -> (sut: RegisterUserUseCase, repository: RegisterUserAuthSpy, error: CustomError) {
        let repository = RegisterUserAuthSpy()
        let error = CustomError()
        let sut = RegisterUserUseCase(repository: repository, error: error)
        return (sut, repository, error)
    }

    func makeRegisterUserInput() -> RegisterUserInput {
        return .init(email: "teste@gmail.com", password: "senha123")
    }

    class RegisterUserAuthSpy: RegisterUserAuthRepositoryInterface  {
        var completion: ((Result<Bool, Error>) -> Void)?
        required init() {}
        func registerUser(email: String, password: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
            self.completion = completion
        }

        func completionWithSucess() {
            completion?(.success(true))
        }
//
//        func completionWithFailure() {
//            completion?(.fai(true))
//        }


    }

    class CustomError: Domain.RegisterUserErrorsInterface {
        func handleError(_ error: any Error) -> Domain.RegisterUserErrors {
            return .anyExpected
        }
    }
}
