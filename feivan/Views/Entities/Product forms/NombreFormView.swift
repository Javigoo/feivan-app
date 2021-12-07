//
//  NombreFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductNombreView: View {
    @Binding var showView: Bool
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
    
        NavigationLink(
            destination: ProductFamiliaFormView(productVM: productVM, showView: $showView),
            label: {
                if productVM.nombre == "" {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                } else {
                    Image(productVM.nombre)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
            }
        )
    }
}

struct ProductNombreFormView: View {
    @ObservedObject var productVM: ProductViewModel
    @Binding var showView: Bool

    var body: some View {
        ProductTreeView(optionSelect: productVM.familia, productVM: productVM, showView: $showView)
    }
}
