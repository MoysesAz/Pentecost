import Foundation

public protocol AuthRepositoryInterface {
    init()

    func singIn(email: String, password: String, completion: @escaping (Result<AuthEntity, Error>) -> Void)

    func createUser(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

