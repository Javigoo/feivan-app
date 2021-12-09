//
//  Hierarchy.swift
//  Feivan
//
//  Created by javigo on 26/10/21.
//

import Foundation


// Jerarquía

struct Hierarchy: Codable {
    let elementos: [Elemento]
}

struct Elemento: Codable {
    let nombre: String
    let opciones: [String]
}

func hierarchy() -> Hierarchy {
    print("hierarchy")
    let url = Bundle.main.url(forResource: "Hierarchy", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    let hierarchy = try? decoder.decode(Hierarchy.self, from: data)
    return hierarchy!
}

// RAL

func ral() -> RalColors {
    let url = Bundle.main.url(forResource: "Ral", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let decoder = JSONDecoder()
    let ral = try? decoder.decode(RalColors.self, from: data)
    return ral!
}

struct RalColors: Codable {
    let elementos: [Ral]
}

struct Ral: Codable {
    let code: String
    let scope: String
    let color: color
    let names: names
}

struct color: Codable {
    let hex: String
    let websafe: String
    let rgb: rgb
    let hsl: hsl
    let hsb: hsb
    let cmyk: cmyk
}

struct rgb: Codable {
    let r: Int
    let g: Int
    let b: Int
}

struct hsl: Codable {
    let h: Int
    let s: Int
    let l: Int
}

struct hsb: Codable {
    let h: Int
    let s: Int
    let b: Int
}

struct cmyk: Codable {
    let c: String
    let m: String
    let y: String
    let k: String
}

struct names: Codable {
    let de: String
    let en: String
    let fr: String
    let es: String
    let it: String
    let nl: String
}






