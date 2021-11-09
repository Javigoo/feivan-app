//
//  ProjectView.swift
//  Feivan
//
//  Created by javigo on 22/10/21.
//

import SwiftUI
import CoreData

struct ProjectView: View {
    var body: some View {
        Text("ProjectView")
    }
}

struct ProjectNewView: View {
    
    @StateObject var projectVM = ProjectViewModel()
    
    var body: some View {
        ProjectCreateView(projectVM: projectVM)
            .navigationTitle(Text("Nuevo proyecto"))
    }
}

struct ProjectCreateView: View {

    @ObservedObject var projectVM: ProjectViewModel

    var body: some View {
        VStack {
            Form {
                ProjectFormView(projectVM: projectVM)

                Button("Guardar") {
                    projectVM.save()
                }
            }
        }
    }
}

struct ProjectUpdateView: View {

    var proyecto: Proyecto
    @ObservedObject var projectVM: ProjectViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form {
                ProjectFormView(projectVM: projectVM)
            }
        }
        .onAppear {
            projectVM.getProject(proyecto: proyecto)
        }.toolbar {
            Button("Guardar") {
                projectVM.update(proyecto: proyecto)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProjectFormView: View {
    
    @ObservedObject var projectVM: ProjectViewModel

    var body: some View {
        ProjectFormAddressView(projectVM: projectVM)
        
        Section(header: Text("Extras del proyecto")) {
            Toggle(isOn: $projectVM.ascensor) {
                Text("Ascensor")
            }
            Toggle(isOn: $projectVM.grua) {
                Text("Grúa")
            }
            Toggle(isOn: $projectVM.subirFachada) {
                Text("Subir fachada")
            }
        }
    }
}

struct ProjectFormAddressView: View {
    
    @ObservedObject var projectVM: ProjectViewModel

    var body: some View {
        Section(header: Text("Dirección del proyecto")) {
            TextField("Dirección", text: $projectVM.direccion)
        }
    }
}


// To refact

struct ProjectPreviewView: View {
    @StateObject var proyecto: Proyecto
    @StateObject var projectVM = ProjectViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(proyecto.direccion ?? "...")
                .font(.title)
            Text(proyecto.cliente?.nombre ?? "...")
                .font(.subheadline)
            Spacer()
            Text(projectVM.textCountProducts(project: proyecto))
                .font(.body)
        }
        .onAppear(perform: projectVM.getAllProjects)
    }
}

struct ProjectDetailView: View {
    @ObservedObject var proyecto: Proyecto
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Dirección")
                Spacer()
                Text(proyecto.direccion ?? "...")
            }
            .font(.title)
            
            if proyecto.ascensor {
                Text("Ascensor").font(.subheadline)
            }
            
            if proyecto.grua {
                Text("Grúa").font(.subheadline)
            }

            if proyecto.subirFachada {
                Text("Subir fachada").font(.subheadline)
            }
            
        }.padding()
    }
}

struct ProjectDetailAllView: View {
    @ObservedObject var proyecto: Proyecto
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Dirección")
                Spacer()
                Text(proyecto.direccion ?? "...")
            }
            .font(.subheadline)

            HStack {
                Text("Ascensor")
                Spacer()
                if proyecto.ascensor {
                    Text("Sí")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)

            HStack {
                Text("Grúa")
                Spacer()
                if proyecto.grua {
                    Text("Sí")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)

            HStack {
                Text("Subir fachada")
                Spacer()
                if proyecto.subirFachada {
                    Text("Sí")
                } else {
                    Text("No")
                }
            }
            .font(.subheadline)

        }
    }
}
