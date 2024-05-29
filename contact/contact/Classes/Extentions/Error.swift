//
//  Error.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import Foundation

struct DescriptiveError: LocalizedError {
    let errorDescription: String?
    init(_ errorDescription: String) {
        self.errorDescription = errorDescription
    }
}
