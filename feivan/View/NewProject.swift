//
//  NewProject.swift
//  Feivan
//
//  Created by javigo on 8/11/21.
//

import SwiftUI

struct NewProject: View {
    @StateObject var projectVM = ProjectViewModel()
    
    @State private var isShowingNextView = false
    var body: some View {
        NavigationLink(destination: NewClient(projectVM: projectVM), isActive: $isShowingNextView) { EmptyView() }

        VStack {
            Form {
                ProjectFormView(projectVM: projectVM)
            }
        }.toolbar {
            Button("Siguiente") {
                projectVM.save()
                isShowingNextView = true
            }
        }
        .navigationTitle(Text("Nuevo proyecto"))
    }
}

struct NewClient: View {
    @ObservedObject var projectVM: ProjectViewModel
    @StateObject var clientVM = ClientViewModel()
    
    @State private var isShowingNextView = false
    var body: some View {
        NavigationLink(destination: NewProduct(projectVM: projectVM), isActive: $isShowingNextView) { EmptyView() }

        VStack {
            Form {
                ClientFormView(clientVM: clientVM)
            }
        }.toolbar {
            Button("Siguiente") {
                clientVM.addProject(projectVM: projectVM)
                clientVM.save()
                
                isShowingNextView = true
            }
        }
        .navigationTitle(Text("Nuevo cliente"))
    }
}

struct NewProduct: View {
    @ObservedObject var projectVM: ProjectViewModel
    @StateObject var productVM = ProductViewModel()
    
    @State private var isShowingNextView = false
    var body: some View {
        NavigationLink(destination: DataSummaryView(projectVM: projectVM), isActive: $isShowingNextView) { EmptyView() }

        VStack {
            ProductFormView(productVM: productVM)
        }.toolbar {
            Button("Siguiente") {
                productVM.addProject(projectVM: projectVM)
                productVM.save()
                isShowingNextView = true
            }
        }
        .navigationTitle(Text("Nuevo producto"))
    }
}
