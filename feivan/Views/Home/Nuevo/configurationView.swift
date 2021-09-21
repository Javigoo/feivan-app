//
//  Configuracion.swift
//  feivan
//
//  Created by javigo on 20/9/21.
//

import SwiftUI

struct configurationView: View {
    var body: some View {
        VStack {
            
            Text("").navigationTitle("Configuración")
            
            Form {
                
            }
            
            NavigationLink(destination: Text("Falta añadir el siguiente apartado"), label: {
                Text("Siguiente")
            })
        }
    }
}

struct configurationView_Previews: PreviewProvider {
    static var previews: some View {
        configurationView()
    }
}
