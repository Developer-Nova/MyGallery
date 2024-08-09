//
//  Int+.swift
//  MyGallery
//
//  Created by Nova on 8/9/24.
//

import Foundation

extension Int {
    func formatWithComma() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        guard let result = numberFormatter.string(for: self) else { return String(Int.zero) }
        
        return result
    }
}
