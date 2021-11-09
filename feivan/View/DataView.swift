//
//  ProjectsListView.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import SwiftUI
import CoreData

struct DataView: View {
    
    @StateObject var clientVM = ClientViewModel()
    @StateObject var productVM = ProductViewModel()
    @StateObject var projectVM = ProjectViewModel()
    
    var body: some View {
        DataListView(clientVM: clientVM, productVM: productVM, projectVM: projectVM)
            .navigationTitle(Text("Proyectos"))
    }
}

struct DataListView: View {
    
    @ObservedObject var clientVM: ClientViewModel
    @ObservedObject var productVM: ProductViewModel
    @ObservedObject var projectVM: ProjectViewModel

    var body: some View {
        List {
            ForEach(projectVM.proyectos, id: \.self) { proyecto in
                NavigationLink(destination: DataPreviewView(proyecto: proyecto, clientVM: clientVM, productVM: productVM, projectVM: projectVM), label: {
                    ProjectPreviewView(proyecto: proyecto)
                })
            }
            .onDelete(perform: deleteProject)
        }
    }
    
    private func deleteProject(offsets: IndexSet) {
        withAnimation {
            projectVM.delete(at: offsets, for: projectVM.proyectos)
        }
    }
}

struct DataPreviewView: View {
    
    @ObservedObject var proyecto: Proyecto
    @ObservedObject var clientVM: ClientViewModel
    @ObservedObject var productVM: ProductViewModel
    @ObservedObject var projectVM: ProjectViewModel

    var body: some View {
        VStack(alignment: .leading) {
            
            NavigationLink(destination: ProjectUpdateView(proyecto: proyecto, projectVM: projectVM), label: {
                ProjectDetailAllView(proyecto: proyecto)
            }).buttonStyle(.plain)
            
            Divider()
            
            Section(header: Text("Cliente")) {
                NavigationLink(destination: ClientUpdateView(clientVM: ClientViewModel(client: proyecto.cliente!)), label: {
                    ClientDetailView(cliente: proyecto.cliente!)
                }).buttonStyle(.plain)
            }.font(.title)

            Spacer()
            Divider()
            
            Section(header: Text("Productos")) {
                List {
                    ForEach(projectVM.getProducts(proyecto: proyecto) , id: \.self) { producto in
                        NavigationLink(destination: ProductUpdateView(producto: producto, productVM: productVM), label: {
                            ProductDetailView(producto: producto)
                        })
                    }
                    .onDelete(perform: deleteProduct)
                    /*
                    HStack {
                        Spacer()
                        NavigationLink(destination: ProductCreateView(productVM: productVM), label: {
                            Image(systemName: "plus.circle")
                        })
                        Spacer()
                    }
                     */
                }
            }.font(.title)
        }
        .padding()
        .navigationTitle(Text("Proyecto"))
    }
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            productVM.delete(at: offsets, for: productVM.productos)
        }
    }
}
