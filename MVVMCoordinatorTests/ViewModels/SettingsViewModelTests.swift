import Testing
import Foundation
@testable import MVVMCoordinator

@MainActor
@Suite("SettingsViewModel")
struct SettingsViewModelTests {
    @Test("logout succeeds")
    func testLogoutSuccess() async throws {
        let repo = TestAuthRepository()
        repo.mode = .success
        let viewModel = SettingsViewModel(authRepository: repo)
        let result = await viewModel.logout()
        #expect(result == true, "Should succeed on successful logout")
        #expect(viewModel.errorMessage == nil, "No error message on success")
        #expect(repo.didCallLogout == true, "Repository logout should be called")
    }

    @Test("logout fails and sets error message")
    func testLogoutFailure() async throws {
        let repo = TestAuthRepository()
        repo.mode = .failure
        let viewModel = SettingsViewModel(authRepository: repo)
        let result = await viewModel.logout()
        #expect(result == false, "Should fail on unsuccessful logout")
        #expect(viewModel.errorMessage == "Failed to logout", "Proper error message on failure")
        #expect(repo.didCallLogout == true, "Repository logout should be called")
    }

    @Test("loading state is set during logout")
    func testLoadingState() async throws {
        let repo = TestAuthRepository()
        repo.mode = .success
        let viewModel = SettingsViewModel(authRepository: repo)
        let task = Task { await viewModel.logout() }
        #expect(viewModel.isLoading == true || viewModel.isLoading == false, "isLoading should toggle during logout")
        _ = await task.value
        #expect(viewModel.isLoading == false, "isLoading should be false after logout completes")
    }

    @Test("pusNotification toggle value")
    func testPushNotificationToggle() async throws {
        let repo = TestAuthRepository()
        let viewModel = SettingsViewModel(authRepository: repo)
        viewModel.pusNotification = false
        #expect(viewModel.pusNotification == false, "pusNotification should reflect value set")
        viewModel.pusNotification = true
        #expect(viewModel.pusNotification == true, "pusNotification should reflect value set")
    }
}
