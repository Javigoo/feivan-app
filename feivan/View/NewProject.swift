//
//  NewProject.swift
//  Feivan
//
//  Created by javigo on 8/11/21.
//

import SwiftUI

struct NewProject: View {
    
    var body: some View {
        NewClient()
    }
}

struct NewClient: View {
    @StateObject var clientVM = ClientViewModel()
    
    @State private var isShowingNextView = false
    var body: some View {
        NavigationLink(destination: NewProduct(clientVM: clientVM), isActive: $isShowingNextView) { EmptyView() }

        VStack {
            Form {
                ClientFormView(clientVM: clientVM)
            }
        }.toolbar {
            Button("Siguiente") {
                clientVM.save()
                isShowingNextView = true
            }
        }
        .navigationTitle(Text("Nuevo cliente"))
    }
}

struct NewProduct: View {
    @ObservedObject var clientVM: ClientViewModel
    @StateObject var productVM = ProductViewModel()
    
    @State private var isShowingNextView = false
    var body: some View {
        NavigationLink(destination: Text("NewProduct(clientVM: clientVM)"), isActive: $isShowingNextView) { EmptyView() }

        VStack {
            ProductFormView(productVM: productVM)
        }.toolbar {
            Button("Siguiente") {
                productVM.save()
                isShowingNextView = true
            }
        }
        .navigationTitle(Text("Nuevo producto"))
    }
}
