//
//  ProductView.swift
//  Feivan
//
//  Created by javigo on 23/10/21.
//

import SwiftUI

struct ProductCreateView: View {
    @ObservedObject var productVM: ProductViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ProductFormView(productVM: productVM)
        }.toolbar {
            Button("Guardar") {
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductAddView: View {
    @StateObject var productVM = ProductViewModel()
    @ObservedObject var projectVM: ProjectViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ProductFormView(productVM: productVM)
        }.toolbar {
            Button("Guardar") {
                productVM.save() // Se crea el producto
                
                productVM.addProject(projectVM: projectVM)
                productVM.save()
                
                projectVM.addProduct(productVM: productVM)
                projectVM.save()
                
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ProductAddMoreView: View {
    @StateObject var productVM = ProductViewModel()
    @ObservedObject var originalProductVM: ProductViewModel
    @State private var showingSheet = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ProductFormView(productVM: productVM)
        }.sheet(isPresented: $showingSheet) {
            ProductDimensionesSheetView(productVM: productVM)
        }.toolbar {
            Button("Guardar") {
                productVM.save()
                presentationMode.wrappedValue.dismiss()
            }
        }.onAppear(perform: {
            productVM.setProductVMAddMore(productVM: originalProductVM)
            showingSheet = true
        })
        .navigationTitle(Text("Información proyecto"))
    }
}

struct ProductFormView: View {
    
    @ObservedObject var productVM: ProductViewModel
    @State var showView: Bool = false
    @State var showAñadirMas: Bool = false

    var body: some View {
            
        NavigationLink(destination: ProductAddMoreView(originalProductVM: productVM), isActive: $showAñadirMas) { EmptyView() }

        if productVM.getFamilia() == "" {
                Text("Selecciona un producto")
        }
        
        ProductNombreView(showView: $showView, productVM: productVM)
        
        Form {
            
            Section(header: Text("Configuración")) {
                Group {
                    
                    ProductCurvasView(productVM: productVM)
                    
                    ProductMaterialView(productVM: productVM)
                    
                    ProductColorView(productVM: productVM)
                    
                    ProductTapajuntasView(productVM: productVM)
                    
                    ProductDimensionesView(productVM: productVM)

                    ProductAperturaView(productVM: productVM)

                    ProductCompactoView(productVM: productVM)
                    
                }
                
                Group {
                    
                    ProductMarcoInferiorView(productVM: productVM)

                    ProductHuellaView(productVM: productVM)

                    ProductForroExteriorView(productVM: productVM)

                    ProductCristalView(productVM: productVM)
                    
                    ProductCerradurasView(productVM: productVM)

                    ProductManetasView(productVM: productVM)

                    ProductHerrajeView(productVM: productVM)

                    ProductPosicionView(productVM: productVM)
                    
                    ProductInstalacionView(productVM: productVM)

                    ProductMallorquinaView(productVM: productVM)

                }
            }
            
            Group {
                    
                Section {
                    ProductFotoView(productVM: productVM)
                    //fotoNav(productVM: productVM)

                    Stepper("Unidades:  \(productVM.unidades)", value: $productVM.unidades, in: 1...99)
                }
                                
                if productVM.proyecto != nil {
                    Button(action: {
                        showAñadirMas = true
                    }, label: {
                        Text("Añadir más")
                            .font(.body)
                    })
                }
            }
        }
        .navigationTitle(Text(productVM.getFamilia()))
    }
}


struct ProductPreviewView: View {
    @ObservedObject var productVM: ProductViewModel
    var body: some View {
        HStack {
            
            if productVM.nombre == "" {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 50)
            } else {
                Image(productVM.nombre)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 50)
            }
            
            VStack(alignment: .leading){
                if productVM.unidades == 1 {
                    Text(productVM.getSingularFamilia(name: productVM.familia))
                        .font(.title3)
                        .lineLimit(1)
                } else {
                    Text(String(productVM.unidades)+" "+productVM.getFamilia())
                        .font(.title3)
                        .lineLimit(1)
                }
                HStack {
                    Text(productVM.getDimensiones(option: "ancho x alto"))
                        .font(.subheadline)
                        .lineLimit(1)
                }
            }
        }
    }
}

struct ProductDetailView: View {
    @ObservedObject var productVM: ProductViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                
                HStack {
                    Text("Familia")
                    Spacer()
                    Text(productVM.familia)
                }
                .font(.subheadline)
                
