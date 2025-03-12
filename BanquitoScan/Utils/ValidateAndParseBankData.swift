//
//  ValidateAndParseBankData.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 20/02/2025.
//

import Foundation

final class ValidateAndParseBankData {
    let rutValidator = RutValidator.shared
    static let shared: ValidateAndParseBankData = ValidateAndParseBankData()
    
    private let validBanks: [String: String] = [
        "banco bice": "Banco BICE",
        "banco consorcio": "Banco Consorcio",
        "banco estado": "Banco Estado",
        "banco corpbanca": "Banco Corpbanca",
        "bci / mach": "BCI / Mach",
        "banco falabella": "Banco Falabella",
        "banco internacional": "Banco Internacional",
        "banco paris": "Banco Paris",
        "banco ripley": "Banco Ripley",
        "banco santander": "Banco Santander",
        "banco security": "Banco Security",
        "banco de chile": "Banco de Chile",
        "edwards-citi": "Edwards-Citi",
        "banco del desarrollo": "Banco del Desarrollo",
        "coopeuch / dale": "Coopeuch / Dale",
        "hsbc bank": "HSBC Bank",
        "itau": "Itaú",
        "radobank": "Radobank",
        "tempo prepago": "Tempo Prepago",
        "prepago los heroes": "Prepago Los Héroes",
        "scotiabank": "Scotiabank",
        "scotiabank azul": "Scotiabank Azul",
        "mercado pago": "Mercado Pago",
        "tapp caja los andes": "TAPP Caja los Andes",
        "copec pay": "Copec Pay",
        "la polar prepago": "La Polar Prepago",
        "global66": "Global66",
        "prex": "Prex",
        "fintual": "Fintual"
    ]
    
    private let validAccountTypes: [String: String] = [
        "cuenta corriente": "Cuenta Corriente",
        "cuenta vista": "Cuenta Vista",
        "cuenta ahorro": "Cuenta Ahorro",
        "chequera electronica": "Chequera electronica",
        "cuenta rut": "Cuenta Rut"
    ]
    
    
    private func normalizeText(_ text: String) -> String {
        let withoutAccents = text.folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "transferencias", with: "")
            .replacingOccurrences(of: "transferencia cancaria", with: "")
            .replacingOccurrences(of: "transferencia", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return withoutAccents
        
    }
    
    func validateName(_ input: String) -> String {
        let normalizedInput = normalizeText(input)
        
        let regexPattern = #"^(?!.*\b(cuenta|cuenta:|rut:|banco:|tipo de cuenta:|tipo:)\b).+$"#
        
        guard let regex = try? NSRegularExpression(pattern: regexPattern, options: .caseInsensitive) else {
            return ""
        }
        
        let range = NSRange(location: 0, length: normalizedInput.utf16.count)
        
        if regex.firstMatch(in: normalizedInput, options: [], range: range) != nil {
            return ""
        }
        
        return regex.stringByReplacingMatches(in: normalizedInput, options: [], range: range, withTemplate: "")
        
    }
    
    func validateRut(_ input: String) -> String? {
        let normalizedinput = normalizeText(input).replacingOccurrences(of: "rut:", with: "").replacingOccurrences(of: "=", with: "")
           
        let rut = rutValidator.validate(normalizedinput)
        return rut
        
        
    }
    
    func validateBank(_ input: String) -> String? {
        let normalizedInput = normalizeText(input)
        if let match = validBanks.keys.first(where: { $0.contains(normalizedInput) }) {
            return validBanks[match]!
        } else {
            return nil
        }
        
    }
    
    func validateAccountType(_ input: String) -> String? {
        let normalizedText = normalizeText(input)
        
        if let match = validAccountTypes.keys.first(where: { $0.contains(normalizedText) }) {
            return validAccountTypes[match]!
        } else {
            return nil
        }
    }
    
    func validateAccountnumber(_ input: String) -> String? {
        let normalizedInput = normalizeText(input)
        
        let wordsToRemove = [
            ":", "numero de cuenta", "numero cuenta",
            "n° de cuenta", "n° cuenta", "cuenta", "="
        ]
        
        let cleanedText = wordsToRemove.reduce(normalizedInput) { result, word in
            result.replacingOccurrences(of: word, with: "")
        }
           
        
        let regexPatternForCleanString = "[-_.]"
        let cleanedString = cleanedText.lowercased().replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: regexPatternForCleanString, with: "", options: .regularExpression)
        
        
        let regexPattern = #"^\d{8,15}$"#
        if cleanedString.range(of: regexPattern, options: .regularExpression) != nil {
            return cleanedString
        }
        
        return nil
    }
}
