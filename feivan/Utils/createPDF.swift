//
//  PDF.swift
//  Feivan
//
//  Created by javigo on 2/12/21.
//

import PDFKit
import SwiftUI

func createPDF(projectData: ProjectViewModel) -> Data {
    
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
        //let black: UIImage = UIImage(named: "black")!
        //black.draw(in: page_with_margins)
        
        let page_header = CGRect(
            x: page_with_margins.origin.x,
            y: page_with_margins.origin.y,
            width: page_with_margins.width,
            height: page_with_margins.height * 0.1
        )
        
        let page_anotations = CGRect(
            x: page_header.origin.x,
            y: page_header.origin.y + page_header.height + shared.half_padding,
            width: page_with_margins.width,
            height: page_with_margins.height * 0.025
        )

        let page_data = CGRect(
            x: page_anotations.origin.x,
            y: page_anotations.origin.y + page_anotations.height + shared.padding,
            width: page_with_margins.width,
            height: page_with_margins.height - page_anotations.origin.y + page_anotations.height - shared.padding * 4
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
            if products.count == 1 {
                addProductAllPage(shared: shared, page: page_data, context: context.cgContext, product: product)
            } else if n+1 == products.count {
                addProductAllPage(shared: shared, page: page_with_margins, context: context.cgContext, product: product)
            } else {
                addProductAllPage(shared: shared, page: page_data, context: context.cgContext, product: product)
                context.beginPage()
            }
        }
        /*
        for (n, product) in products.enumerated() {
            if (n+1) % 2 != 0 { // Es impar?
                if (n+1) == products.count { // Es el último?
                    addProductAllPage(shared: shared, page: page_data, context: context.cgContext, product: product)
                } else {
                    //addProductTopPage(shared: shared, product: product)
                }
            } else {
                //addProductBottomPage(shared: shared, product: product)
                if (n+1) == products.count {
                    // newPage()
                }
            }
        }
         */
    }
    
    return data
}

func addProductAllPage(shared: PDFData, page: CGRect, context: CGContext, product: Producto) {
    let product = ProductViewModel(product: product)
    
    let page_image = CGRect(
        x: page.origin.x,
        y: page.origin.y,
        width: (page.width / 2) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )

    let page_foto = CGRect(
        x: page.origin.x,
        y: page.origin.y + (page.height / 2) + shared.half_padding,
        width: (page.width / 2) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )
    
    let page_data = CGRect(
        x: page.origin.x + (page.width / 2) + shared.half_padding,
        y: page.origin.y,
        width: (page.width / 2) - shared.half_padding,
        height: page.height
    )
    
    addProductImage(shared: shared, page: page_image, product: product)
    addProductPhoto(shared: shared, page: page_foto, product: product)
    addProductData(shared: shared, page: page_data, context: context, product: product)

}

func addProductImage(shared: PDFData, page: CGRect, product: ProductViewModel) {
    
    if product.nombre.isEmpty {
        return
    }
    
    let image: UIImage = UIImage(imageLiteralResourceName: product.nombre)
   
    let aspectWidth = page.width / image.size.width
    let aspectHeight = page.height / image.size.height
    let aspectRatio = min(aspectWidth, aspectHeight)

    let scaledWidth = image.size.width * aspectRatio
    let scaledHeight = image.size.height * aspectRatio
    
    var origin_x: Double = page.origin.x
    if page.width > scaledWidth  {
        origin_x += (page.width - scaledWidth) / 2
    }
    
    var origin_y: Double = page.origin.y
    if page.height > scaledHeight  {
        origin_y += (page.height - scaledHeight) / 2
    }
    
    let scaled_page = CGRect(x: origin_x,
                             y: origin_y,
                             width: scaledWidth,
                             height: scaledHeight
                        )
    
    image.draw(in: scaled_page)
    
}

func addProductPhoto(shared: PDFData, page: CGRect, product: ProductViewModel) {
    if product.foto.isEmpty {
        return
    }

    let image = UIImage(data: product.foto)!

    let aspectWidth = page.width / image.size.width
    let aspectHeight = page.height / image.size.height
    let aspectRatio = min(aspectWidth, aspectHeight)

    let scaledWidth = image.size.width * aspectRatio
    let scaledHeight = image.size.height * aspectRatio
    
    var origin_x: Double = page.origin.x
    if page.width > scaledWidth  {
        origin_x += (page.width - scaledWidth) / 2        
    }
    
    var origin_y: Double = page.origin.y
    if page.height > scaledHeight  {
        origin_y += (page.height - scaledHeight) / 2
    }
    
    let scaled_page = CGRect(x: origin_x,
                             y: origin_y,
                             width: scaledWidth,
                             height: scaledHeight
                        )

    image.draw(in: scaled_page)
    
}

