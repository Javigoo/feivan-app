//
//  Familia.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

import SwiftUI

struct familyView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var selectedFamilia: String = "Correderas"
    let familias = ["Correderas", "Practicables", "Puertas", "Puertas apertura exterior", "Elevadoras", "Persianas/Mallorquinas", "Barandillas", "Puerta bandera"]
    
    var body: some View {
        
        let producto = Producto(context: managedObjectContext)
        
        VStack {
            Section {
                Text("").navigationTitle("Familia")
                
                Form {
                    Section(header: Text("")) {
                        Picker("Familia", selection: $selectedFamilia) {
                            List(familias, id: \.self) { familia in
                                Text(familia)
                            }
                        }
                    }
                }

                #if false
                    Text("Familia: \(selectedFamilia)")
                    Divider()
                #endif
                
                NavigationLink(destination: configurationView(), label: {
                    Text("Siguiente")
                })
                    .simultaneousGesture(TapGesture().onEnded{
                        producto.familia = selectedFamilia
                        PersistenceController.shared.save()
                    })
            }
        }
    }
}

struct familyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            familyView()
            familyView()
            familyView()
        }
    }
}
