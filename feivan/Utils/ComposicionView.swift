//
//  Composicion.swift
//  Feivan
//
//  Created by javigo on 2/3/22.
//

import SwiftUI

struct ComposicionesView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack {
            if !projectVM.getComposiciones().isEmpty {
                Form {
                    Section(header: Text("Composiciones")) {
                        ForEach(projectVM.getComposiciones()) { compo in
                            let composicion: Composicion = compo
                            let tipo: String = composicion.tipo ?? ""
                            let productos: [Producto] = composicion.productos?.allObjects as? [Producto] ?? []
                            
                            NavigationLink(
                                destination: {
                                    ComposicionFormView(projectVM: projectVM, sourceItems: projectVM.getProductsVM())
                                }, label: {
                                    VStack(alignment: .center) {
                                        Image(tipo)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 100)

                                        HStack {
                                            Spacer()
                                            ForEach(Array(zip(productos.indices, productos)), id: \.0) { index, producto in
                                                VStack {
                                                    Image(systemName: "\(index+1).circle")
                                                        .resizable()
                                                        .frame(width: 10, height: 10)
                                                    Image(producto.nombre ?? "")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 80, height: 80)
                                                }
                                            }
                                            Spacer()
                                        }
                                    }
                                }
                            )
                        }
                        .onDelete(perform: deleteComposicion)
                    }
                }
            } else {
                Text("No hay composiciones")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(
                    destination: {
                        ComposicionFormView(projectVM: projectVM, sourceItems: projectVM.getProductsVM())
                    }, label: {
                        Text("Añadir composición")
                    }
                )
//                Button(action: {
//                    showGenerarPdf = true
//                }, label: {
//                    Text("Plantilla de medición")
//                    Image(systemName: "doc")
//                })
            }
        }
        .navigationTitle(Text("Composiciones"))
        
    }
    
    private func deleteComposicion(offsets: IndexSet) {
        withAnimation {
            projectVM.delete(at: offsets, for: projectVM.getComposiciones())
        }
    }
}

struct ComposicionFormView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var projectVM: ProjectViewModel
    @State var sourceItems: [ProductViewModel]
    
    @State var selectedItems: [ProductViewModel] = []
    @State var tipo_composicion: String = ""
    var composiciones =  ["composicion-1", "composicion-2", "composicion-3", "composicion-4", "composicion-5", "composicion-6", "composicion-7", "composicion-8", "composicion-9", "composicion-10", "composicion-11", "composicion-12"]
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Tipos de composición")) {
                    if tipo_composicion.isEmpty {
                        let columns = [GridItem(.adaptive(minimum: 150))]
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 0) {
                                ForEach(composiciones, id: \.self) { item in
                                    VStack {
                                        Image(item)
                                            .resizable()
                                            .scaledToFit()
                                            .onTapGesture {
                                                tipo_composicion = item
                                            }
                                    }
                                }
                            }
                        }.frame(height: 250)
                    } else {
                        Image(tipo_composicion)
                            .resizable()
                            .frame(height: 250)
                            .scaledToFit()
                            .onTapGesture {
                                tipo_composicion = ""
                            }
                    }
                    
                }
                Section(header: Text("Productos en la composición")) {
                    ComposicionSelectProducts(sourceItems: sourceItems, selectedItems: $selectedItems, maxProducts: getMaxNumProducts(tipo_composicion: tipo_composicion))
                }
            }
        }
        .navigationTitle(Text("Añadir composición"))
        .onDisappear(perform: {
            projectVM.addComposicion(tipo: tipo_composicion, productosVM: selectedItems)
        })
    }
    
    private func deleteComposicion(offsets: IndexSet) {
        withAnimation {
            projectVM.delete(at: offsets, for: projectVM.getComposiciones())
//            if let index = offsets.first {
//            }
        }
    }
    
    func getMaxNumProducts(tipo_composicion: String) -> Int {
        let string_num = tipo_composicion.components(separatedBy: "-")
        if string_num.count == 2 {
            let num = Int(string_num[1]) ?? 0
            if num <= 4 {
                return 2
            } else if num <= 6 {
                return 3
            } else if num <= 10 {
                return 2
            } else if num <= 12 {
                return 3
            }
        }
        return 12
    }
}

struct ComposicionSelectProducts: View {

    var sourceItems: [ProductViewModel]
    @Binding var selectedItems: [ProductViewModel]
    var maxProducts: Int
        
    var body: some View {
            List {
                ForEach(sourceItems) { producto in
                    if producto.composicion == nil { // No se ven los productos que pertenecen a una composicion
                        if selectedItems.count < maxProducts || selectedItems.contains(producto) {
                            Button(action: {
                                withAnimation {
                                    if selectedItems.contains(producto) {
                                        selectedItems.removeAll(where: { $0 == producto })
                                    } else {
                                        if maxProducts == selectedItems.count {
                                            print("Max products for this composition")
                                        } else {
                                            selectedItems.append(producto)
                                        }
                                    }
                                }
                            }, label: {
                                HStack {
                                    ProductPreviewView(productVM: producto)
                                    Spacer()
                                    if !getNumProductSelection(producto: producto).isEmpty {
                                        Image(systemName: getNumProductSelection(producto: producto))
                                    }
                                }
                            }).foregroundColor(.primary)
                        }
                    }
                }
            }
        
    }
    
    func getNumProductSelection(producto: ProductViewModel) -> String {
        let num = selectedItems.firstIndex(of: producto) ?? -1
        if num == -1 {
            return ""
        }
        return String(num + 1)+".circle"
    }
}
