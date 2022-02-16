//
//  FotoFormView.swift
//  Feivan
//
//  Created by javigo on 4/12/21.
//

import Foundation
import SwiftUI

struct ProductFotoView: View {
    @ObservedObject var productVM: ProductViewModel

    var body: some View {
        if productVM.foto.isEmpty {
            ProductNewFotoFormView(productVM: productVM)
        } else {
            NavigationLink(
                destination: ProductFotoFormView(productVM: productVM),
                label: {
                    HStack {
                        Text("Foto")
                        Spacer()
                        Image(uiImage: UIImage(data: productVM.foto)!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                    }
                }
            )
        }
    }
}

struct ProductFotoFormView: View {

    @ObservedObject var productVM: ProductViewModel
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showCamera = false
    @State private var showPhotoLibrary = false
    @State private var showActionScheet = false
    
    @State private var inputImageFotoDetalle: UIImage?
    @State private var showCameraFotoDetalle = false
    @State private var showPhotoLibraryFotoDetalle = false
    @State private var showActionScheetFotoDetalle = false


    @State var fotos: [UIImage] = []

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    func loadImage() {
        if !productVM.foto.isEmpty {
             image = Image(uiImage: UIImage(data: productVM.foto)!)
        }
    }

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Foto seleccionada")) {
                    if !productVM.foto.isEmpty {
                        let image = Image(uiImage: UIImage(data: productVM.foto)!)
                        image
                            .resizable()
                            .scaledToFit()
                            .scaleEffect()
                            .onTapGesture {
                                showActionScheet.toggle()
                            }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect()
                            .onTapGesture {
                                showActionScheet.toggle()
                            }
                    }
                }
                
                
                Section(header: Text("Foto detalle")) {
                    
                    Button(action: {
                        showActionScheetFotoDetalle.toggle()
                    }, label: {
                        HStack {
                            Text("Añadir foto detalle")
                            Image(systemName: "plus.circle")
                        }
                    })
                    
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
            .sheet(isPresented: $showCamera, onDismiss: save) {
                ImagePicker(image: $inputImage, sourceType: .camera)
            }
            .sheet(isPresented: $showPhotoLibrary, onDismiss: save) {
                ImagePicker(image: $inputImage, sourceType: .photoLibrary)
            }.actionSheet(isPresented: $showActionScheet) { () -> ActionSheet in
                ActionSheet(
                    title: Text("Añadir foto"),
                    buttons: [
                        ActionSheet.Button.default(
                            Text("Abrir cámara"),
                            action: {
                                showCamera.toggle()
                            }
                        ),
                        ActionSheet.Button.default(
                            Text("Seleccionar desde la galería"),
                            action: {
                                showPhotoLibrary.toggle()
                            }
                        ),
                        ActionSheet.Button.cancel()
                    ]
                )
            }.actionSheet(isPresented: $showActionScheetFotoDetalle) { () -> ActionSheet in
                ActionSheet(
                    title: Text("Añadir foto detalle"),
                    buttons: [
                        ActionSheet.Button.default(
                            Text("Abrir cámara"),
                            action: {
                                showCameraFotoDetalle.toggle()
                            }
                        ),
                        ActionSheet.Button.default(
                            Text("Seleccionar desde la galería"),
                            action: {
                                showPhotoLibraryFotoDetalle.toggle()
                            }
                        ),
                        ActionSheet.Button.cancel()
                    ]
                )
            }
        }
        .navigationTitle("Fotos")
        .onDisappear {
            save()
        }
        .onAppear(perform: {
            loadImage()
            if productVM.foto.isEmpty {
                showCamera.toggle()
            }
        })
    }
    
    func save() {
        let pickedImage = inputImage?.jpegData(compressionQuality: 0.5)
        if pickedImage != nil {
            productVM.foto = pickedImage!
        } else {
            print("Error saving product photo")
        }
        productVM.save()
    }
    
    func saveFotoDetalle() {
        if var fotos_detalle = imagesFromCoreData(object: productVM.fotos_detalle) {
            if let foto_detalle = inputImageFotoDetalle {
                fotos_detalle.append(foto_detalle)
                if let data_fotos_detalle = coreDataObjectFromImages(images: fotos_detalle) {
                    productVM.fotos_detalle = data_fotos_detalle
                    productVM.save()
                    print("saving foto detalle")
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

struct ProductNewFotoFormView: View {

    @ObservedObject var productVM: ProductViewModel
    
    @State private var inputImage: UIImage?
    @State private var showCamera = false
    @State private var showPhotoLibrary = false
    @State private var showActionScheet = false

    var body: some View {
        HStack {
            Text("Foto")
            Spacer()
            Image(systemName: "photo")
        }.onTapGesture {
            showActionScheet.toggle()
        }.sheet(isPresented: $showCamera, onDismiss: save) {
            ImagePicker(image: $inputImage, sourceType: .camera)
        }
        .sheet(isPresented: $showPhotoLibrary, onDismiss: save) {
            ImagePicker(image: $inputImage, sourceType: .photoLibrary)
        }.actionSheet(isPresented: $showActionScheet) { () -> ActionSheet in
            ActionSheet(
                title: Text("Añadir foto"),
                buttons: [
                    ActionSheet.Button.default(
                        Text("Abrir cámara"),
                        action: {
                            showCamera.toggle()
                        }
                    ),
                    ActionSheet.Button.default(
                        Text("Seleccionar desde la galería"),
                        action: {
                            showPhotoLibrary.toggle()
                        }
                    ),
                    ActionSheet.Button.cancel()
                ]
            )
        }
    }
    
    func save() {
        let pickedImage = inputImage?.jpegData(compressionQuality: 0.5)
        if pickedImage != nil {
            productVM.foto = pickedImage!
        } else {
            print("Error saving product photo")
        }
        productVM.save()
    }
    
}
