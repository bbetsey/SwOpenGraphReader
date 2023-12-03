import XCTest
@testable import SwOpenGraphReader

final class SwOpenGraphReaderTests: XCTestCase {
    func testExample() async throws {
        let reader = SwOpenGraphReader()
        
        let response = try await reader.fetch(url: URL(string: "https://www.youtube.com/watch?v=A9MYXaEBu_Y")!)
//        print(response)
        XCTAssertEqual(1, 1)
    }
}
