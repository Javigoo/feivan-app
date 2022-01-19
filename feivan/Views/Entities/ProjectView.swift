//
//  ProjectView.swift
//  Feivan
//
//  Created by javigo on 22/10/21.
//

import SwiftUI

struct ProjectCreateView: View {
    @ObservedObject var projectVM: ProjectViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form {
                ProjectFormView(projectVM: projectVM)
            }
        }.toolbar {
            Button("Guardar") {
                projectVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProjectFormView: View {
    @ObservedObject var projectVM: ProjectViewModel

    var body: some View {
        
        ProjectFormAddressView(projectVM: projectVM)
        
        Section(header: Text("Extras")) {
            Toggle(isOn: $projectVM.ascensor) {
                Text("Ascensor")
            }
            Toggle(isOn: $projectVM.grua) {
                Text("Grúa")
            }
            Toggle(isOn: $projectVM.subir_fachada) {
                Text("Subir fachada")
            }
            Toggle(isOn: $projectVM.remates_albanileria) {
                Text("Remates Albañilería")
            }
            
            Toggle(isOn: $projectVM.medidas_no_buenas) {
                Text("Medidas no buenas")
            }
        }
    }
}

struct ProjectFormAddressView: View {
    @ObservedObject var projectVM: ProjectViewModel

    var body: some View {
        Section(header: Text("Dirección")) {
            TextField("Dirección del proyecto", text: $projectVM.direccion)
        }
    }
}


struct ProjectPreviewView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Dirección")
                Spacer()
                Text(projectVM.direccion)
            }
            .font(.title)
            
            if projectVM.ascensor {
                Text("Ascensor").font(.subheadline)
            }
            
            if projectVM.grua {
                Text("Grúa").font(.subheadline)
            }

            if projectVM.subir_fachada {
                Text("Subir fachada").font(.subheadline)
            }
            
        }
        .padding()
    }
}

struct ProjectDetailView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Dirección")
                Spacer()
                Text(projectVM.direccion)
            }
            .font(.subheadline)

            HStack {
                Text("Ascensor")
                Spacer()
                if projectVM.ascensor {
                    Text("Sí")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)

            HStack {
                Text("Grúa")
                Spacer()
                if projectVM.grua {
                    Text("Sí")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)

            HStack {
                Text("Subir fachada")
                Spacer()
                if projectVM.subir_fachada {
                    Text("Sí")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)
            
            HStack {
                Text("Remates albañilería")
                Spacer()
                if projectVM.remates_albanileria {
                    Text("Si")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)
            
            HStack {
                Text("Medidas No Buenas")
                Spacer()
                if projectVM.medidas_no_buenas {
                    Text("Si")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)

        }
    }
}

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
