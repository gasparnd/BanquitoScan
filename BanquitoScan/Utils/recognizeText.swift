//
//  recognizeText.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 25/01/2025.
//

import UIKit
import Vision

func recognizeText(from image: UIImage) {
    guard let cgImage = image.cgImage else { return }

    let request = VNRecognizeTextRequest { request, error in
        if let error = error {
            print("Error al reconocer texto: \(error.localizedDescription)")
            return
        }
        guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

        for observation in observations {
            if let topCandidate = observation.topCandidates(1).first {
                print("Texto reconocido: \(topCandidate.string)")
            }
        }
    }
    request.recognitionLevel = .accurate

    let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    do {
        try requestHandler.perform([request])
    } catch {
        print("Error al procesar la imagen: \(error.localizedDescription)")
    }
}

