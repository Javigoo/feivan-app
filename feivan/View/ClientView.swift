//
//  ContentView.swift
//  Feivan
//
//  Created by javigo on 20/10/21.
//

import SwiftUI
import CoreData

struct ClientView: View {
    var body: some View {
        Text("ClientView")
    }
}

struct ClientUpdateView: View {
    @ObservedObject var clientVM: ClientViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            ClientFormView(clientVM: clientVM)
        }
        .onAppear {
            //clientVM.getClient(cliente: cliente)
        }.toolbar {
            Button("Guardar") {
                clientVM.update(clientVM: clientVM)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ClientFormView: View {
    @ObservedObject var clientVM: ClientViewModel

    var body: some View {
        Form {
            Section(header: Text("Información de contacto")) {
                TextField("Nombre", text: $clientVM.nombre)
                TextField("Teléfono", text: $clientVM.telefono)
                    .keyboardType(.phonePad)
                TextField("Email", text: $clientVM.email)
                    .keyboardType(.emailAddress)
            }
            
            TextField("Referencia", text: $clientVM.referencia)
            
            Section(header: Text("Comentarios opcionales")) {
                TextEditor(text: $clientVM.comentario)
            }
        }
    }
}


struct ClientListView: View {
    
    //Se crea una instancia nueva de clientVM solo para leer los clientes
    @StateObject var clientVM = ClientViewModel()
    
    var body: some View {
        List {
            ForEach(clientVM.clientes){ cliente in
                NavigationLink(destination: ClientUpdateView(clientVM: ClientViewModel(client: cliente)), label: {
                    ClientPreviewView(cliente: cliente)
                })
            }
            .onDelete(perform: deleteClient)
        }
    }
    
    private func deleteClient(offsets: IndexSet) {
        withAnimation {
            clientVM.delete(at: offsets, for: clientVM.clientes)
        }
    }
}

struct ClientPreviewView: View {
    
    @ObservedObject var cliente: Cliente

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(cliente.nombre ?? "...")
                    .font(.title)
                Spacer()
                Text(cliente.telefono ?? "...")
                    .font(.body)
            }
            Text(cliente.comentario ?? "...")
                .font(.subheadline)
        }.padding()
    }
}


struct ClientDetailView: View {
    
    @ObservedObject var cliente: Cliente

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Nombre")
                Spacer()
                Text(cliente.nombre ?? "...")
            }
            .font(.subheadline)
            
            HStack {
                Text("Teléfono")
                Spacer()
                Text(cliente.telefono ?? "...")
            }
            .font(.subheadline)

            HStack {
                Text("Email")
                Spacer()
                Text(cliente.email ?? "...")
            }
            .font(.subheadline)
            
            HStack {
                Text("Referencia")
                Spacer()
                Text(cliente.referencia ?? "...")
            }
            .font(.subheadline)
            
            HStack {
                Text("Comentario")
                Spacer()
                Text(cliente.comentario ?? "...")
            }
            .font(.subheadline)

        }
    }
}
