//
//  File.swift
//  
//
//  Created by Anton Tropin on 01.12.23.
//

import Foundation

public enum SwOpenGraphError: Error {
    case invalidError
    case fetchError
    case invalidResponse
    case parsingError(Error)
}
