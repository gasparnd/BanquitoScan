//
//  ValidateAndParseBankData.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 20/02/2025.
//

import Foundation

class ValidateAndParseBankData {
    let rutValidator = RutValidator()
    
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
        "banco de chile / edwards-citi": "Banco de Chile / Edwards-Citi",
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
        let lowercase = withoutAccents.lowercased()
        return lowercase
    }
    
    func validateRut(_ input: String) -> String? {
        let normalizedinput = normalizeText(input).replacingOccurrences(of: ".", with: "")
        if normalizedinput.range(of: #"^\d{1,2}\d{3}\d{3}-\d$"#, options: .regularExpression) != nil {
            let rut = rutValidator.validate(normalizedinput)
            return normalizedinput
        }
        
        
        return nil
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
    
    func validateAccountnumber(_ input: String) -> Bool {
        let normalizedInput = normalizeText(input)
        let regexPatternForCleanString = "[-_.]"
        let cleanedString = normalizedInput.lowercased().replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: regexPatternForCleanString, with: "", options: .regularExpression)
        
        
        let regexPattern = #"^\d{8,15}$"#
        return cleanedString.range(of: regexPattern, options: .regularExpression) != nil
    }
}
