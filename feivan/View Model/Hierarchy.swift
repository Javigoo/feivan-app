//
//  Hierarchy.swift
//  Feivan
//
//  Created by javigo on 26/10/21.
//

import Foundation

// Codeable Struct
struct Hierarchy: Codable {
    let leyenda: String
    let cliente: String
    let proyecto: String
    let producto: String
    let reglas: String
}

// Read the local file
func readLocalFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
            let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
    } catch {
        print(error)
    }
    
    return nil
}

// Create the JSON Parse method
func parse(jsonData: Data) {
    do {
        let decodedData = try JSONDecoder().decode(Hierarchy.self, from: jsonData)
        print(decodedData)
    } catch {
        print("decode error")
    }
}

