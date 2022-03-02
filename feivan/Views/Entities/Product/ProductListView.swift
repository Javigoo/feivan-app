//
//  ProductListView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var productVM = ProductViewModel()
    
    var body: some View {
        List {
            ForEach(productVM.productos){ producto in
                NavigationLink(destination: ProductCreateView(productVM: ProductViewModel(product: producto)), label: {
                    ProductPreviewView(productVM: ProductViewModel(product: producto))
                })
            }
            .onDelete(perform: deleteProduct)
        }
        .onAppear(perform: productVM.getAllProducts)
    }
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            productVM.delete(at: offsets, for: productVM.productos)
        }
    }
}
