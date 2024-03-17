import Foundation

public protocol KeychainRepositoryInterface {
    func saveUserKeychain(_ user: AuthEntity) -> Bool
    func saveAuthToken(_ token: String)
    func saveRefreshToken(_ refreshToken: String)
    func clearKeychain()
}
