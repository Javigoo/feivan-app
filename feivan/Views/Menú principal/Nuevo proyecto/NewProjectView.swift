//
//  NewProject.swift
//  Feivan
//
//  Created by javigo on 8/11/21.
//

import SwiftUI


struct NewProjectView: View {
    
    @StateObject var projectVM = ProjectViewModel()

    @State private var isShowingNextView = false
    
    var body: some View {
        
        NavigationLink(destination: NewClient(projectVM: projectVM), isActive: $isShowingNextView) { EmptyView() }

        VStack {
            Form {
                ProjectFormView(projectVM: projectVM)
            }
        }.toolbar {
            Button("Siguiente") {
                projectVM.save()
                isShowingNextView = true
            }
            
        }
        .navigationTitle(Text("Nuevo proyecto"))
    }
}
