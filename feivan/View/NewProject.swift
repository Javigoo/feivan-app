//
//  NewProject.swift
//  Feivan
//
//  Created by javigo on 8/11/21.
//

import SwiftUI

struct NewProject: View {
    @StateObject var projectVM = ProjectViewModel()
    
    var body: some View {
        NewClient(projectVM: projectVM)
    }
}

struct NewClient: View {
    @ObservedObject var projectVM: ProjectViewModel
    @StateObject var clientVM = ClientViewModel()
    
    @State private var isShowingNextView = false
    var body: some View {
        NavigationLink(destination: NewProduct(projectVM: projectVM, clientVM: clientVM), isActive: $isShowingNextView) { EmptyView() }

        VStack {
            Form {
                ClientFormView(clientVM: clientVM)
            }
        }.toolbar {
            Button("Siguiente") {
                // Si se vuelve a esta vista actualizar el cliente, no crear uno nuevo
                clientVM.save()
                projectVM.addClient(clientVM: clientVM)
                // enlazar cliente al proyecto
                // enlazar proyecto al producto
                isShowingNextView = true
                    
            }
        }.navigationTitle(Text("Nuevo cliente"))
    }
}

struct NewProduct: View {
    @ObservedObject var projectVM: ProjectViewModel
    @ObservedObject var clientVM: ClientViewModel
    @StateObject var productVM = ProductViewModel()
    
    var body: some View {
        VStack {
            Text("ProductFamiliaFormView(producto: <#T##Producto#>, productVM: <#T##ProductViewModel#>)")
        }
    }
}
