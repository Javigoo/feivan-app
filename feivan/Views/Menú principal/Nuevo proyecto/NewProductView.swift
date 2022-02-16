//
//  NewProductView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct NewProduct: View {
    @ObservedObject var projectVM: ProjectViewModel

    @StateObject var productVM = ProductViewModel()
    
    @State private var isShowingNextView = false
    
    var body: some View {
        NavigationLink(destination: NewProjectSummary(projectVM: projectVM), isActive: $isShowingNextView) { EmptyView() }

        VStack {
            ProductFormView(productVM: productVM)
        }.toolbar {
            Button("Siguiente") {
                
                productVM.save()
                projectVM.addProduct(productVM: productVM)
                projectVM.save()
                
                isShowingNextView = true
            }
        }
        .navigationTitle(Text("Nuevo producto"))
    }
}
