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
                    destination: clientView(),
                    label: {
                        Text("Nuevo")
                            .textStyle(NavigationLinkStyle())
                    }
                )
                
                NavigationLink(
                    destination: clientsView(),
                    label: {
                        Text("Clientes")
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
