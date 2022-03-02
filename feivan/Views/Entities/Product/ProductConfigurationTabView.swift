//
//  ProductConfigurationTabView.swift
//  Feivan
//
//  Created by javigo on 1/3/22.
//

import SwiftUI

struct ProductConfigurationTabView: View {
    @State var tabSelection: Int
    @ObservedObject var productVM: ProductViewModel
    
    var body: some View {
        VStack {
            TabView(selection: $tabSelection){
                Group {
                    if productVM.showIf(equalTo: ["Curvas"]) {
                        ProductCurvasFormView(productVM: productVM).tag(1)
                    }
                    
                    ProductMaterialFormView(productVM: productVM).tag(2)
                    
                    ProductColorFormView(productVM: productVM).tag(3)
                    
                    ProductTapajuntasFormView(productVM: productVM).tag(4)
                    
                    ProductDimensionesFormView(productVM: productVM).tag(5)
                    
                    if productVM.notShowIf(familias: ["Persiana"]) {
                        ProductCristalFormView(productVM: productVM).tag(10)
                    }
                    
                    if productVM.notShowIf(familias: ["Fijos"]) {
                        ProductAperturaFormView(productVM: productVM).tag(6)
                    }
                    
                    if productVM.showIf(equalTo: ["Correderas", "Practicables"]) {
                        ProductCompactoFormView(productVM: productVM).tag(7)
                    }
                                        
                    if productVM.notShowIf(familias: ["Persiana"]) {
                        ProductForroExteriorFormView(productVM: productVM).tag(9)
                    }
    
                }
                
                Group {
                    ProductCerradurasFormView(productVM: productVM).tag(11)
                    
                    ProductManetasFormView(productVM: productVM).tag(12)
                    
                    ProductHerrajeFormView(productVM: productVM).tag(13)
                    
                    ProductPosicionFormView(productVM: productVM).tag(14)
                    
                    ProductInstalacionFormView(productVM: productVM).tag(15)
                    
                    if productVM.showIf(equalTo: ["Persianas"]) {
                        ProductMallorquinaFormView(productVM: productVM).tag(16)
                    }
                    
                    ProductHuellaFormView(productVM: productVM).tag(8)

                }

            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
    }
}
