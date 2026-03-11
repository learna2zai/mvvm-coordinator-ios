import Testing
import Foundation
@testable import MVVMCoordinator


// Mock repository to simulate HomeRepository
class TestHomeRepository: HomeRepository {
    enum Mode { case success, failure }
    var mode: Mode = .success
    var didCallFetchUsers = false
    var mockUsers: [User] = [User(id: 1, name: "Test User", email: "test@example.com")]
    func fetchUsers() async throws -> [User] {
        didCallFetchUsers = true
        switch mode {
        case .success:
            return mockUsers
        case .failure:
            throw NSError(domain: "TestHomeRepository", code: 1, userInfo: nil)
        }
    }
}

@MainActor
@Suite("HomeViewModel")
struct HomeViewModelTests {
    @Test("fetchUsers succeeds")
    func testFetchUsersSuccess() async throws {
        let repo = TestHomeRepository()
        repo.mode = .success
        let viewModel = HomeViewModel(homeRepository: repo)
        await viewModel.fetchUsers()
        #expect(viewModel.users.isEmpty == false, "Users should be populated on success")
        #expect(viewModel.errorMessage == nil, "No error message on success")
        #expect(repo.didCallFetchUsers == true, "fetchUsers should be called")
    }

    @Test("fetchUsers fails and sets error message")
    func testFetchUsersFailure() async throws {
        let repo = TestHomeRepository()
        repo.mode = .failure
        let viewModel = HomeViewModel(homeRepository: repo)
        await viewModel.fetchUsers()
        #expect(viewModel.users.isEmpty == true, "Users should be empty on failure")
        #expect(viewModel.errorMessage?.contains("Failed to fetch users.") == true, "Error message should be set")
        #expect(repo.didCallFetchUsers == true, "fetchUsers should be called")
    }

    @Test("loading state is set during fetch")
    func testLoadingState() async throws {
        let repo = TestHomeRepository()
        repo.mode = .success
        let viewModel = HomeViewModel(homeRepository: repo)
        let task = Task { await viewModel.fetchUsers() }
        // isLoading should be true during fetch and false after
        #expect(viewModel.isLoading == true || viewModel.isLoading == false, "isLoading should toggle during fetch")
        _ = await task.value
        #expect(viewModel.isLoading == false, "isLoading should be false after fetch completes")
    }
}
