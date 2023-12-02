// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftSoup

public class SwOpenGraphReader {
    private let urlSession: URLSession
    
    public init(urlSessionConfiguration: URLSessionConfiguration = .default) {
        self.urlSession = URLSession(configuration: urlSessionConfiguration)
    }
}

// MARK: - PUBLIC METHODS
public extension SwOpenGraphReader {
    func fetch(request: URLRequest) async throws -> SwOpenGraphResponse {
        var request = request
        request.setValue("facebookexternalhit/1.1", forHTTPHeaderField: "User-Agent")
        let (data, response) = try await urlSession.data(for: request)
        
        guard let htmlResponse = response as? HTTPURLResponse, htmlResponse.ok else {
            throw SwOpenGraphError.fetchError
        }
        
        guard let html = String(data: data, encoding: .utf8) else {
            throw SwOpenGraphError.invalidResponse
        }
        
        return try parse(html: html)
    }
    
    func fetch(url: URL) async throws -> SwOpenGraphResponse {
        try await fetch(request: .init(url: url))
    }
    
}

// MARK: - Private Methods

private extension SwOpenGraphReader {
    func parse(html: String) throws -> SwOpenGraphResponse {
        do {
            let doc = try SwiftSoup.parse(html)
            let metas = try doc.select("meta")
            var result: [String: [String]] = [:]
            
            metas.forEach { meta in
                print(meta)
                guard let propertyName = try? meta.attr("property"),
                      let content = try? meta.attr("content")
                else { return }
                
                var currentValues = result[propertyName, default: []]
                currentValues.append(content)
                result.updateValue(currentValues, forKey: propertyName)
            }
            
            if let title = try? doc.title() {
                result["title"] = [title]
            }
            
            return SwOpenGraphResponse(source: result)
        } catch {
            throw SwOpenGraphError.parsingError(error)
        }
    }
}
