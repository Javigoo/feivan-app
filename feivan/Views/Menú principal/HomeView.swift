//
//  HomeView.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import SwiftUI

struct HomeView: View {
    @State private var rootPresenting: Bool = false
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                NavigationLink(
                    destination: {
                        DebugView()
                    }, label: {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .padding(30)
                    }
                )
                     
                NavigationLink(
                    destination: {
                        ListProjectsView()
                    }, label: {
                        Text("Ver proyectos")
                            .textStyle(NavigationLinkStyle())
                    }
                )
                
                NavigationLink(
                    destination: NewProjectView(),
                    isActive: $rootPresenting,
                    label: {
                        Text("Nuevo proyecto")
                            .textStyle(NavigationLinkStyle())
                    }
                )
            
                Spacer()
            }

        }
        .environment(\.rootPresentation, $rootPresenting)
    }
}
