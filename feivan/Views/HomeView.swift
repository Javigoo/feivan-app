//
//  HomeView.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import SwiftUI

struct HomeView: View {
    
    @State var showDebug: Bool = false
    @State private var rootPresenting: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            
            VStack(spacing: 30) {
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .padding(30)
                    .animation(.easeInOut)
                    .onTapGesture(count: 3) {
                        showDebug = true
                    }
                
                NavigationLink(
                    destination: NewProjectView(),
                    isActive: $rootPresenting,
                    label: {
                        Text("Nuevo proyecto")
                            .textStyle(NavigationLinkStyle())
                    }
                )

                NavigationLink(
                    destination: {
                        ProjectDataListView()
                    }, label: {
                        Text("Ver proyectos")
                            .textStyle(NavigationLinkStyle())
                    }
                )
            
                NavigationLink(destination: Debug(), isActive: $showDebug) { EmptyView() }

                Spacer()

            }

        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.rootPresentation, $rootPresenting)
    }
}
