//
//  ProjectsView.swift
//  Feivan
//
//  Created by javigo on 18/11/21.
//

import SwiftUI

struct ProjectDataView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    @State var productVM = ProductViewModel()
    
    @State var showAñadirProducto: Bool = false
    @State var showGenerarPdf: Bool = false
    @State var showAddMedidas: Bool = false
    @State var showAddColorCristalTapajuntas: Bool = false
    @State var showComposicion: Bool = false

    @State private var confirmDelete: Bool = false
    @State private var offsets: IndexSet?
    
    var body: some View {

        VStack {
            NavigationLink(destination: PdfView(projectData: projectVM), isActive: $showGenerarPdf) {
                EmptyView()
            }
            NavigationLink(destination: ProductAddView(projectVM: projectVM), isActive: $showAñadirProducto) {
                EmptyView()
            }
            NavigationLink(destination: ProductAdd2View(projectVM: projectVM, originalProductVM: productVM), isActive: $showAddMedidas) {
                EmptyView()
            }
            NavigationLink(destination: ProductAdd3View(projectVM: projectVM, originalProductVM: productVM), isActive: $showAddColorCristalTapajuntas) {
                EmptyView()
            }
            NavigationLink(destination: ComposicionFormView(projectVM: projectVM, sourceItems: projectVM.getProductsVM()), isActive: $showComposicion) {
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
                        ForEach(projectVM.getProductsVM(), id: \.self) { producto in
                            NavigationLink(
                                destination: {
                                    ProductCreateView(productVM: producto)
                                }, label: {
                                    ProductPreviewView(productVM: producto)
                                }
                            ).contextMenu {
                                Button(action: {
                                    productVM = producto
                                    showAddMedidas = true
                                }, label: {
                                    Image(systemName: "plus.circle")
                                    Text("Añadir otro con medidas diferentes")
                                })
                                
                                Button(action: {
                                    productVM = producto
                                    showAddColorCristalTapajuntas = true
                                }, label: {
                                    Image(systemName: "plus.circle")
                                    Text("Añadir otro con el mismo color, cristal y tapajuntas")
                                })
                            }
                            .alert(isPresented: $confirmDelete, content: {
                                withAnimation {
                                    Alert(title: Text("Confirma la eliminación"),
                                        message: Text("¿Estás seguro de que quieres eliminarlo?"),
                                        primaryButton: .destructive(Text("Eliminar")) {
                                            withAnimation {
                                                productVM.delete(at: offsets!, for: projectVM.getProducts())
                                            }
                                            projectVM.getAllProjects()
                                        }, secondaryButton: .cancel(Text("Cancelar"))
                                    )
                                }
                            })
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
                Menu(content: {
                    Button(action: {
                        showGenerarPdf = true
                    }, label: {
                        Text("Generar plantilla de medición")
                        Image(systemName: "doc")
                    })
                    Button(action: {
                        showComposicion = true
                    }, label: {
                        Text("Crear composición")
                        Image(systemName: "squareshape.split.2x2")
                    })
                }, label: {
                    Image(systemName: "line.3.horizontal")
                })
            }
        }
        .navigationTitle(Text("Proyecto"))
        
    }
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            self.offsets = offsets
            self.confirmDelete = true
        }
    }

}

