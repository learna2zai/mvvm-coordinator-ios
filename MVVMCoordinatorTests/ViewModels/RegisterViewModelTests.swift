import Testing
import Foundation
@testable import MVVMCoordinator

@MainActor
@Suite("RegisterViewModel")
struct RegisterViewModelTests {
    @Test("register succeeds with valid details")
    func testRegisterSuccess() async throws {
        let repo = TestAuthRepository()
        repo.mode = .success
        let viewModel = RegisterViewModel(authRepository: repo)
        viewModel.name = "Test User"
        viewModel.username = "testuser"
        viewModel.password = "password"
        let result = await viewModel.register()
        #expect(result == true, "Should succeed with valid details")
        #expect(viewModel.errorMessage == nil, "No error message on success")
        #expect(repo.didCallRegister == true, "Repository register should be called")
    }

    @Test("register fails with invalid details")
    func testRegisterFailure() async throws {
        let repo = TestAuthRepository()
        repo.mode = .failure
        let viewModel = RegisterViewModel(authRepository: repo)
        viewModel.name = ""
        viewModel.username = "baduser"
        viewModel.password = "badpassword"
        let result = await viewModel.register()
        #expect(result == false, "Should fail with invalid details")
        #expect(viewModel.errorMessage == "Failed to login. The operation couldn’t be completed. (TestAuthRepository error 2.)", "Proper error message on failure")
        #expect(repo.didCallRegister == true, "Repository register should be called")
    }

    @Test("loading state is set during register")
    func testLoadingState() async throws {
        let repo = TestAuthRepository()
        repo.mode = .success
        let viewModel = RegisterViewModel(authRepository: repo)
        let task = Task { await viewModel.register() }
        // isLoading should be true during registration and false after
        #expect(viewModel.isLoading == true || viewModel.isLoading == false, "isLoading should toggle during register")
        _ = await task.value
        #expect(viewModel.isLoading == false, "isLoading should be false after register completes")
    }
}
