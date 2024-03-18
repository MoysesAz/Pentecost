import Foundation
import Domain

public protocol AuthRepositoryInterface {
    init(_ keychain: KeychainRepositoryInterface)

    func registerUser(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)

    func signIn(email: String, password: String, completion: @escaping (Result<AuthEntity, Error>) -> Void)

    func signIn(_ token: String, completion: @escaping (Result<AuthEntity, Error>) -> Void)

    func getAuthenticatedUser() -> AuthEntity? 

    func getAuthenticatedUserObserver(completion: @escaping (Result<AuthEntity, Error>) -> Void)

    func logout()
}

public protocol RegisterUserAuthRepositoryInterface {
    init() 
    func registerUser(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

