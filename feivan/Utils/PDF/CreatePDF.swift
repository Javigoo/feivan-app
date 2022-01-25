//
//  PDF.swift
//  Feivan
//
//  Created by javigo on 2/12/21.
//

import PDFKit
import SwiftUI

func createPDF(projectData: ProjectViewModel) -> Data {
    
    //let black: UIImage = UIImage(named: "black")!
    //black.draw(in: page_with_margins)
    
    // Pdf metadata
    let pdfMetaData = [
        kCGPDFContextCreator: "FEIVAN",
        kCGPDFContextAuthor: "https://www.industriasfeivan.com"
    ]
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]

    // Medidas A4: 210 x 297 mm == 8.3 x 11.7 inches
    let pageWidth = 8.3 * 72.0
    let pageHeight = 11.7 * 72.0
    let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
    
    let shared = PDFData(project: projectData)
    let data = renderer.pdfData { (context) in
    
        context.beginPage() // Crea una nueva página
        
        let page_with_margins = CGRect(
            x: shared.padding,
            y: shared.padding,
            width: pageWidth - (shared.padding * 2),
            height: pageHeight - (shared.padding * 2)
        )
        
        let page_header = CGRect(
            x: page_with_margins.origin.x,
            y: page_with_margins.origin.y,
            width: page_with_margins.width,
            height: page_with_margins.height * 0.1
        )

        let page_data = CGRect(
            x: page_header.origin.x,
            y: page_header.origin.y + page_header.height + shared.padding,
            width: page_with_margins.width,
            height: page_with_margins.height - page_header.height - shared.padding //+ page_header.height - shared.padding * 4
        )

        addHeader(shared: shared, page: page_header)
        
        /**
         Si solo hay un producto se dibuja en toda la página
         Si hay más de uno se dibujan los impares arriba y los pares abajo
         Si hay un número impar el último se dibuja en toda la página
         Si el producto es par y no es el último se crea otra página
         **/
        let products = shared.project.getProducts()
        for (n, product) in products.enumerated() {
            if (n+1) % 2 != 0 { // Es impar
                if n <= 1 { // Primera pagina con header
                    if n+1 == products.count { // Ultimo 
                        print("toda la pagina con header")
                        addProductAllPage(shared: shared, page: page_data, context: context.cgContext, product: product)
                    } else {
                        print("top con header")
                        addTopProduct(shared: shared, page: page_data, context: context.cgContext, product: product)
                    }
                } else {
                    if n+1 == products.count { // Ultimo
                        print("toda la pagina")
                        addProductAllPage(shared: shared, page: page_with_margins, context: context.cgContext, product: product)
                    } else {
                        print("top")
                        addTopProduct(shared: shared, page: page_with_margins, context: context.cgContext, product: product)
                    }
                }
            } else { // Es par
                if n <= 1 { // Primera pagina
                    if n+1 == products.count { // Ultimo
                        print("bottom con header")
                        addBottomProduct(shared: shared, page: page_data, context: context.cgContext, product: product)
                    } else {
                        print("bottom con header")
                        addBottomProduct(shared: shared, page: page_data, context: context.cgContext, product: product)
                        context.beginPage()
                    }
                } else {
                    if n+1 == products.count { // Ultimo
                        print("bottom")
                        addBottomProduct(shared: shared, page: page_with_margins, context: context.cgContext, product: product)
                    } else {
                        print("bottom")
                        addBottomProduct(shared: shared, page: page_with_margins, context: context.cgContext, product: product)
                        context.beginPage()
                    }
                }
            }
        }
    }
    
    return data
}


// Present PDF
struct PdfView: View {
    @ObservedObject var projectData: ProjectViewModel
    
    var body: some View {
        VStack {
            PdfPreview(projectData: projectData)
        }
        .navigationTitle(Text("Plantilla de medición"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: shareSheet) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
    
    func shareSheet() {
        // https://stackoverflow.com/questions/35851118/how-do-i-share-files-using-share-sheet-in-ios
        
        let data = createPDF(projectData: projectData) // Obtener pdf guardado en ProjectViewModel
        let fileURL = data.dataToFile(fileName: "feivan.pdf")
        
        var filesToShare = [Any]()
        filesToShare.append(fileURL!)
        
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        
        let context = UIApplication.shared.windows.first?.rootViewController
        context?.present(activityViewController, animated: true, completion: nil)
    }
}

// Create PDF
struct PdfPreview: UIViewRepresentable {
    @ObservedObject var projectData: ProjectViewModel

    typealias UIViewType = PDFView

    let data: Data
    
    init(projectData: ProjectViewModel){
        self.projectData = projectData
        data = createPDF(projectData: projectData)
    }

    func makeUIView(context _: UIViewRepresentableContext<PdfPreview>) -> UIViewType {
        // Create a PDFView and set its PDFDocument
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: data)
        pdfView.autoScales = true
        //pdfView.displayMode = .singlePage
        
        return pdfView
    }

    func updateUIView(_ pdfView: UIViewType, context _: UIViewRepresentableContext<PdfPreview>) {
        pdfView.document = PDFDocument(data: data)
    }
}
