//
//  ProjectListView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProjectListView: View {
    //Se crea una instancia nueva de clientVM solo para leer los clientes
    @StateObject var projectVM = ProjectViewModel()
    
    @State private var confirmDelete: Bool = false
    @State private var offsets: IndexSet?


    var body: some View {
        List {
            ForEach(projectVM.proyectos){ proyecto in
                NavigationLink(destination: ProjectCreateView(projectVM: ProjectViewModel(project: proyecto)), label: {
                    ProjectPreviewView(projectVM: ProjectViewModel(project: proyecto))
                }).alert(isPresented: $confirmDelete, content: {
                    Alert(title: Text("Confirma la eliminación"),
                        message: Text("¿Estás seguro de que quieres eliminarlo?"),
                        primaryButton: .destructive(Text("Eliminar")) {
                            projectVM.delete(at: offsets!, for: projectVM.proyectos)
                        }, secondaryButton: .cancel(Text("Cancelar"))
                    )
                })
            }
            .onDelete(perform: deleteProject)
        }
        .onAppear(perform: projectVM.getAllProjects)
    }
    
    private func deleteProject(offsets: IndexSet) {
        withAnimation {
            self.offsets = offsets
            self.confirmDelete = true
        }
    }
}
