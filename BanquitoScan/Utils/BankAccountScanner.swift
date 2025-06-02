//
//  extractBankData.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 25/01/2025.
//

import UIKit
import Vision

class BankAccountScanner {
    
    func extractBankAccountInfo(from image: UIImage, completion: @escaping ([String]) -> Void) {
        guard let cgImage = image.cgImage else {
            completion([])
            return
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                completion([])
                return
            }
            
            let extractedText = observations.compactMap { $0.topCandidates(1).first?.string }
            completion(extractedText)
        }
        
        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        request.recognitionLanguages = ["es"]
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try requestHandler.perform([request])
            } catch {
                completion([])
            }
        }
    }
}
