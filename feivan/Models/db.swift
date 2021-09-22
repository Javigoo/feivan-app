//
//  productos.swift
//  feivan
//
//  Created by javigo on 22/9/21.
//

import Foundation

struct db {
    var familias = ["Correderas", "Practicables", "Puertas", "Puertas apertura exterior", "Elevadoras", "Persianas/Mallorquinas", "Barandillas", "Puerta bandera"]
    
    func getFamilias() -> Array<String> {
        return familias
    }
}