func addProductData(shared: PDFData, page: CGRect, context: CGContext, product: ProductViewModel) {
    
    let font_size = 11.0
    // Titulo
    var textFont = UIFont.systemFont(ofSize: font_size, weight: .bold)
    var paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .natural
    paragraphStyle.lineBreakMode = .byWordWrapping
    var text_attributes = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont
        ]
        
    let atributos = ["Curvas", "Material", "Color", "Tapajuntas", "Dimensiones", "Apertura", "Compacto", "Marco inferior", "Huella", "Forro exterior", "Cristal", "Cerraduras", "Manetas", "Herraje", "Posición", "Instalación", "Remates albañilería", "Medidas no buenas", "Persiana"]
    
    var resultado_atributos: String = ""
    for atributo_to_print in atributos {
        let lineas_atributo = product.get(attribute: atributo_to_print).split(separator: "\n").count
        if lineas_atributo != 0 {
            resultado_atributos += "\(atributo_to_print)" + String(repeating: "\n", count: lineas_atributo+1)
        }
    }
    var attributedText = NSAttributedString(string: resultado_atributos, attributes: text_attributes)
    attributedText.draw(in: page)
    
    // Datos
    textFont = UIFont.systemFont(ofSize: font_size, weight: .regular)
    paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .right
    paragraphStyle.lineBreakMode = .byWordWrapping
    text_attributes = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont
    ]
    
    resultado_atributos = ""
    for atributo_to_print in atributos {
        let lineas = product.get(attribute: atributo_to_print).split(separator: "\n")
        let lineas_atributo = lineas.count
        if lineas_atributo != 0 {
            for value in lineas{
                resultado_atributos += "\(value)\n"
            }
            resultado_atributos += "\n"
        }
    }
    attributedText = NSAttributedString(string: resultado_atributos, attributes: text_attributes)
    attributedText.draw(in: page)

}

func addHeader(shared: PDFData, page: CGRect) {
    
    let client: ClientViewModel = ClientViewModel(client: shared.project.getClient())
    
    let logo_width = addLogo(shared: shared, page: page)
    
    let page_header_data = CGRect(
        x: page.origin.x + logo_width,
        y: page.origin.y,
        width: page.width - logo_width,
        height: page.height
    )
    
    
    addCliente(shared: shared, page: page_header_data, text: client.nombre)
    addTelefono(shared: shared, page: page_header_data,text: client.telefono)
    
    addDireccion(shared: shared, page: page_header_data, text: shared.project.direccion)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/YY"
    let fecha = dateFormatter.string(from: shared.project.timestamp)
    addFecha(shared: shared, page: page_header_data, text: fecha)

    addEmail(shared: shared, page: page_header_data, text: client.email)
    addReferencia(shared: shared, page: page_header_data, text: client.referencia)
    
    var extras: [String] = []
    if shared.project.ascensor {
        extras.append("ascensor")
    }
    if shared.project.grua {
        extras.append("grúa")
    }
    if shared.project.subir_fachada {
        extras.append("subir a la fachada")
    }
    if shared.project.remates_albanileria {
        extras.append("remates de albañilería")
    }
    
    var intro = ""
    if extras.count != 0 {
        intro = "Se necesita "
    }
    
    var extras_result = intro
    if extras.count <= 2 {
        extras_result += extras.joined(separator: " y ")
    } else {
        guard let last = extras.last else { return }
        extras_result += extras.dropLast().joined(separator: ", ") + " y " + last
    }
  
    addExtras(shared: shared, page: page_header_data, text: extras_result)


}

func addExtras(shared: PDFData, page: CGRect, text: String) {
    let attributedText = NSAttributedString(string: text, attributes: shared.text_attributes)
    let textRect = CGRect(
                        x: page.origin.x,
                        y: page.origin.y + 60,
                        width: page.width,
                        height: page.height
                    )
    attributedText.draw(in: textRect)
}

func addLogo(shared: PDFData, page: CGRect) -> Double {
    let image: UIImage = UIImage(named: "Logo")!
    
    // 1
    let maxHeight = page.height
    let maxWidth = page.width * 0.2
    // 2
    let aspectWidth = maxWidth / image.size.width
    let aspectHeight = maxHeight / image.size.height
    let aspectRatio = min(aspectWidth, aspectHeight)
    // 3
    let scaledWidth = image.size.width * aspectRatio
    let scaledHeight = image.size.height * aspectRatio
    
    let imageRect = CGRect(x: shared.padding,
                           y: shared.padding,
                           width: scaledWidth,
                           height: scaledHeight)
    // 5
    image.draw(in: imageRect)
    
    return imageRect.origin.x + imageRect.size.width
}
 
