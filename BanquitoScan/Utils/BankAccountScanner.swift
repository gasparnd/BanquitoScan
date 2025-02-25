//
//  extractBankData.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 25/01/2025.
//

import UIKit
import Vision

class BankAccountScanner {
    let validator = ValidateAndParseBankData()
    
    func extractBankAccountInfo(from image: UIImage, completion: @escaping (BankAccountInfo?) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(nil)
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                completion(nil)
                return
            }
            
            let extractedText = observations.compactMap { $0.topCandidates(1).first?.string }
            let parsedData = self.parseTextData(extractedText)
            completion(parsedData)
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        request.recognitionLanguages = ["es"]
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                completion(nil)
            }
        }
    }
    
    
    private func parseTextData(_ textLines: [String]) -> BankAccountInfo? {
        var name: String = ""
        var rut: String = ""
        var accountType: String = ""
        var accountNumber: String = ""
        var bank: String = ""
        var email: String = ""

        for line in textLines {
            print("Start: \(line)")
            if line.contains("@") {
                print("It is email")
                email = line.trimmingCharacters(in: .whitespaces)
            } else if let formatedAccountType = validator.validateAccountType(line) {
                print("It is account type")
                accountType = formatedAccountType
            } else if let formatedRut = validator.validateRut(line) {
                print("It is rut")
                rut = line.trimmingCharacters(in: .whitespaces)
            } else if validator.validateAccountnumber(line) {
                print("It is account number")
                accountNumber = line.trimmingCharacters(in: .whitespaces)
            } else if let formatedBank = validator.validateBank(line) {
                print("It is bank")
                bank = formatedBank
            } else  {
                print("It is name")
                name = "\(name) \(line.trimmingCharacters(in: .whitespaces))"
            }
            print("End")
        }

        
        return BankAccountInfo(name: name, rut: rut, accountType: accountType, accountNumber: accountNumber, bank: bank, email: email)

    }
}
