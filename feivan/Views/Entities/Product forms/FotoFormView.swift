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
            }
        }
        .navigationTitle("Foto")
        .toolbar {
            Button("Guardar") {
                save()
            }
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
        presentationMode.wrappedValue.dismiss()
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


/*
struct ProductNewFotoFormView: View {
    
    @ObservedObject var productVM: ProductViewModel
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = true
    @State private var shouldPresentCamera = false
    
    var body: some View {
        HStack {
            //Image(systemName: "camera")
            Text("Foto")
            Spacer()
            if image != nil {
                image!
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
            } else {
                Image(systemName: "photo")
            }
        }
        .onChange(of: image, perform: { _ in
            //productVM.foto = image
        })
        .onTapGesture) {
            self.shouldPresentActionScheet = true
        }
        .sheet(isPresented: $shouldPresentImagePicker) {
                SUImagePickerView(
                    sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,
                    image: self.$image,
                    isPresented: self.$shouldPresentImagePicker
                )
        }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
            ActionSheet(
                title: Text("Adjuntar foto"),
                buttons: [
                    ActionSheet.Button.default(
                        Text("Abrir cámara"),
                        action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = true
                        }
                    ),
                    ActionSheet.Button.default(
                        Text("Seleccionar desde la galería"),
                        action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = false
                        }
                    ),
                    ActionSheet.Button.cancel()
                ]
            )
        }
    }
}
*/