                HStack {
                    Text("Nombre")
                    Spacer()
                    Text(productVM.nombre)
                }
                .font(.subheadline)

                HStack {
                    Text("Material")
                    Spacer()
                    Text(productVM.material)
                }
                .font(.subheadline)

                HStack {
                    Text("Color")
                    Spacer()
                    Text(productVM.color)
                }
                .font(.subheadline)
                
                HStack {
                    Text("Tapajuntas")
                    Spacer()
                    Text(productVM.tapajuntas)
                }
                .font(.subheadline)

                HStack {
                    Text("Dimensiones")
                    Spacer()
                    Text(productVM.dimensiones)
                }
                .font(.subheadline)

                HStack {
                    Text("Apertura")
                    Spacer()
                    Text(productVM.apertura)
                }
                .font(.subheadline)

                HStack {
                    Text("Marco inferior")
                    Spacer()
                    Text(productVM.marco_inferior)
                }
                .font(.subheadline)

                HStack {
                    Text("Huella")
                    Spacer()
                    Text(productVM.huella)
                }
                .font(.subheadline)

            }

            Group {
                HStack {
                    Text("Forro exterior")
                    Spacer()
                    Text(productVM.forro_exterior)
                }
                .font(.subheadline)

                HStack {
                    Text("Cristal")
                    Spacer()
                    Text(productVM.cristal)
                }
                .font(.subheadline)

                HStack {
                    Text("Mallorquina")
                    Spacer()
                    Text(productVM.persiana)
                }
                .font(.subheadline)

                HStack {
                    Text("Cerraduras")
                    Spacer()
                    Text(productVM.cerraduras)
                }
                .font(.subheadline)

                HStack {
                    Text("Manetas")
                    Spacer()
                    Text(productVM.manetas)
                }
                .font(.subheadline)

                HStack {
                    Text("Herraje")
                    Spacer()
                    Text(productVM.herraje)
                }
                .font(.subheadline)

                HStack {
                    Text("Posición")
                    Spacer()
                    Text(productVM.posicion)
                }
                .font(.subheadline)

                HStack {
                    Text("Instalación")
                    Spacer()
                    Text(productVM.instalacion)
                }
                .font(.subheadline)
                
            }
        }
    }
}

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


// Otros
struct ProductTreeView: View {
    var optionSelect: String
    @ObservedObject var productVM: ProductViewModel
    @Binding var showView: Bool

    var body: some View {
        ScrollView {
            ProductTreeDirectoryView(optionSelect: optionSelect, productVM: productVM, showView: $showView)
            ProductTreeFileView(optionSelect: optionSelect, productVM: productVM, showView: $showView)
        }
        .navigationTitle(Text(optionSelect))
    }
}

struct ProductTreeDirectoryView: View {
    var optionSelect: String
    @ObservedObject var productVM: ProductViewModel
    
    @State private var seleccion = ""
    @State private var isShowingNextView = false
    @Binding var showView: Bool

    var body: some View {
        NavigationLink(destination: ProductTreeView(optionSelect: seleccion, productVM: productVM, showView: $showView), isActive: $isShowingNextView) { EmptyView() }

        ForEach(productVM.optionsFor(attribute: "Directorio \(optionSelect)"), id: \.self) { nombre in

            Button(
                action: {
                    seleccion = nombre
                    isShowingNextView = true
                },
                label: {
                    VStack {
                        Text(nombre)
                            .textStyle(NavigationLinkStyle())
                    }
                }
            )
        }
    }
}

struct ProductTreeFileView: View {
    var optionSelect: String
    @ObservedObject var productVM: ProductViewModel

    // Manage state
    @Binding var showView: Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 30)), count: 2), spacing: 10){
            ForEach(productVM.optionsFor(attribute: optionSelect), id: \.self) { nombre in
                Button(
                    action: {
                        productVM.nombre = nombre
                        productVM.save()
                        
                        // Volver atrás (dismiss o con isActive)
                        showView = true
                        presentationMode.wrappedValue.dismiss()
                        
                    },
                    label: {
                        VStack {
                            Image(nombre)
                                .resizable()
                                .scaledToFit()
                                //.shadow(radius: 3)
                        }
                    }
                )
            }
        }
        .padding()
        .onAppear(perform: {
            if showView{
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
}


