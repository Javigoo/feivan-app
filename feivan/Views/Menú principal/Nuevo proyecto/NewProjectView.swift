//
//  NewProject.swift
//  Feivan
//
//  Created by javigo on 8/11/21.
//

import SwiftUI

struct NewProjectView: View {
    @StateObject var projectVM = ProjectViewModel()
    
    var body: some View {
        NewProject()
            .environmentObject(projectVM)
    }
}

struct NewProject: View {
    
    @EnvironmentObject var projectVM: ProjectViewModel
    
    @State private var isShowingNextView = false
    var body: some View {
        NavigationLink(destination: NewClient().environmentObject(projectVM), isActive: $isShowingNextView) { EmptyView() }

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

    @EnvironmentObject var projectVM: ProjectViewModel
    
    @StateObject var clientVM = ClientViewModel()
    @State private var isShowingNextView = false
    var body: some View {
        NavigationLink(destination: NewProduct().environmentObject(projectVM), isActive: $isShowingNextView) { EmptyView() }

        VStack {
            Form {
                ClientFormView(clientVM: clientVM)
            }
        }.toolbar {
            Button("Siguiente") {
                clientVM.save()
                projectVM.addClient(clientVM: clientVM)
                projectVM.save()
                isShowingNextView = true
            }
        }
        .navigationTitle(Text("Nuevo cliente"))
    }
}

struct NewProduct: View {
    @EnvironmentObject var projectVM: ProjectViewModel
    
    @StateObject var productVM = ProductViewModel()
    @State private var isShowingNextView = false
    var body: some View {
        NavigationLink(destination: NewProjectSummary().environmentObject(projectVM), isActive: $isShowingNextView) { EmptyView() }

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

struct NewProjectSummary: View {
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>

    @EnvironmentObject var projectVM: ProjectViewModel
    
    var body: some View {

        VStack {
            ProjectsView(projectVM: projectVM)
        }.toolbar {
            Button("Guardar") {
                projectVM.save()
                rootPresentation.wrappedValue = false
            }
        }
        .navigationTitle("Resumen del proyecto")
    }
}

