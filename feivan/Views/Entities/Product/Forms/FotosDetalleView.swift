//
//  FotoDetalleView.swift
//  Feivan
//
//  Created by javigo on 7/3/22.
//

import SwiftUI

struct FotosDetalleView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
        if imagesFromCoreData(object: productVM.fotos_detalle)?.count == 0 {
            NewFotosDetalleView(productVM: productVM)
        } else {
            NavigationLink(
                destination: ProductFotosDetalleFormView(productVM: productVM),
                label: {
                    HStack {
                        Text("Fotos detalle")
                        Spacer()
                        ZStack {
                            ForEach(imagesFromCoreData(object: productVM.fotos_detalle)!, id: \.self) { foto in
                                Image(uiImage: foto)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                }
            )
        }
    }
}

struct ProductFotosDetalleFormView: View {

    @ObservedObject var productVM: ProductViewModel
    
    @State private var inputImageFotoDetalle: UIImage?
    @State private var showCameraFotoDetalle = false
    @State private var showPhotoLibraryFotoDetalle = false
    @State private var showActionScheetFotoDetalle = false


    @State var fotos: [UIImage] = []

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Fotos detalle")) {
                    ForEach(imagesFromCoreData(object: productVM.fotos_detalle)!, id: \.self) { foto in
                        Image(uiImage: foto)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect()
                    }
                    .onDelete(perform: deleteFoto)
                }
                
            }
            .sheet(isPresented: $showCameraFotoDetalle, onDismiss: saveFotoDetalle) {
                ImagePicker(image: $inputImageFotoDetalle, sourceType: .camera)
            }
            .sheet(isPresented: $showPhotoLibraryFotoDetalle, onDismiss: saveFotoDetalle) {
                ImagePicker(image: $inputImageFotoDetalle, sourceType: .photoLibrary)
            }
            .actionSheet(isPresented: $showActionScheetFotoDetalle) { () -> ActionSheet in
                ActionSheet(
                    title: Text("Añadir foto detalle"),
                    buttons: [
                        ActionSheet.Button.default(
                            Text("Cámara"),
                            action: {
                                showCameraFotoDetalle.toggle()
                            }
                        ),
                        ActionSheet.Button.default(
                            Text("Galería"),
                            action: {
                                showPhotoLibraryFotoDetalle.toggle()
                            }
                        ),
                        ActionSheet.Button.cancel()
                    ]
                )
            }
            .toolbar {
                Button(action: {
                    showActionScheetFotoDetalle.toggle()
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }
        }
        .navigationTitle("Fotos detalle")
    }
    
    func saveFotoDetalle() {
        if var fotos_detalle = imagesFromCoreData(object: productVM.fotos_detalle) {
            if let foto_detalle = inputImageFotoDetalle {
                fotos_detalle.append(foto_detalle)
                if let data_fotos_detalle = coreDataObjectFromImages(images: fotos_detalle) {
                    productVM.fotos_detalle = data_fotos_detalle
                    productVM.save()
                }
            }
        }
    }
    
    private func deleteFoto(offsets: IndexSet) {
        withAnimation {
            productVM.deleteFoto(at: offsets)
        }
    }
    
}

struct NewFotosDetalleView: View {
    @ObservedObject var productVM: ProductViewModel
    
    @State private var inputImage: UIImage?
    @State private var showCamera = false

    var body: some View {
        HStack {
            Text("Fotos detalle")
            Spacer()
            Image(systemName: "photo")
        }.onTapGesture {
            showCamera.toggle()
        }.sheet(isPresented: $showCamera, onDismiss: save) {
            ImagePicker(image: $inputImage, sourceType: .camera)
        }
    }
    
    func save() {
        if var fotos_detalle = imagesFromCoreData(object: productVM.fotos_detalle) {
            if let foto_detalle = inputImage {
                fotos_detalle.append(foto_detalle)
                if let data_fotos_detalle = coreDataObjectFromImages(images: fotos_detalle) {
                    productVM.fotos_detalle = data_fotos_detalle
                    productVM.save()
                    print("saving foto detalle")
                }
            }
        }
    }
}

