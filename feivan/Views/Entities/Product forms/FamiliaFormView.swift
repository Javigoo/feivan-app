//
//  FamiliaFormView.swift
//  Feivan
//
//  Created by javigo on 24/11/21.
//

import SwiftUI

struct ProductFamiliaView: View {
    @Binding var showView: Bool
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
        
        NavigationLink(
            destination: {
                ProductFamiliaFormView(productVM: productVM, showView: $showView)
            },
            label: {
                if productVM.familia == "" {
                    Text("Familia")
                        .font(.title)
                } else {
                    Text(productVM.getSingularFamilia(name: productVM.familia))
                        .font(.title)
                }
            }
        )
    }
}
        
struct ProductFamiliaFormView: View {
    var atributo = "Familia"
    @ObservedObject var productVM: ProductViewModel
    @State private var isShowingNextView = false
    
    @Binding var showView: Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        ScrollView {
            
            NavigationLink(destination: ProductNombreFormView(productVM: productVM, showView: $showView), isActive: $isShowingNextView) { EmptyView() }
            
            ForEach(productVM.optionsFor(attribute: "Familias"), id: \.self) { familia in
                Button(
                    action: {
                        productVM.familia = familia
                        productVM.save()
                        isShowingNextView = true
                    },
                    label: {
                        Text(familia)
                            .textStyle(NavigationLinkStyle())
                            .padding()
                            .padding(.bottom, -25)
                    }
                )
            }
        }
        .navigationTitle(Text("Familias"))
        .onAppear(perform: {
            if showView {
                presentationMode.wrappedValue.dismiss()
            }
        })
        .onDisappear(perform: {
            showView = false
        })
    }
}
