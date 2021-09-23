//
//  Familia.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

import SwiftUI

struct familyView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var selectedFamilia: String = ""
    let familias = ["Correderas", "Practicables", "Puertas",
                    "Puertas apertura exterior", "Elevadoras",
                    "Mallorquinas", "Barandillas", "Puerta bandera"]
    
    var body: some View {
        
        let producto = Producto(context: managedObjectContext)
        
        VStack {
            Section {
                Text("").navigationTitle("Familia")
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 260))], spacing: 20) {
                        ForEach(familias, id: \.self) { familia in
                            VStack {
                                NavigationLink(destination: productView(), label: {
                                    Text(familia)
                                        .frame(width: 250, height: 20, alignment: .center)
                                        .foregroundColor(.black)
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(Color.black, lineWidth: 1)
                                        )
                                })
                                    .simultaneousGesture(TapGesture().onEnded{
                                        producto.familia = selectedFamilia
                                        PersistenceController.shared.save()
                                    })
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct familyView_Previews: PreviewProvider {
    static var previews: some View {
        familyView()
    }
}
