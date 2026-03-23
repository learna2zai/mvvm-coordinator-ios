import Foundation
import Testing
import NetraLink
@testable import MVVMCoordinator

// Mock URLProtocol to intercept network requests
class MockURLProtocol: URLProtocol {
    static var responseData: Data?
    static var response: URLResponse?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            if let data = MockURLProtocol.responseData {
                client?.urlProtocol(self, didLoad: data)
            }
            if let response = MockURLProtocol.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    override func stopLoading() {}
}

struct MockModel: Codable, Equatable {
    let message: String
}

struct MockAPIRequest: APIRequest {
    var headers: [String : String] = [:]
    var method: HTTPMethod {
        .GET
    }
    var body: Data? = nil
    var queryItems: [URLQueryItem]? = nil
    var timeout: TimeInterval = 0
    var path: String = "test"
}

@MainActor
@Suite("APIClient Tests", .serialized)
struct APIClientTests {
    static func makeMockSession() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }
    
    let baseUrl = "http://test.com"

    @Test("Successful decoding returns expected model")
    func testSendSuccess() async throws {
        let mockModel = MockModel(message: "Hello")
        let data = try! JSONEncoder().encode(mockModel)
        let response = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)!
        MockURLProtocol.responseData = data
        MockURLProtocol.response = response
        MockURLProtocol.error = nil
        let session = Self.makeMockSession()
        let client = NetraLink(baseUrl: baseUrl, session: session)
        let result: MockModel = try await client.send(request: MockAPIRequest())
        #expect(result == mockModel, "Decoded value should match mock")
    }

    @Test("Handles non-200 HTTP responses with error")
    func testSendBadStatusCode() async throws {
        let response = HTTPURLResponse(url: URL(string: baseUrl)!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.responseData = Data()
        MockURLProtocol.response = response
        MockURLProtocol.error = nil
        let session = Self.makeMockSession()
        let client = NetraLink(baseUrl: baseUrl, session: session)
        
        await #expect(throws: URLError.self) {
           let _: MockModel = try await client.send(request: MockAPIRequest())
        }
    }

    @Test("Handles decoding failure with error")
    func testSendDecodingFailure() async throws {
        let invalidData = Data([0x01, 0x02, 0x03])
        let response = HTTPURLResponse(url: URL(string: baseUrl)!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.responseData = invalidData
        MockURLProtocol.response = response
        MockURLProtocol.error = nil
        let session = Self.makeMockSession()
        let client = NetraLink(baseUrl: baseUrl, session: session)
        await #expect(throws: DecodingError.self) {
           let _: MockModel = try await client.send(request: MockAPIRequest())
        }
    }
}
