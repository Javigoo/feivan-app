//
//  ProjectFormView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProjectFormView: View {
    @ObservedObject var projectVM: ProjectViewModel

    var body: some View {
        
        ProjectFormAddressView(projectVM: projectVM)
        
        Section(header: Text("Extras")) {
            Toggle(isOn: $projectVM.ascensor) {
                Text("Ascensor")
            }
            Toggle(isOn: $projectVM.grua) {
                Text("Grúa")
            }
            Toggle(isOn: $projectVM.subir_fachada) {
                Text("Subir fachada")
            }
            Toggle(isOn: $projectVM.remates_albanileria) {
                Text("Remates albañilería")
            }
            
            Toggle(isOn: $projectVM.medidas_no_buenas) {
                Text("Medidas no buenas")
            }
        }
    }
}

struct ProjectFormAddressView: View {
    @ObservedObject var projectVM: ProjectViewModel

    @State var direccion: String = ""
    @State var piso_puerta: String = ""

    var body: some View {
        Section(header: Text("Dirección")) {
            HStack {
                TextField("Calle, número, código postal, ciudad", text: $direccion)
                Button(action: {
                    getAddress { (address) in
                        direccion = address.getAddress()
                    }
                }, label: {
                    Image(systemName: "location")
                })
            }
            TextField("Piso y puerta", text: $piso_puerta)
        }
        .onAppear {
            if direccion.isEmpty {
                direccion = projectVM.direccion
            }
            if piso_puerta.isEmpty {
                piso_puerta = projectVM.piso_puerta
            }
        }.onDisappear {
            projectVM.direccion = direccion
            projectVM.piso_puerta = piso_puerta
            projectVM.save()
        }
    }
}
