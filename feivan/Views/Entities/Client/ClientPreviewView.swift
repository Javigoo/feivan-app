//
//  ClientPreviewView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ClientPreviewView: View {
    @ObservedObject var clientVM: ClientViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(clientVM.nombre)
                    .font(.title)
                Spacer()
                Text(clientVM.telefono)
                    .font(.body)
            }
            Text(clientVM.comentario)
                .font(.subheadline)
        }
        .padding()
    }
}
