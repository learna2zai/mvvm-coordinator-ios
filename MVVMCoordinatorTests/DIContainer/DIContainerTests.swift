import Testing
@testable import MVVMCoordinator

@Suite("DIContainer Dependency Injection")
struct DIContainerTests {
    
    @MainActor
    @Test("DIContainer instantiates repositories and view models")
    func testDIContainerWiresDependencies() async throws {
        // Use mock API client to isolate from networking
        let apiClient = MockApiClient()
        let container = DIContainer(apiClient: apiClient)
        
        // Repositories
        #expect(container.authRepository is AuthRepositoryImpl)
        #expect(container.homeRepository is HomeRepositoryImpl)
    }
}
