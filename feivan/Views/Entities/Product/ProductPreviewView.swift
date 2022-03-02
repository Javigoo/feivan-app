//
//  ProductPreviewView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProductPreviewView: View {
    @ObservedObject var productVM: ProductViewModel
    var body: some View {
        HStack {
            
            if productVM.nombre.isEmpty {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } else if !productVM.imagen_dibujada.isEmpty {
                data_to_image(data: productVM.imagen_dibujada)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            } else {
                Image(productVM.nombre)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
            
            VStack(alignment: .leading){
                if productVM.unidades == 1 {
                    Text(productVM.getSingularFamilia(name: productVM.familia))
                        .font(.title3)
                        .lineLimit(1)
                } else {
                    Text(String(productVM.unidades)+" "+productVM.getFamilia())
                        .font(.title3)
                        .lineLimit(1)
                }
                HStack {
                    Text(productVM.getDimensiones(option: "ancho x alto"))
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
        }
    }
}
