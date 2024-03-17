import Foundation
import Domain
import KeychainSwift


public final class KeychainRepository: KeychainRepositoryInterface  {
    private let keychain: KeychainSwift = KeychainSwift()

    public init() {}

    public func saveUserKeychain(_ user: Domain.AuthEntity) -> Bool {
        do {
            let jsonData = try JSONEncoder().encode(user)
            let jsonString = String(data: jsonData, encoding: .utf8)
            if jsonString != "" {
                keychain.set(jsonData, forKey: "user")
                return true
            }
            return false
        } catch {
            print("Erro ao codificar objeto em JSON: \(error)")
            return false
        }
    }

    public func saveAuthToken(_ token: String) {
        self.keychain.set(token, forKey: "authToken")
    }

    public func saveRefreshToken(_ refreshToken: String) {
        self.keychain.set(refreshToken, forKey: "refreshToken")
    }

    public func clearKeychain() {
        keychain.clear()
    }
}
