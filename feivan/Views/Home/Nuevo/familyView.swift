//
//  Familia.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

import SwiftUI

struct familyView: View {
    
    @FetchRequest(
        entity: Client.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Client.name, ascending: true)]
    ) var clients: FetchedResults<Client>
    
    var body: some View {
        VStack {
            
            Text("").navigationTitle("Familia")
            
            List(clients, id: \.self) { client in
                Text(client.name ?? "unknown")
                Text(client.phone ?? "unknown")
            }
            
            NavigationLink(destination: configurationView(), label: {
                Text("Siguiente")
            })
        }
    }
}

struct familyView_Previews: PreviewProvider {
    static var previews: some View {
        familyView()
    }
}
