//
//  ProductAddView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProductAddView: View {
    @ObservedObject var projectVM: ProjectViewModel
    @StateObject var productVM = ProductViewModel()
    
    var body: some View {
        VStack {
            ProductFormView(productVM: productVM)
        }.onDisappear {
            productVM.addProject(projectVM: projectVM)
            productVM.save()
        }
    }
}
