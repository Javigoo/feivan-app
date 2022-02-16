//
//  NewProjectSummaryView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct NewProjectSummary: View {
    @ObservedObject var projectVM: ProjectViewModel

    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    
    var homeButton: some View {
        Button(action: {
            rootPresentation.wrappedValue = false
        }, label: {
            Image(systemName: "house")
        })
    }
    
    var body: some View {
        VStack {
            ProjectView(projectVM: projectVM)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: homeButton)
    }
}
