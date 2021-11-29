//
//  ProjectsView.swift
//  Feivan
//
//  Created by javigo on 18/11/21.
//

import SwiftUI

struct ProjectsView: View {
    @ObservedObject var projectVM: ProjectViewModel
    @StateObject var productVM = ProductViewModel()

    var body: some View {

        VStack {
            Form {
                
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
            
                Section(header: Text("Productos")) {
                    List {
                        ForEach(projectVM.getProducts() , id: \.self) { producto in
                            NavigationLink(
                                destination: {
                                    ProductCreateView(productVM: ProductViewModel(product: producto)).navigationTitle(Text("Información producto"))
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
        /*
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
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
        }
         */
    }
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            productVM.delete(at: offsets, for: projectVM.getProducts())
        }
    }

}
