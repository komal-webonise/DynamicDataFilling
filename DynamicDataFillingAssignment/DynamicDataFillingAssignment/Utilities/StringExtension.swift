//
//  StringExtension.swift
//  DynamicDataFillingAssignment
//

import Foundation

extension String {
    func trim() -> String{
        return self.trimmingCharacters(in: .whitespaces)
    }
}
