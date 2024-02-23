import Foundation

public protocol AuthRepositoryInterface {
    init()

    func signIn(email: String, password: String, completion: @escaping (Result<AuthEntity, Error>) -> Void)

    func registerUser(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

