import Foundation
import Domain
import Infra

public struct LogoutUseCase {
    private let repository: AuthRepositoryInterface

    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }

    public func handler() {
        repository.logout()
    }
}
