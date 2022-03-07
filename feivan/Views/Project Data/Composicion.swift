//
//  Composicion.swift
//  Feivan
//
//  Created by javigo on 2/3/22.
//

import SwiftUI

struct Composicion: View {
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
                
                Section(header: Text("Composiciones")) {
                    ForEach(projectVM.getProductsVM()) { producto in
                        if !producto.composicion.isEmpty {
                            ProductPreviewView(productVM: producto)
                        }
                    }.onDelete(perform: deleteComposicion)
                }
            }
        }
        .navigationTitle(Text("Composición"))
        .onDisappear(perform: {
            if !tipo_composicion.isEmpty {
                let composicion_id = UUID()
                for (n, product) in selectedItems.enumerated() {
                    product.composicion = "\(composicion_id),\(tipo_composicion),\(String(n+1))"
                    product.save()
                }
            }
        })
    }
    
    func getGroupComposiciones(productos: [ProductViewModel]) -> [String:[ProductViewModel]] {
        var lista_composiciones: [String:[ProductViewModel]] = [:]

        for producto in productos {
            if !producto.composicion.isEmpty {
                let compo = producto.composicion.components(separatedBy: ",")
                let id_compo = compo[0]
                if lista_composiciones.keys.contains(id_compo) {
                    lista_composiciones[id_compo]?.append(producto)
                } else {
                    //lista_composiciones.append(id_compo:[producto])
                }
            }
        }
        
        return lista_composiciones
    }
    
    private func deleteComposicion(offsets: IndexSet) {
        withAnimation {
            if let index = offsets.first {
                sourceItems[index].composicion = ""
                sourceItems[index].save()
            }
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
                    if producto.composicion.isEmpty { // No se ven los productos que pertenecen a una composicion
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
