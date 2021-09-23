//
//  productView.swift
//  feivan
//
//  Created by javigo on 23/9/21.
//

import SwiftUI

struct productView: View {
    
    let productos = ["Corredera de 2 hojas con fijo inferior",
                     "Corredera de 2 hojas con fijo superior",
                     "Corredera de 2 hojas",
                     "Corredera de 3 hojas",
                     "Corredera de 4 hojas"]
        
    var body: some View {
        Text("").navigationTitle("Productos")
        
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 20) {
                ForEach(productos, id: \.self) { producto in
                    VStack {
                        Image(producto)
                            .resizable()
                            .scaledToFit()
                        NavigationLink(destination: configurationView(), label: {
                            Text(producto)
                        })
                    }
                        
                }
            }
            .padding(.horizontal)
        }
    }
}

struct productView_Previews: PreviewProvider {
    static var previews: some View {
        productView()
    }
}
