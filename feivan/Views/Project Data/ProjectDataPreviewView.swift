//
//  ProjectsPreview.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProjectDataPreviewView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(projectVM.getClientName())
                .font(.title)
                .lineLimit(1)
            Text(projectVM.direccion)
                .font(.subheadline)
                .lineLimit(1)
            Spacer()
            Text(projectVM.textCountProducts())
                .font(.body)
        }
    }
}
