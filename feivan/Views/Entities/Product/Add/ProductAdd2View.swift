//
//  ProductAddMedidasView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProductAdd2View: View {
    @ObservedObject var projectVM: ProjectViewModel
    @StateObject var productVM = ProductViewModel()
    @ObservedObject var originalProductVM: ProductViewModel
    @State private var showingSheet = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ProductFormView(productVM: productVM)
        }.sheet(isPresented: $showingSheet) {
            ProductDimensionesSheetView(productVM: productVM)
        }.onDisappear {
            productVM.save()
            productVM.addProject(projectVM: projectVM)
        }.onAppear(perform: {
            if productVM.dimensiones.isEmpty {
                productVM.setProductVMAdd2(productVM: originalProductVM)
                showingSheet = true
            }
        })
        .navigationTitle(Text("Información proyecto"))
    }
}
