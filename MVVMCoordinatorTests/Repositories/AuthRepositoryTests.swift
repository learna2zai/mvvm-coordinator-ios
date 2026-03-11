import Foundation
import Testing
@testable import MVVMCoordinator


@Suite("AuthRepository basic tests")
struct AuthRepositoryTests {

    @MainActor
    let repository = AuthRepositoryImpl(apiClient: MockApiClient())

    @Test("login returns true")
    func testLogin() async throws {
        let result = try await repository.login(username: "user", password: "pass")
        #expect(result == true, "Mock login should always return true")
    }

    @Test("register returns true")
    func testRegister() async throws {
        let result = try await repository.register(name: "testing", username: "user", password: "pass")
        #expect(result == true, "Mock register should always return true")
    }

    @Test("logout returns true")
    func testLogout() async throws {
        let result = try await repository.logout()
        #expect(result == true, "Mock logout should always return true")
    }
}
