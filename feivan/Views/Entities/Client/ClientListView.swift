//
//  ClientListView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ClientListView: View {
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
