//
//  ProjectPreviewView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProjectPreviewView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Dirección")
                Spacer()
                Text(projectVM.direccion)
            }
            .font(.title)
            
            if projectVM.ascensor {
                Text("Ascensor").font(.subheadline)
            }
            
            if projectVM.grua {
                Text("Grúa").font(.subheadline)
            }

            if projectVM.subir_fachada {
                Text("Subir fachada").font(.subheadline)
            }
            
        }
        .padding()
    }
}

