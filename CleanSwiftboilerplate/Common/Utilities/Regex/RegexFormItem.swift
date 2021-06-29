//
//  RegexFormItem.swift
//  Combine Form Validation UIKit
//
//  Created by Farhan Amjad on 28.06.21.
//

import Foundation

struct RegexFormItem {
    let patten: String
    let error: ValidationError
}
enum ValidationError: Error {
    case custom(message: String)
}

//Validation Protocol
protocol ValidationManager {
    func validate(val: Any) throws
}

//RegexValidatorManager

struct RegexValidatorManager: ValidationManager {
    private let items: [RegexFormItem]
    
    init(_ items: [RegexFormItem]) {
        self.items = items
    }
    
    func validate(val: Any) throws {
        let nVal = (val as? String) ?? ""
        try items.forEach({ (regexItem) in
            let regex = try? NSRegularExpression(pattern: regexItem.patten)
            let range = NSRange(location: 0, length: nVal.count)
            if regex?.firstMatch(in: nVal, options:[], range: range) == nil {
                throw regexItem.error
            }
        })
    }
}
