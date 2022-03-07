//
//  ProjectsListView.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import SwiftUI

struct ProjectDataListView: View {
    @StateObject var projectVM = ProjectViewModel()

    @State private var confirmDelete: Bool = false
    @State private var offsets: IndexSet?
    
    var body: some View {
        VStack{
            if projectVM.proyectos.count == 0 {
                Text("No hay proyectos")
            } else {
                List {
                    ForEach(projectVM.getProjectsVM(), id: \.self) { proyecto in
                        NavigationLink(
                            destination:
                                ProjectDataView(
                                    projectVM: proyecto
                                ),
                            label: {
                                ProjectDataPreviewView(
                                    projectVM: proyecto
                                )
                            }
                        ).alert(isPresented: $confirmDelete, content: {
                            withAnimation {
                                Alert(title: Text("Confirma la eliminación"),
                                    message: Text("¿Estás seguro de que quieres eliminarlo?"),
                                    primaryButton: .destructive(Text("Eliminar")) {
                                        withAnimation {
                                            projectVM.delete(at: offsets!, for: projectVM.proyectos)
                                        }
                                    }, secondaryButton: .cancel(Text("Cancelar"))
                                )
                            }
                        })
                    }
                    .onDelete(perform: deleteProject)
                }
            }
        }
        .onAppear(perform: projectVM.getAllProjects)
        .navigationTitle(Text("Ver proyectos"))
    }
    
    private func deleteProject(offsets: IndexSet) {
        withAnimation {
            self.offsets = offsets
            self.confirmDelete = true
        }
    }
}
