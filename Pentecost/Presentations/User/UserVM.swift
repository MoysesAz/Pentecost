import Foundation
import Application
import Infra

final class UserVM: ObservableObject {
    private let useCase: LogoutUseCase

    public init() {
        let repository = AuthRepository()
        useCase = LogoutUseCase(repository: repository)
    }

    public func eventAlertLogoutConfirm() {
        useCase.handler()
    }

}
