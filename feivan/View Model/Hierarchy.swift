//
//  Hierarchy.swift
//  Feivan
//
//  Created by javigo on 26/10/21.
//

import Foundation

struct Hierarchy: Codable {
    let elementos: [Elemento]
}

struct Elemento: Codable {
    let nombre: String
    let opciones: [String]
}

func hierarchy() -> Hierarchy {
    let url = Bundle.main.url(forResource: "Hierarchy", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    let hierarchy = try? decoder.decode(Hierarchy.self, from: data)
    return hierarchy!
}
