//
//  NewClientView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct NewClient: View {

    @EnvironmentObject var projectVM: ProjectViewModel
    
    @StateObject var clientVM = ClientViewModel()
    
    @State private var isShowingNextView = false
    var body: some View {
        NavigationLink(destination: NewProduct().environmentObject(projectVM), isActive: $isShowingNextView) { EmptyView() }

        VStack {
            Form {
                ClientFormView(clientVM: clientVM)
            }
        }.toolbar {
            Button("Siguiente") {
                clientVM.save()
                
                projectVM.addClient(clientVM: clientVM)
                
                isShowingNextView = true
            }
        }
        .navigationTitle(Text("Nuevo cliente"))
    }
}
