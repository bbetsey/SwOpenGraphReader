//
//  File.swift
//  
//
//  Created by Антон Тропин on 02.12.23.
//

import Foundation

extension HTTPURLResponse {
    var ok: Bool {
        (200...299).contains(statusCode)
    }
}
