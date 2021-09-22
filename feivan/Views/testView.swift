//
//  Familia.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

import SwiftUI

struct testView: View {
    
    @FetchRequest(
        entity: Cliente.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Cliente.nombre, ascending: true)]
    ) var clients: FetchedResults<Cliente>
    
    var body: some View {
        VStack {
            
            Text("").navigationTitle("testView")
            
            Text("Number of clients: ", tableName: String(clients.count))
            
            List(clients, id: \.self) { client in
                Text(client.nombre ?? "name")
            }
            
            NavigationLink(destination: configurationView(), label: {
                Text("Siguiente")
            })
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
