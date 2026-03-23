import Foundation
import Testing
import NetraLink
@testable import MVVMCoordinator

struct MockClient: NetworkClient {
    func send<T>(request: APIRequest) async throws -> T where T : Decodable {
        // Return mock data for UserDTO array
        let dtos = [
            UserDTO(id: 1, name: "A", email: "a@example.com", phone: "123"),
            UserDTO(id: 2, name: "B", email: "b@example.com", phone: "456")
        ]
        let data = try! JSONEncoder().encode(dtos)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

@MainActor
@Suite("HomeRepositoryImpl basic tests")
struct HomeRepositoryImplTests {
    let repository = HomeRepositoryImpl(apiClient: MockClient())

    @Test("fetchUsers returns correct User array")
    func testFetchUsers() async throws {
        let users = try await repository.fetchUsers()
        #expect(users.count == 2, "Should return 2 users")
        #expect(users[0].name == "A")
        #expect(users[1].email == "b@example.com")
    }
    
    @Test("fetchUsers returns empty array if no users")
    func testFetchUsersEmpty() async throws {
        let emptyRepo = HomeRepositoryImpl(apiClient: MockApiClient())
        let users = try await emptyRepo.fetchUsers()
        #expect(users.isEmpty)
    }
}
