//
//  RutValidatorTest.swift
//  BanquitoScanTests
//
//  Created by Gaspar Dolcemascolo on 08/03/2025.
//

import XCTest
@testable import BanquitoScan

final class RutValidatorTest: XCTest {
    var rutValidator: RutValidator!
    
    
    override func setUp() {
        super.setUp()
        rutValidator = RutValidator()
    }
    
    override func tearDown() {
        rutValidator = nil
        super.tearDown()
    }
    
    func testRut() throws {
        
//        let rutsEjemplo = [
//            "28574778-3",  // ✅ Válido
//            "28574778",    // ❌ Falta DV -> Retorna nil
//            "28.574.778-3", // ✅ Válido con puntos
//            "28.574.778",  // ❌ Falta DV -> Retorna nil
//            "12345678-5",  // ✅ Válido
//            "285747783",   // ✅ Válido sin guion
//            "00000000-0",  // ❌ Inválido
//            "87654321-K",  // ✅ Válido
//            "87654321"     // ❌ Falta DV -> Retorna nil
//        ]
        
        let valid = rutValidator.validate("jkgjhfjhgfhj")
        
        XCTAssertEqual(valid, "kjdfhgjkdhfjkghdf-3")
    }
}
