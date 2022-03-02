//
//  ProductView.swift
//  Feivan
//
//  Created by javigo on 23/10/21.
//

import SwiftUI

struct ProductTreeView: View {
    var optionSelect: String
    @ObservedObject var productVM: ProductViewModel
    @Binding var showView: Bool

    var body: some View {
        ScrollView {
            ProductTreeDirectoryView(optionSelect: optionSelect, productVM: productVM, showView: $showView)
            ProductTreeFileView(optionSelect: optionSelect, productVM: productVM, showView: $showView)
        }
        .navigationTitle(Text(optionSelect))
    }
}

struct ProductTreeDirectoryView: View {
    var optionSelect: String
    @ObservedObject var productVM: ProductViewModel
    
    @State private var seleccion = ""
    @State private var isShowingNextView = false
    @Binding var showView: Bool

    var body: some View {
        NavigationLink(destination: ProductTreeView(optionSelect: seleccion, productVM: productVM, showView: $showView), isActive: $isShowingNextView) { EmptyView() }

        ForEach(productVM.optionsFor(attribute: "Directorio \(optionSelect)"), id: \.self) { nombre in

            Button(
                action: {
                    seleccion = nombre
                    isShowingNextView = true
                },
                label: {
                    VStack {
                        Text(nombre)
                            .textStyle(NavigationLinkStyle())
                    }
                }
            )
        }
    }
}

struct ProductTreeFileView: View {
    var optionSelect: String
    @ObservedObject var productVM: ProductViewModel

    // Manage state
    @Binding var showView: Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 30)), count: 2), spacing: 10){
            ForEach(productVM.optionsFor(attribute: optionSelect), id: \.self) { nombre in
                Button(
                    action: {
                        productVM.nombre = nombre
                        productVM.imagen_dibujada = Data() // Se resetea el dibujo al cambiar el producto
                        productVM.save()
                        
                        // Volver atrás (dismiss o con isActive)
                        showView = true
                        presentationMode.wrappedValue.dismiss()
                        
                    },
                    label: {
                        VStack {
                            Image(nombre)
                                .resizable()
                                .scaledToFit()
                                //.shadow(radius: 3)
                        }
                    }
                )
            }
        }
        .padding()
        .onAppear(perform: {
            if showView {
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
}


