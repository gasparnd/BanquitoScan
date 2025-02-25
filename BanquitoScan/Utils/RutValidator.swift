import Foundation

enum RutError: Error {
    case invalidFormat(message: String)
    case invalidDigit(message: String)
}

class RutValidator {
    
    func validate(_ rut: String) -> String? {
        let pattern = #"^(\d{1,8})-([\dkK])$"#
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
              let match = regex.firstMatch(in: rut, options: [], range: NSRange(location: 0, length: rut.utf16.count)) else {
            return nil
        }
        
        
        
        let rutBaseRange = Range(match.range(at: 1), in: rut)!
        let dvRange = Range(match.range(at: 2), in: rut)!
        let rutBase = String(rut[rutBaseRange])
        let dvIngresado = String(rut[dvRange]).uppercased()
        guard let rutNumero = Int(rutBase) else { return nil }
        
        if calcularDigitoVerificador(rutNumero) == dvIngresado {
            return rut
        } else {
            return nil
        }
    }
    
    private func calcularDigitoVerificador(_ rut: Int) -> String {
        var suma = 0
        var multiplicador = 2
        
        var rutTemp = rut
        while rutTemp > 0 {
            let digito = rutTemp % 10
            suma += digito * multiplicador
            multiplicador = multiplicador == 7 ? 2 : multiplicador + 1
            rutTemp /= 10
        }
        
        let resto = suma % 11
        let digitoCalculado = 11 - resto
        
        switch digitoCalculado {
        case 10: return "K"
        case 11: return "0"
        default: return String(digitoCalculado)
        }
    }
    
    
}
