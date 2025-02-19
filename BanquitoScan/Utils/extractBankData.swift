//
//  extractBankData.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 25/01/2025.
//

import Foundation

func extractBankData(from text: String) -> [String] {
    let pattern = "(?:\\d{4}[- ]?){3}\\d{4}" // Ejemplo para tarjetas
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let results = regex?.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
    return results?.compactMap {
        Range($0.range, in: text).map { String(text[$0]) }
    } ?? []
}

