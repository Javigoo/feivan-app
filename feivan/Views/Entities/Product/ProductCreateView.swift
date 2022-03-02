//
//  ProductCreateView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProductCreateView: View {
    @ObservedObject var productVM: ProductViewModel
    
    var body: some View {
        VStack {
            ProductFormView(productVM: productVM)
        }.onDisappear {
            productVM.save()
        }
    }
}
