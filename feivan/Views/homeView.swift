//
//  Home.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

import SwiftUI

struct homeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 15){
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                
                NavigationLink(
                    destination: addNewClientView(),
                    label: {
                        Text("Nuevo")
                            .textStyle(NavigationLinkStyle())
                    }
                )
                
                NavigationLink(
                    destination: clientSummaryView(),
                    label: {
                        Text("Clientes")
                            .textStyle(NavigationLinkStyle())
                    }
                )
                
                NavigationLink(
                    destination: configurationView(),
                    label: {
                        Text("configurationView")
                            .textStyle(NavigationLinkStyle())
                    }
                )
                
                Spacer()
            
            }
        }
        .navigationTitle("Home")
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
