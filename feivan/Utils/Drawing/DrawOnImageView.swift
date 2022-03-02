//
//  DrawOnImageView.swift
//  Feivan
//
//  Created by javigo on 5/2/22.
//

import SwiftUI
import PencilKit

//struct Drawing: View {
//    var image_name: String
//
//    var body: some View {
//        GeometryReader { proxy -> AnyView in
//            let size = proxy.frame(in: .global).size
//            return AnyView(
//                CanvasView(imageData: UIImage(imageLiteralResourceName: image_name).pngData()!, rect: size)
//            )
//        }.navigationTitle("Modificar producto")
//    }
//}
//
//struct CanvasView: UIViewRepresentable {
//
//    var imageData: Data
//    var rect: CGSize
//    @State var canvas = PKCanvasView()
//    @State var toolPicker = PKToolPicker()
//
//    func makeUIView(context: Context) -> PKCanvasView {
//        canvas.isOpaque = false
//        canvas.backgroundColor = .clear
//        canvas.drawingPolicy = .anyInput
//
//        if let image = UIImage(data: imageData) {
//            let imageView = UIImageView(image: image)
//            imageView.contentMode = .scaleAspectFit
//            imageView.clipsToBounds = true
//
//            print("Tamaño: ", rect)
//            //let padding: Double = 50
//            //imageView.frame = CGRect(x: 0 + padding, y: -130, width: rect.width - padding*2, height: rect.height - 200)
//            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height/2)
//
//            let subView = canvas.subviews[0]
//            subView.addSubview(imageView)
//            subView.sendSubviewToBack(imageView)
//
//            toolPicker.setVisible(true, forFirstResponder: canvas)
//            toolPicker.addObserver(canvas)
//            canvas.becomeFirstResponder()
//        }
//
//        return canvas
//    }
//
//    func updateUIView(_ uiView: PKCanvasView, context: Context) {
//
//    }
//
//}

struct DrawOnImageView: View {
    
    @State var image: UIImage = UIImage()
    let onSave: (UIImage) -> Void

    @ObservedObject var productVM: ProductViewModel
    @State private var drawingOnImage: UIImage = UIImage()
    @State private var canvasView: PKCanvasView = PKCanvasView()

    init(productVM: ProductViewModel, onSave: @escaping (UIImage) -> Void) {
        self.productVM = productVM
        if !productVM.imagen_dibujada.isEmpty {
            self.image = UIImage(data: productVM.imagen_dibujada)!
        } else if !productVM.nombre.isEmpty {
            self.image = UIImage(imageLiteralResourceName: productVM.nombre)
        }
            
        self.onSave = onSave
        initCanvas()
    }

    var body: some View {
        VStack {
//            GeometryReader{proxy -> AnyView in
//                let size = proxy.frame(in: .global).size
//                return AnyView(
//                    ZStack {
//                        CanvasView(canvasView: $canvasView, onSaved: onChanged, image_front: image, rect: size)
//                    }
//                )
//            }
            
            Image(uiImage: self.image)
                .resizable()
                .scaledToFit()
                .overlay(CanvasView(canvasView: $canvasView, onSaved: onChanged), alignment: .top)
                .padding(.bottom, 100)
        }
        .toolbar {
            Button(action: {
                self.image = UIImage(imageLiteralResourceName: productVM.nombre)
                self.canvasView.drawing = PKDrawing()
            }, label: {
                Image(systemName: "trash")
            })
        }
        .onDisappear {
            save()
        }
    }

    private func onChanged() -> Void {
        self.drawingOnImage = canvasView.drawing.image(
            from: canvasView.bounds, scale: UIScreen.main.scale)
    }

    private func initCanvas() -> Void {
        self.canvasView = PKCanvasView();
        self.canvasView.isOpaque = false
        self.canvasView.backgroundColor = .clear
        self.canvasView.becomeFirstResponder()
    }

    private func save() -> Void {
        onSave(self.image.mergeWith(topImage: drawingOnImage))
    }
}

public extension UIImage {
    func mergeWith(topImage: UIImage) -> UIImage {
        let bottomImage = self

        UIGraphicsBeginImageContext(size)


        let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
        bottomImage.draw(in: areaSize)

        topImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)

        let mergedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return mergedImage
    }
}

struct CanvasView {
    @Binding var canvasView: PKCanvasView
    let onSaved: () -> Void
//    let image_front: UIImage
//    let rect: CGSize

    @State var toolPicker = PKToolPicker()
}

extension CanvasView: UIViewRepresentable {
    func makeUIView(context: Context) -> PKCanvasView {
    
        canvasView.tool = PKInkingTool(.pen, color: .gray, width: 5)
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = context.coordinator
        
        // start
        
//        let imageView = UIImageView(image: image_front)
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
//
//        let subView = canvasView.subviews[0]
//        subView.addSubview(imageView)
//        subView.sendSubviewToBack(imageView)
        
        // finish
        
        showToolPicker()
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(canvasView: $canvasView, onSaved: onSaved)
    }
}

private extension CanvasView {
    func showToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
}

class Coordinator: NSObject {
    var canvasView: Binding<PKCanvasView>
    let onSaved: () -> Void

    init(canvasView: Binding<PKCanvasView>, onSaved: @escaping () -> Void) {
        self.canvasView = canvasView
        self.onSaved = onSaved
    }
}

extension Coordinator: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        if !canvasView.drawing.bounds.isEmpty {
            onSaved()
        }
    }
}
