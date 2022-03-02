//
//  ProjectCreateView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProjectCreateView: View {
    @ObservedObject var projectVM: ProjectViewModel

    var body: some View {
        VStack {
            Form {
                ProjectFormView(projectVM: projectVM)
            }
        }
        .onDisappear(perform: {
            print("\nonDisappear - Project")
            projectVM.save()
        })
    }
}
