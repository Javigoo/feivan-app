//
//  ProjectsView.swift
//  Feivan
//
//  Created by javigo on 18/11/21.
//

import SwiftUI

struct ProjectView: View {
    @ObservedObject var projectVM: ProjectViewModel
    @StateObject var productVM = ProductViewModel()
    @State var showAñadirProducto: Bool = false
    @State var showGenerarPdf: Bool = false
    var body: some View {

        VStack {
            NavigationLink(destination: PdfView(projectData: projectVM), isActive: $showGenerarPdf) { EmptyView() }
            NavigationLink(destination: ProductAddView(projectVM: projectVM), isActive: $showAñadirProducto) { EmptyView() }
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
                        ForEach(projectVM.getProducts() , id: \.self) { producto in
                            NavigationLink(
                                destination: {
                                    ProductCreateView(productVM: ProductViewModel(product: producto))
                                }, label: {
                                    ProductPreviewView(productVM: ProductViewModel(product: producto))
                                }
                            )
                        }
                        .onDelete(perform: deleteProduct)
                    }
                    .onAppear(perform: projectVM.getAllProjects)
                
                }
            }
        }
        .navigationTitle(Text("Proyecto"))
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showGenerarPdf = true
                }, label: {
                    Image(systemName: "doc")
                })
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button(action: {
                    showAñadirProducto = true
                }, label: {
                    Text("Añadir producto")
                })
            }
        }
    }
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            productVM.delete(at: offsets, for: projectVM.getProducts())
        }
    }

}

struct ProjectsPreview: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(projectVM.direccion)
                .font(.title)
            Text(projectVM.getClientName())
                .font(.subheadline)
            Spacer()
            Text(projectVM.textCountProducts())
                .font(.body)
        }
    }
}
