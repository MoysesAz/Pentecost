import Foundation
import Domain

public struct SignInUseCase {
    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func handler(_ input: SignInInput,
                      completion: @escaping (Result<AuthEntity, Error>) -> Void) {

        repository.signIn(email: input.email, password: input.password) { result in
            switch result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
