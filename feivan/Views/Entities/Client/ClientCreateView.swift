//
//  ClientCreateView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ClientCreateView: View {
    @ObservedObject var clientVM: ClientViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    init(clientVM: ClientViewModel) {
        self.clientVM = clientVM
    }
    
    var body: some View {
        VStack {
            Form {
                ClientFormView(clientVM: clientVM)
            }
        }.toolbar {
            Button("Guardar") {
                clientVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
//        .onDisappear {
//            clientVM.save()
//        }
    }
}
