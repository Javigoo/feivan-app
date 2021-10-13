//
//  projectView.swift
//  feivan
//
//  Created by javigo on 13/10/21.
//

import SwiftUI

struct projectView: View {
    @State private var ascensor: Bool = false
    @State private var grua: Bool = false
    @State private var subirFachada: Bool = false

    var body: some View {
        VStack {
            
            Text("Resumen proyecto")
            
            Form {
                Toggle(isOn: $ascensor) {
                    Text("Ascensor")
                }
                Toggle(isOn: $grua) {
                    Text("Grúa")
                }
                Toggle(isOn: $subirFachada) {
                    Text("Subir fachada")
                }
            }
        }
    }
}

struct projectView_Previews: PreviewProvider {
    static var previews: some View {
        projectView()
    }
}
