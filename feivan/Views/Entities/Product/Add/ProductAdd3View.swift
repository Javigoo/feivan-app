//
//  ProductAddColorCristalTapajuntasView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProductAdd3View: View {
    @ObservedObject var projectVM: ProjectViewModel
    @ObservedObject var originalProductVM: ProductViewModel
    @StateObject var productVM = ProductViewModel()
    
    var body: some View {
        VStack {
            ProductFormView(productVM: productVM)
        }.onDisappear {
            productVM.save()
            productVM.addProject(projectVM: projectVM)
        }.onAppear {
            productVM.setProductVMAdd3(productVM: originalProductVM)
        }
        .navigationTitle(Text("Información proyecto"))
    }
}
