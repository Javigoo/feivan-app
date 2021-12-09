//
//  PDF.swift
//  Feivan
//
//  Created by javigo on 2/12/21.
//

import PDFKit
import SwiftUI

// Present PDF
struct PdfView: View {
    @ObservedObject var projectVM: ProjectViewModel
    
    var body: some View {
        VStack {
            PdfPreview()
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

        // the Data you want to share as a file
        let data = createPDF()

        // Write the data into a filepath and return the filepath in NSURL
        // Change the file-extension to specify the filetype (.txt, .json, .pdf, .png, .jpg, .tiff...)
        let fileURL = data.dataToFile(fileName: "feivan.pdf")

        // Create the Array which includes the files you want to share
        var filesToShare = [Any]()

        // Add the path of the file to the Array
        filesToShare.append(fileURL!)

        // Make the activityViewContoller which shows the share-view
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

        // Show the share-view
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}

// Create PDF
struct PdfPreview: UIViewRepresentable {
    typealias UIViewType = PDFView

    let data: Data = createPDF()

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

func createPDF() -> Data {
    
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
    
    let data = renderer.pdfData { (context) in
        context.beginPage() // Crea una nueva página
        // 6
        let attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 72)
        ]
        let text = "Oleeeee"
        text.draw(at: CGPoint(x: 20, y: 20), withAttributes: attributes)
    }
    
    return data
}

// Utils
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
