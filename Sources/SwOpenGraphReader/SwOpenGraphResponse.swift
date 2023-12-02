//
//  File.swift
//  
//
//  Created by Anton Tropin on 01.12.23.
//

import Foundation

public struct SwOpenGraphResponse {
    private let source: [String: [String]]
    
    public init(source: [String : [String]]) {
        self.source = source
    }
}

// MARK: - Public Properties

public extension SwOpenGraphResponse {
    /// The title of the OpenGraph content.
    var title: String? {
        stringValue(.title) ?? stringValue(.title2)
    }
    
    /// The type of the OpenGraph content.
    var type: String? {
        stringValue(.type)
    }
    
    /// The desctiption of the OpenGraph content.
    var description: String? {
        stringValue(.description)
    }
    
    /// The url of the OpenGraph content.
    var url: URL? {
        urlValue(.url)
    }
    
    /// The URL of the main image associated with the OpenGraph content.
    var imageURL: URL? {
        urlValue(.image)
    }
    
    /// The alt text of the main image associated with the OpenGraph content.
    var imageAlt: String? {
        stringValue(.imageAlt)
    }
    
    /// The secure URL of the main image associated with the OpenGraph content.
    var imageSecureURL: URL? {
        urlValue(.imageSecure)
    }
    
    /// The MIME type of the main image associated with the OpenGraph content.
    var imageType: String? {
        stringValue(.imageType)
    }
    
    /// The width of the main image associated with the OpenGraph content.
    var imageWidth: Double? {
        doubleValue(.imageWidth)
    }
    
    /// The height of the main image associated with the OpenGraph content.
    var imageHeight: Double? {
        doubleValue(.imageHeight)
    }
    
    /// The site name associated with the OpenGraph content.
    var siteName: String? {
        stringValue(.siteName)
    }
    
    /// The list of allowed countries for accessing the OpenGraph content.
    var restrictionsCountriesAllowed: [String]? {
        arrayValue(.restrictionsCountryAllowed)
    }
    
    /// The URL of the audio associated with the OpenGraph content.
    var audioURL: URL? {
        urlValue(.audio)
    }
    
    /// The determiner of the OpenGraph content.
    var determiner: String? {
        stringValue(.determiner)
    }
    
    /// The locale of the OpenGraph content.
    var locale: String? {
        stringValue(.locale)
    }
    
    /// The list of alternate locales for the OpenGraph content.
    var localeAlternative: String? {
        stringValue(.localeAlternative)
    }
    
    /// The URL of the video associated with the OpenGraph content.
    var videoURL: URL? {
        urlValue(.vidio)
    }
}

// MARK: - Private Methods

private extension SwOpenGraphResponse {
    
    func arrayValue(_ key: SwOpenGraphKeys) -> [String]? {
        source[key.rawValue]
    }
    
    func stringValue(_ key: SwOpenGraphKeys) -> String? {
        guard let stringValue = source[key.rawValue]?.first
        else { return nil }
        
        return stringValue
    }
    
    func doubleValue(_ key: SwOpenGraphKeys) -> Double? {
        guard let doubleValue = source[key.rawValue]?.first,
              let doubleValue = Double(doubleValue)
        else { return nil }
        
        return doubleValue
    }
    
    func urlValue(_ key: SwOpenGraphKeys) -> URL? {
        guard let urlValue = source[key.rawValue]?.first,
              let url = URL(string: urlValue)
        else { return nil }
        
        return url
    }
}
