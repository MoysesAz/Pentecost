import Foundation
import Domain
import KeychainSwift


final class KeychainRepository: KeychainRepositoryInterface  {
    private let keychain: KeychainSwift = KeychainSwift()

    func saveUserKeychain(_ user: Domain.AuthEntity) -> Bool {
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

    func saveAuthToken(_ token: String) {
        self.keychain.set(token, forKey: "authToken")
    }

    func saveRefreshToken(_ refreshToken: String) {
        self.keychain.set(refreshToken, forKey: "refreshToken")
    }

    func clearKeychain() {
        keychain.clear()
    }
}
