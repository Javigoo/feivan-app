//
//  ProjectsPreview.swift
//  Feivan
//
//  Created by javigo on 18/11/21.
//

import SwiftUI

struct ProjectsPreview: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(projectVM.direccion)
                .font(.title)
            Text(projectVM.getClientName())
                .font(.subheadline)
            Spacer()
            Text(projectVM.textCountProducts())
                .font(.body)
        }
    }
}
