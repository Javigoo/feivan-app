//
//  NewProjectSummaryView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct NewProjectSummary: View {
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>

    @EnvironmentObject var projectVM: ProjectViewModel
    
    var body: some View {

        VStack {
            ProjectView(projectVM: projectVM)
        }.toolbar {
            Button("Guardar") {
                projectVM.save()
                
                rootPresentation.wrappedValue = false
            }
        }
        .navigationTitle("Resumen del proyecto")
    }
}
