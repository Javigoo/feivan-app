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
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Tipo de composición")) {
                    Picker("Tipo", selection: $tipo_composicion) {
                        List(["composicion-1", "composicion-2", "composicion-3", "composicion-4", "composicion-5", "composicion-6", "composicion-7", "composicion-8", "composicion-9", "composicion-10", "composicion-11", "composicion-12"], id: \.self) { item in
                            VStack {
                                Image(item)
                                    .resizable()
                                    .scaledToFit()
                            }
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
                    }
                }
            }
        }
        .navigationTitle(Text("Composición"))
        .onDisappear(perform: {
            for (n, product) in selectedItems.enumerated() {
                product.composicion = tipo_composicion+","+String(n+1)
                product.save()
            }
        })
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
                    if producto.composicion.isEmpty {
                        Button(action: {
                            print(maxProducts)
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
    
    func getNumProductSelection(producto: ProductViewModel) -> String {
        let num = selectedItems.firstIndex(of: producto) ?? -1
        if num == -1 {
            return ""
        }
        return String(num + 1)+".circle"
    }
}
