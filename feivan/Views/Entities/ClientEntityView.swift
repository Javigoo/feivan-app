//
//  ContentView.swift
//  Feivan
//
//  Created by javigo on 20/10/21.
//

import SwiftUI
import CoreData

struct ClientCreateView: View {
    @ObservedObject var clientVM: ClientViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form {
                ClientFormView(clientVM: clientVM)
            }
        }.toolbar {
            Button("Guardar") {
                clientVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
//        .onDisappear {
//            clientVM.save()
//        }
    }
}

struct ClientFormView: View {
    @ObservedObject var clientVM: ClientViewModel

    @State var leroy_merlin: Bool = false
    @State var maxi: Bool = false
    @State var obra: Bool = false
    @State var particular: Bool = false

    var body: some View {

        Group {
            Section(header: Text("Información de contacto")) {
                TextField("Nombre", text: $clientVM.nombre)
                TextField("Teléfono", text: $clientVM.telefono)
                    .keyboardType(.phonePad)
                TextField("Email", text: $clientVM.email)
                    .keyboardType(.emailAddress)
            }
            
            Section(header: Text("Tipo de cliente")) {
                Toggle("Leroy Merlin", isOn: $leroy_merlin)
                    .onChange(of: leroy_merlin) { _ in
                        if leroy_merlin {
                            maxi = false
                            obra = false
                            particular = false
                        }
                    }
                Toggle("Maxi",isOn: $maxi)
                    .onChange(of: maxi) { _ in
                        if maxi {
                            leroy_merlin = false
                            obra = false
                            particular = false
                        }
                    }
                Toggle("Obra",isOn: $obra)
                    .onChange(of: obra) { _ in
                        if obra {
                            leroy_merlin = false
                            maxi = false
                            particular = false
                        }
                    }
                Toggle("Particular",isOn: $particular)
                    .onChange(of: particular) { _ in
                        if particular {
                            leroy_merlin = false
                            maxi = false
                            obra = false
                        }
                    }
            }
                
            TextField("Referencia", text: $clientVM.referencia)
                
            Section(header: Text("Comentarios opcionales")) {
                TextEditor(text: $clientVM.comentario)
            }
        }.onAppear {
            let tipo = clientVM.tipo
            
            if tipo == "Leroy Merlin" {
                leroy_merlin = true
            }
            if tipo == "Maxi" {
                maxi = true
            }
            if tipo == "Obra" {
                obra = true
            }
            if tipo == "Particular" {
                particular = true
            }
        }.onDisappear {
            if leroy_merlin {
                clientVM.tipo = "Leroy Merlin"
            }
            if maxi {
                clientVM.tipo = "Maxi"
            }
            if obra {
                clientVM.tipo = "Obra"
            }
            if particular {
                clientVM.tipo = "Particular"
            }
            clientVM.save()
        }
    }
}

struct ClientPreviewView: View {
    @ObservedObject var clientVM: ClientViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(clientVM.nombre)
                    .font(.title)
                Spacer()
                Text(clientVM.telefono)
                    .font(.body)
            }
            Text(clientVM.comentario)
                .font(.subheadline)
        }
        .padding()
    }
}

struct ClientDetailView: View {
    @ObservedObject var clientVM: ClientViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Nombre")
                Spacer()
                Text(clientVM.nombre)
            }
            
            HStack {
                Text("Teléfono")
                Spacer()
                Text(clientVM.telefono)
            }

            HStack {
                Text("Email")
                Spacer()
                Text(clientVM.email)
            }
            
            HStack {
                Text("Referencia")
                Spacer()
                Text(clientVM.referencia)
            }
            
            HStack {
                Text("Comentario")
                Spacer()
                Text(clientVM.comentario)
            }
        }
        .font(.subheadline)
    }
}

struct ClientListView: View {
    //Se crea una instancia nueva de clientVM solo para leer los clientes
    @StateObject var clientVM = ClientViewModel()
    
    var body: some View {
        List {
            ForEach(clientVM.clientes){ cliente in
                NavigationLink(destination: ClientCreateView(clientVM: ClientViewModel(client: cliente)), label: {
                    ClientPreviewView(clientVM: ClientViewModel(client: cliente))
                })
            }
            .onDelete(perform: deleteClient)
        }
        .onAppear(perform: clientVM.getAllClients)
    }
    
    private func deleteClient(offsets: IndexSet) {
        withAnimation {
            clientVM.delete(at: offsets, for: clientVM.clientes)
        }
    }
}
