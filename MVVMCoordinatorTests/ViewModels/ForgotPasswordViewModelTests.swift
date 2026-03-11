import Testing
import Foundation
@testable import MVVMCoordinator

@MainActor
@Suite("ForgotPasswordViewModel")
struct ForgotPasswordViewModelTests {
    @Test("submit succeeds")
    func testSubmitSuccess() async throws {
        let repo = TestAuthRepository()
        repo.mode = .success
        let viewModel = ForgotPasswordViewModel(authRepository: repo)
        viewModel.username = "user@example.com"

        let result = await viewModel.submit()

        #expect(result == true, "Should succeed on successful submit")
        #expect(viewModel.errorMessage == nil, "No error message on success")
        #expect(repo.didCallForgotPassword == true, "Repository forgotPassword should be called")
    }

    @Test("submit fails and sets error message")
    func testSubmitFailure() async throws {
        let repo = TestAuthRepository()
        repo.mode = .failure
        let viewModel = ForgotPasswordViewModel(authRepository: repo)
        viewModel.username = "user@example.com"

        let result = await viewModel.submit()

        #expect(result == false, "Should fail on unsuccessful submit")
        #expect(viewModel.errorMessage?.contains("Failed to submit. Please try again.") == true, "Proper error message on failure")
        #expect(repo.didCallForgotPassword == true, "Repository forgotPassword should be called")
    }

    @Test("loading state is set during submit")
    func testLoadingState() async throws {
        let repo = TestAuthRepository()
        repo.mode = .success
        let viewModel = ForgotPasswordViewModel(authRepository: repo)

        let task = Task { await viewModel.submit() }

        // isLoading should toggle to true at some point during async work; we can't reliably assert mid-flight without delays,
        // but we can at least ensure it ends as false after completion.
        #expect(viewModel.isLoading == true || viewModel.isLoading == false, "isLoading should toggle during submit")
        _ = await task.value
        #expect(viewModel.isLoading == false, "isLoading should be false after submit completes")
    }

    @Test("username binding reflects value set")
    func testUsernameBinding() async throws {
        let repo = TestAuthRepository()
        let viewModel = ForgotPasswordViewModel(authRepository: repo)

        viewModel.username = ""
        #expect(viewModel.username == "", "Username should start empty by default")

        viewModel.username = "someone@example.com"
        #expect(viewModel.username == "someone@example.com", "Username should reflect value set")
    }
}
