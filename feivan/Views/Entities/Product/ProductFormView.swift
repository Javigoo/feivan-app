//
//  ProductFormView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProductFormView: View {
    @ObservedObject var productVM: ProductViewModel
    @State var showView: Bool = false
    @State var showCanvas: Bool = false
    
    var body: some View {
        NavigationLink(destination: DrawOnImageView(productVM: productVM, onSave: productVM.saveDrawing), isActive: $showCanvas) { EmptyView() }

        ProductNombreView(showView: $showView, productVM: productVM)
        Form {
            Section(header: Text("Configuración")) {
                Group {
                    ProductCurvasView(productVM: productVM)
                    ProductMaterialView(productVM: productVM)
                    ProductColorView(productVM: productVM)
                    ProductTapajuntasView(productVM: productVM)
                    ProductDimensionesView(productVM: productVM)
                    ProductCristalView(productVM: productVM)
                    ProductAperturaView(productVM: productVM)
                    ProductCompactoView(productVM: productVM)
                }
                Group {
                    ProductForroExteriorView(productVM: productVM)
                    ProductCerradurasView(productVM: productVM)
                    ProductManetasView(productVM: productVM)
                    ProductHerrajeView(productVM: productVM)
                    ProductPosicionView(productVM: productVM)
                    ProductInstalacionView(productVM: productVM)
                    ProductMallorquinaView(productVM: productVM)
                    ProductHuellaView(productVM: productVM)
                }
            }
            
            Group {
                Section(header: Text("Extras")) {
                    
                    ProductFotoView(productVM: productVM)
                    
                    FotosDetalleView(productVM: productVM)
                    
                    Toggle("Remates albañilería", isOn: $productVM.remates_albanileria)
                        .onChange(of: productVM.remates_albanileria) { _ in
                            productVM.save()
                        }
                    
                    Toggle("Medidas no buenas", isOn: $productVM.medidas_no_buenas)
                        .onChange(of: productVM.medidas_no_buenas) { _ in
                            productVM.save()
                        }

                    Stepper("Unidades:  \(productVM.unidades)", value: $productVM.unidades, in: 1...99)
                        .onChange(of: productVM.unidades) { _ in
                            productVM.save()
                        }
                }
                
                Section(header: Text("Observaciones")) {
                    TextEditor(text: $productVM.observaciones)
                        .onChange(of: productVM.observaciones) { _ in
                            productVM.save()
                        }
                }
            }
        }
        .navigationTitle(Text(productVM.getSingularFamilia(name: productVM.familia)))
        .toolbar {
            Button(action: {
                if productVM.nombre.isEmpty {
                    productVM.familia = "Personalizados"
                    productVM.nombre = "marco"
                    productVM.imagen_dibujada = Data()
                }
                showCanvas = true
            }, label: {
                Image(systemName: "paintbrush.pointed")
            })
        }
    }
}
