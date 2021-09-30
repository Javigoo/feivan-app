//
//  materialView.swift
//  feivan
//
//  Created by javigo on 28/9/21.
//

import SwiftUI

struct materialView: View {
    @State private var material = ""
    let materialOpciones = ["PVC", "Aluminio"]

    var body: some View {
        Form {
            TextField("Otro", text: $material)
        }
    }
}

struct materialView_Previews: PreviewProvider {
    static var previews: some View {
        materialView()
    }
}
