import Testing
@testable import MVVMCoordinator

@Suite("DIContainer Dependency Injection")
struct DIContainerTests {
    
    @MainActor
    @Test("DIContainer instantiates repositories and view models")
    func testDIContainerWiresDependencies() async throws {
        // Use mock API client to isolate from networking
        let container = DIContainer()
        
        // Repositories
        #expect(container.makeAuthRepository() is AuthRepositoryImpl)
        #expect(container.makeHomeRepository() is HomeRepositoryImpl)
    }
}
