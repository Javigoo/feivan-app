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
            // Data -> UUImage -> Image
            image = data_to_image(data: productVM.foto)
            //Image(uiImage: UIImage(data: productVM.foto)!)
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
            }
            .actionSheet(isPresented: $showActionScheet) { () -> ActionSheet in
                ActionSheet(
                    title: Text("Añadir foto"),
                    buttons: [
                        ActionSheet.Button.default(
                            Text("Cámara"),
                            action: {
                                showCamera.toggle()
                            }
                        ),
                        ActionSheet.Button.default(
                            Text("Galería"),
                            action: {
                                showPhotoLibrary.toggle()
                            }
                        ),
                        ActionSheet.Button.cancel()
                    ]
                )
            }
            .toolbar {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    productVM.foto = Data()
                }, label: {
                    Image(systemName: "trash")
                })
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
        // UIImage -> Data
        let pickedImage = uiimage_to_data(uiimage: inputImage)
        if pickedImage != nil {
            productVM.foto = pickedImage!
        } else {
            print("Error saving product photo")
        }
        productVM.save()
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

    var body: some View {
        HStack {
            Text("Foto")
            Spacer()
            Image(systemName: "photo")
        }.onTapGesture {
            showCamera.toggle()
        }.sheet(isPresented: $showCamera, onDismiss: save) {
            ImagePicker(image: $inputImage, sourceType: .camera)
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
