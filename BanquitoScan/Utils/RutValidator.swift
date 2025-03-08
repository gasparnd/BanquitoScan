import Foundation

enum RutError: Error {
    case invalidFormat(message: String)
    case invalidDigit(message: String)
}

class RutValidator {
    
    func validate(_ rut: String) -> String? {
        
        // 1️⃣ Eliminar puntos y guion del RUT
        var cleanedRut = rut.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        cleanedRut = cleanedRut.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 2️⃣ Verificar que el RUT tenga al menos 8 y máximo 9 caracteres
        guard cleanedRut.count >= 8, cleanedRut.count <= 9 else {
            return nil
        }
    
        // 3️⃣ Verificar si el RUT contiene un dígito verificador (último carácter)
        guard rut.contains("-") || cleanedRut.count == 9 else {
            return nil
        }
        
        // 4️⃣ Separar número base y dígito verificador
        let rutBase = String(cleanedRut.dropLast()) // Todo menos el último carácter
        let dvIngresado = String(cleanedRut.last!)  // Último carácter
       
        guard let rutNumero = Int(rutBase) else {
            return nil
        }
        
        // 5️⃣ Comparar dígito verificador calculado
        if getVerifyDigit(rutNumero) == dvIngresado {
            let rutFormateado = formatRut(rut: rutBase, dv: dvIngresado)
            return rutFormateado
        } else {
            return nil
        }
    }
    
     func getVerifyDigit(_ rut: Int) -> String {
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
    
    func formatRut(rut: String, dv: String) -> String {
        var formattedRut = ""
        var count = 0
        
        for char in rut.reversed() {
            if count == 3 || count == 6 {
                formattedRut.insert(".", at: formattedRut.startIndex)
            }
            formattedRut.insert(char, at: formattedRut.startIndex)
            count += 1
        }
        
        formattedRut.append("-\(dv)") // Agregar guion y DV
        return formattedRut
    }
}