func addCliente(shared: PDFData, page: CGRect, text: String) {
    let attributedText = NSAttributedString(string: "Cliente: \(text)", attributes: shared.text_attributes)
    let textRect = CGRect(
                        x: page.origin.x,
                        y: page.origin.y,
                        width: page.width / 2,
                        height: page.height
                    )
    attributedText.draw(in: textRect)
}

func addTelefono(shared: PDFData, page: CGRect, text: String) {
    let string_data = "Teléfono: \(text)"
    let attributedText = NSAttributedString(string: string_data, attributes: shared.text_attributes)
    let textRect = CGRect(x: page.origin.x + (page.width / 2) * 1.3,
                          y: page.origin.y,
                          width:  page.width - ((page.width / 2) * 1.3),
                          height: page.height
                    )
    attributedText.draw(in: textRect)
}

func addDireccion(shared: PDFData, page: CGRect, text: String) {
        
    let attributedText = NSAttributedString(string: "Dirección: \(text)", attributes: shared.text_attributes)
    let textRect =  CGRect(
                        x: page.origin.x,
                        y: page.origin.y + 15,
                        width: page.width / 2,
                        height: page.height
                    )

    attributedText.draw(in: textRect)
}

func addFecha(shared: PDFData, page: CGRect, text: String) {
        
    let attributedText = NSAttributedString(string: "Fecha: \(text)", attributes: shared.text_attributes)
    let textRect =  CGRect(
                        x: page.origin.x + (page.width / 2) * 1.3,
                        y: page.origin.y + 15,
                        width: page.width - ((page.width / 2) * 1.3),
                        height: page.height
                    )

    attributedText.draw(in: textRect)
}

func addEmail(shared: PDFData, page: CGRect, text: String) {
        
    let attributedText = NSAttributedString(string: "Email: \(text)", attributes: shared.text_attributes)
    let textRect =  CGRect(
                        x:  page.origin.x,
                        y:  page.origin.y + 30,
                        width: page.width / 2,
                        height: page.height
                    )

    attributedText.draw(in: textRect)
}

func addReferencia(shared: PDFData, page: CGRect, text: String) {
        
    let attributedText = NSAttributedString(string: "Referencia: \(text)", attributes: shared.text_attributes)
    let textRect =  CGRect(
                        x: page.origin.x + (page.width / 2) * 1.3,
                        y: page.origin.y + 30,
                        width: page.width - ((page.width / 2) * 1.3),
                        height: page.height
                    )

    attributedText.draw(in: textRect)
}
 
func addProductTopPage(shared: PDFData, product: Producto) {
    let product = ProductViewModel(product: product)
    print("\(product.familia) se dibuja arriba en la página" )
}

func addProductBottomPage(shared: PDFData, product: Producto) {
    let product = ProductViewModel(product: product)
    print("\(product.familia) se dibuja abajo en la página" )
}


class PDFData {
    var project: ProjectViewModel
    var margin: Double = 50
    var padding: Double = 30
    var half_padding: Double
    var text_attributes: [NSAttributedString.Key: NSObject]
    
    init(project: ProjectViewModel){
        self.project = project
        self.half_padding = padding/2
        
        let textFont = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        self.text_attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
    }
}

func getDocumentsDirectory() -> NSString {
    /// Get the current directory
    ///
    /// - Returns: the Current directory in NSURL
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory as NSString
}

extension Data {

    /// Data into file
    ///
    /// - Parameters:
    ///   - fileName: the Name of the file you want to write
    /// - Returns: Returns the URL where the new file is located in NSURL
    func dataToFile(fileName: String) -> NSURL? {

        // Make a constant from the data
        let data = self

        // Make the file path (with the filename) where the file will be loacated after it is created
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            // Write the file from data into the filepath (if there will be an error, the code jumps to the catch block below)
            try data.write(to: URL(fileURLWithPath: filePath))

            // Returns the URL where the new file is located in NSURL
            return NSURL(fileURLWithPath: filePath)

        } catch {
            // Prints the localized description of the error from the do block
            print("Error writing the file: \(error.localizedDescription)")
        }

        // Returns nil if there was an error in the do-catch -block
        return nil

    }

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
