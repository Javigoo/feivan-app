//
//  HomeView.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {

                NavigationLink(
                    destination: DebugView(),
                    label: {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .padding(30)
                    }
                )
                     
                NavigationLink(
                    destination: ClientNewView(),
                    label: {
                        Text("Nuevo proyecto")
                    }
                )
                
                NavigationLink(
                    destination: DataView(),
                    label: {
                        Text("Ver proyectos")
                    }
                )
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

