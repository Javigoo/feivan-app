//
//  Composicion.swift
//  Feivan
//
//  Created by javigo on 2/3/22.
//

import SwiftUI

struct ComposicionesView: View {
    @ObservedObject var projectVM: ProjectViewModel
    @StateObject var composicionVM: ComposicionViewModel = ComposicionViewModel()
    
    var body: some View {
        VStack {
            if composicionVM.composiciones.count != 0 {
                Form {
                    Section(header: Text("Lista de composiciones")) {
                        ForEach(composicionVM.composiciones) { composicion in
                            NavigationLink(
                                destination: {
                                    ComposicionFormView(projectVM: projectVM, composicionVM: ComposicionViewModel(composicion: composicion))
                                }, label: {
                                    ComposicionPreview(composicionVM: ComposicionViewModel(composicion: composicion))
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
                        ComposicionFormView(projectVM: projectVM, composicionVM: composicionVM)
                    }, label: {
                        Text("Añadir composición")
                    }
                )
            }
        }
        .navigationTitle(Text("Composiciones"))
    }
    
    private func deleteComposicion(offsets: IndexSet) {
        withAnimation {
            composicionVM.delete(at: offsets, for: composicionVM.composiciones)
        }
    }
}

struct ComposicionFormView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var projectVM: ProjectViewModel
    @ObservedObject var composicionVM: ComposicionViewModel

    @State var tipo_composicion: String = ""
    @State var selectedItems: [ProductViewModel] = []
    var composiciones =  ["composicion-1", "composicion-2", "composicion-3", "composicion-4", "composicion-5", "composicion-6",
                          "composicion-7", "composicion-8", "composicion-9", "composicion-10", "composicion-11", "composicion-12"]
    
    init(projectVM: ProjectViewModel, composicionVM: ComposicionViewModel) {
        self.projectVM = projectVM
        self.composicionVM = composicionVM
        self.selectedItems = composicionVM.getProducts()
    }
    
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
                    ComposicionSelectProducts(
                        sourceItems: projectVM.getProductsVM(),
                        selectedItems: $selectedItems,
                        maxProducts: getMaxNumProducts(tipo_composicion: tipo_composicion)
                    )
                }
            }
        }
        .navigationTitle(Text("Añadir composición"))
        .onAppear {
            if !composicionVM.tipo.isEmpty {
                tipo_composicion = composicionVM.tipo
            }
            if !(composicionVM.productos?.count == 0) {
                selectedItems = composicionVM.getProducts()
            }
        }
        .onDisappear(perform: {
            composicionVM.addComposicion(projectVM: projectVM, tipo: tipo_composicion, productosVM: selectedItems)
        })
    }
    
    private func deleteComposicion(offsets: IndexSet) {
        withAnimation {
            composicionVM.delete(at: offsets, for: composicionVM.getComposicionesOfProject(projectVM: projectVM))
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
                    //if producto.composicion == nil { // No se ven los productos que pertenecen a una composicion
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
                    //}
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

struct ComposicionPreview: View {
    @ObservedObject var composicionVM: ComposicionViewModel
    
    var productos: [Producto] = []
    
    init(composicionVM: ComposicionViewModel) {
        self.composicionVM = composicionVM
        self.productos = composicionVM.productos?.allObjects as? [Producto] ?? []
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(composicionVM.tipo)
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
}
