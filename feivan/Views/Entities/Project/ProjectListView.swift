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
    
    var body: some View {
        List {
            ForEach(projectVM.proyectos){ proyecto in
                NavigationLink(destination: ProjectCreateView(projectVM: ProjectViewModel(project: proyecto)), label: {
                    ProjectPreviewView(projectVM: ProjectViewModel(project: proyecto))
                })
            }
            .onDelete(perform: deleteProject)
        }
        .onAppear(perform: projectVM.getAllProjects)
    }
    
    private func deleteProject(offsets: IndexSet) {
        withAnimation {
            projectVM.delete(at: offsets, for: projectVM.proyectos)
        }
    }
}
