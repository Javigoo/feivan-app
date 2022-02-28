//
//  ProjectsView.swift
//  Feivan
//
//  Created by javigo on 18/11/21.
//

import SwiftUI

struct ProjectView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    @State var productVM = ProductViewModel()
    
    @State var showAñadirProducto: Bool = false
    @State var showGenerarPdf: Bool = false
    
    @State var showAddMedidas: Bool = false
    @State var showAddColorCristalTapajuntas: Bool = false

    var body: some View {

        VStack {
            NavigationLink(destination: PdfView(projectData: projectVM), isActive: $showGenerarPdf) {
                EmptyView()
            }
            NavigationLink(destination: ProductAddView(projectVM: projectVM), isActive: $showAñadirProducto) {
                EmptyView()
            }
            NavigationLink(destination: ProductAddMedidasView(projectVM: projectVM, originalProductVM: productVM), isActive: $showAddMedidas) {
                EmptyView()
            }
            NavigationLink(destination: ProductAddColorCristalTapajuntasView(projectVM: projectVM, originalProductVM: productVM), isActive: $showAddColorCristalTapajuntas) {
                EmptyView()
            }

            Form {
                Section {
                    if projectVM.haveClient() {
                        NavigationLink(
                            destination:
                                ClientCreateView(clientVM: ClientViewModel(client: projectVM.getClient())).navigationTitle(Text("Cliente")),
                            label: {
                                Image(systemName: "person")
                                Text("Cliente")
                            }
                        )
                    }
                    
                    NavigationLink(
                        destination:
                            ProjectCreateView(projectVM: projectVM).navigationTitle(Text("Dirección y extras")),
                        label: {
                            Image(systemName: "gearshape")
                            Text("Dirección y extras")
                        }
                    )
                }
            
                Section(header: Text("Productos")) {
                    List {
                        ForEach(projectVM.getProducts(), id: \.self) { producto in
                            NavigationLink(
                                destination: {
                                    ProductCreateView(productVM: ProductViewModel(product: producto))
                                }, label: {
                                    ProductPreviewView(productVM: ProductViewModel(product: producto))
                                }
                            ).contextMenu {
                                Button(action: {
                                    productVM = ProductViewModel(product: producto)
                                    showAddMedidas = true
                                }, label: {
                                    Image(systemName: "plus.circle")
                                    Text("Añadir otro con medidas diferentes")
                                })
                                
                                Button(action: {
                                    productVM = ProductViewModel(product: producto)
                                    showAddColorCristalTapajuntas = true
                                }, label: {
                                    Image(systemName: "plus.circle")
                                    Text("Añadir otro con el mismo color, cristal y tapajuntas")
                                })
                                
//                                Button(action: {
//                                    print("Crear composición")
//                                }, label: {
//                                    Image(systemName: "plus.circle")
//                                    Text("Crear composición")
//                                })
                            }
                        }
                        .onDelete(perform: deleteProduct)
                        
                    }
                    .onAppear(perform: projectVM.getAllProjects)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    showAñadirProducto = true
                }, label: {
                    Text("Añadir producto")
                })
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showGenerarPdf = true
                }, label: {
                    Image(systemName: "doc")
                })
            }
        }
        .navigationTitle(Text("Proyecto"))
        
    }
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            productVM.delete(at: offsets, for: projectVM.getProducts())
        }
        projectVM.getAllProjects()
    }

}

struct ProjectsPreview: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(projectVM.getClientName())
                .font(.title)
                .lineLimit(1)
            Text(projectVM.direccion)
                .font(.subheadline)
                .lineLimit(1)
            Spacer()
            Text(projectVM.textCountProducts())
                .font(.body)
        }
    }
}
