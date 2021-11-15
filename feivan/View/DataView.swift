//
//  ProjectsListView.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import SwiftUI
import CoreData

struct DataView: View {
    @StateObject var projectVM = ProjectViewModel()

    var body: some View {
        List {
            ForEach(projectVM.proyectos, id: \.self) { proyecto in
                NavigationLink(
                    destination:
                        DataSummaryView(
                            projectVM: ProjectViewModel(project: proyecto)
                        ),
                    label: {
                        DataPreviewView(
                            projectVM: ProjectViewModel(project: proyecto)
                        )
                    }
                )
            }
            .onDelete(perform: deleteProject)
        }
        .onAppear(perform: projectVM.getAllProjects)
        .navigationTitle(Text("Proyectos"))
    }
    
    private func deleteProject(offsets: IndexSet) {
        withAnimation {
            projectVM.delete(at: offsets, for: projectVM.proyectos)
        }
    }
}

struct DataSummaryView: View {
    @ObservedObject var projectVM: ProjectViewModel
    @StateObject var productVM = ProductViewModel()

    var body: some View {

        VStack(alignment: .leading) {
            
            NavigationLink(
                destination:
                    ProjectCreateView(projectVM: projectVM).navigationTitle(Text("Información proyecto")),
                label: {
                    ProjectDetailView(projectVM: projectVM)
                }
            )
            .buttonStyle(.plain)
            
            Divider()
            
            if projectVM.haveClient() {
                Section(header: Text("Cliente")) {
                    NavigationLink(
                        destination:
                            ClientCreateView(clientVM: ClientViewModel(client: projectVM.getClient())).navigationTitle(Text("Información cliente")),
                        label: {
                            ClientDetailView(clientVM: ClientViewModel(client: projectVM.getClient()))
                        }
                    )
                    .buttonStyle(.plain)
                }
                .font(.title)
            
                Divider()
            }
            
            Section(header: Text("Productos")) {
                List {
                    ForEach(projectVM.getProducts() , id: \.self) { producto in
                        NavigationLink(
                            destination:
                                ProductCreateView(productVM: ProductViewModel(product: producto)).navigationTitle(Text("Información producto")),
                            label: {
                                ProductDetailView(productVM: ProductViewModel(product: producto))
                            }
                        )
                    }
                    .onDelete(perform: deleteProduct)
                    
                    NavigationLink(
                        destination:
                            ProductAddView(projectVM: projectVM)
                                .navigationTitle(Text("Información proyecto")),
                        label: {
                            Text("Añadir producto")
                                .font(.body)
                        }
                    )
                }
                .onAppear(perform: projectVM.getAllProjects)
            }
            .font(.title)
            
        }
        .padding()
        .navigationTitle(Text("Proyecto"))
    }
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            productVM.delete(at: offsets, for: projectVM.getProducts())
        }
    }

}

struct DataPreviewView: View {
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
