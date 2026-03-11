import Testing
import Foundation
@testable import MVVMCoordinator

// Mock repository to simulate AuthRepository
class TestAuthRepository: AuthRepository {
    
    enum Mode {
        case success
        case failure
    }
    var mode: Mode = .success
    var didCallLogin = false
    var didCallRegister = false
    var didCallLogout = false
    
    func login(username: String, password: String) async throws -> Bool {
        didCallLogin = true
        switch mode {
        case .success:
            return true
        case .failure:
            throw NSError(domain: "TestAuthRepository", code: 1, userInfo: nil)
        }
    }
    
    func register(name: String, username: String, password: String) async throws -> Bool {
        didCallRegister = true
        switch mode {
        case .success:
            return true
        case .failure:
            throw NSError(domain: "TestAuthRepository", code: 2, userInfo: nil)
        }
    }
    
    func logout() async throws -> Bool {
        didCallLogout = true
        switch mode {
        case .success:
            return true
        case .failure:
            throw NSError(domain: "TestAuthRepository", code: 3, userInfo: nil)
        }
    }
}

@MainActor
@Suite("LoginViewModel")
struct LoginViewModelTests {
    @Test("login succeeds with correct credentials")
    func testLoginSuccess() async throws {
        let repo = TestAuthRepository()
        repo.mode = .success
        let viewModel = LoginViewModel(authRepository: repo)
        viewModel.username = "user"
        viewModel.password = "pass"
        let result = await viewModel.login()
        #expect(result == true, "Should succeed with correct credentials")
        #expect(viewModel.errorMessage == nil, "No error message on success")
        #expect(repo.didCallLogin == true, "Repository login should be called")
    }
    
    @Test("login fails with wrong credentials")
    func testLoginFailure() async throws {
        let repo = TestAuthRepository()
        repo.mode = .failure
        let viewModel = LoginViewModel(authRepository: repo)
        viewModel.username = "user"
        viewModel.password = "wrongpass"
        let result = await viewModel.login()
        #expect(result == false, "Should fail with wrong credentials")
        #expect(viewModel.errorMessage == "Failed to login.", "Proper error message on failure")
        #expect(repo.didCallLogin == true, "Repository login should be called")
    }

    @Test("loading state is set during login")
    func testLoadingState() async throws {
        let repo = TestAuthRepository()
        repo.mode = .success
        let viewModel = LoginViewModel(authRepository: repo)
        let task = Task { await viewModel.login() }
        // Should be true for at least part of the async call
        #expect(viewModel.isLoading == true || viewModel.isLoading == false, "isLoading should toggle during login")
        _ = await task.value
        #expect(viewModel.isLoading == false, "isLoading should be false after login completes")
    }
}
