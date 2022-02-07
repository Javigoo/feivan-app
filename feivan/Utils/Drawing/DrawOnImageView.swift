//
//  DrawOnImageView.swift
//  Feivan
//
//  Created by javigo on 5/2/22.
//

import SwiftUI
import PencilKit


struct Draw: View {
    var body: some View {
        
        VStack {
            //Image(uiImage: UIImage(named: "C2")!)
            DrawOnImageView(image: UIImage(named: "C2")! , onSave: saveImage)
        }
    }
    
    func saveImage(image: UIImage) {
        print("guardando")
    }
}

struct DrawOnImageView: View {

    var image: UIImage

    let onSave: (UIImage) -> Void

    @State private var drawingOnImage: UIImage = UIImage()
    @State private var canvasView: PKCanvasView = PKCanvasView()

    init(image: UIImage, onSave: @escaping (UIImage) -> Void) {
        self.image = image
        self.onSave = onSave
    }

    var body: some View {
        VStack {
            Button(action: {
                save()
            }, label: {
                Text("Save")
            })

            Image(uiImage: self.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
                .overlay(CanvasView(canvasView: $canvasView, onSaved: onChanged), alignment: .bottomLeading)
        }
    }

    private func onChanged() -> Void {
        self.drawingOnImage = canvasView.drawing.image(
            from: canvasView.bounds, scale: UIScreen.main.scale)
    }

    private func initCanvas() -> Void {
        self.canvasView = PKCanvasView();
        self.canvasView.isOpaque = false
        self.canvasView.backgroundColor = UIColor.clear
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

    @State var toolPicker = PKToolPicker()
}

extension CanvasView: UIViewRepresentable {
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .gray, width: 10)
        #if targetEnvironment(simulator)
        canvasView.drawingPolicy = .anyInput
        #endif
        canvasView.delegate = context.coordinator
        showToolPicker()
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(canvasView: $canvasView, onSaved: onSaved)
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
