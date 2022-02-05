//
//  Header.swift
//  Feivan
//
//  Created by javigo on 16/12/21.
//

import SwiftUI

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
    
    var direccion = ""
    if !shared.project.piso_puerta.isEmpty && !shared.project.direccion.isEmpty {
        direccion = "\(shared.project.piso_puerta), \(shared.project.direccion)"
    } else if shared.project.piso_puerta.isEmpty && !shared.project.direccion.isEmpty {
        direccion = shared.project.direccion
    }
    
    addDireccion(shared: shared, page: page_header_data, text: direccion)
    
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
    
    //Atributte
    let attributedTitleText = NSAttributedString(
                            string: "Cliente: ",
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: shared.font_size, weight: .bold)
                            ]
                        )
    
    let paragraphSize = CGSize(width: page.width, height: page.height)
    let paragraphRect = attributedTitleText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    
    let textTitleRect = CGRect(
                        x: page.origin.x,
                        y: page.origin.y,
                        width: paragraphRect.width,
                        height: paragraphRect.height
                    )
    
    attributedTitleText.draw(in: textTitleRect)

    // Value
    let width = page.width / 2
    let height = page.height
    let textFont = getTextFont(string: text, font: shared.font_size, width: width, height: height)

    let attributedText = NSAttributedString(
                            string: text,
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFont, weight: .regular)
                            ]
                        )
    
    let textRect = CGRect(
                        x: textTitleRect.minX + textTitleRect.width ,
                        y: page.origin.y,
                        width: width,
                        height: page.height
                    )
    
    attributedText.draw(in: textRect)

}

func addTelefono(shared: PDFData, page: CGRect, text: String) {
    /*
    let string_data = "Teléfono: \(text)"
    let attributedText = NSAttributedString(string: string_data, attributes: shared.text_attributes)
    let textRect = CGRect(x: page.origin.x + (page.width / 2) * 1.3,
                          y: page.origin.y,
                          width:  page.width - ((page.width / 2) * 1.3),
                          height: page.height
                    )
    attributedText.draw(in: textRect)
    */
    
    //Atributte
    let attributedTitleText = NSAttributedString(
                            string: "Teléfono: ",
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: shared.font_size, weight: .bold)
                            ]
                        )
    
    let paragraphSize = CGSize(width: page.width, height: page.height)
    let paragraphRect = attributedTitleText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    
    let textTitleRect = CGRect(
                        x: page.origin.x + (page.width / 2) * 1.3,
                        y: page.origin.y,
                        width: paragraphRect.width,
                        height: paragraphRect.height
                    )
    
    attributedTitleText.draw(in: textTitleRect)

    // Value
    let width = page.width - ((page.width / 2) * 1.3) - paragraphRect.width
    let height = page.height
    let textFont = getTextFont(string: text, font: shared.font_size, width: width, height: height)

    let attributedText = NSAttributedString(
                            string: text,
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFont, weight: .regular)
                            ]
                        )
    
    let textRect = CGRect(
                        x: textTitleRect.minX + textTitleRect.width ,
                        y: page.origin.y,
                        width: width,
                        height: page.height
                    )
    
    attributedText.draw(in: textRect)
}

func addDireccion(shared: PDFData, page: CGRect, text: String) {
    /*
    let attributedText = NSAttributedString(string: "Dirección: \(text)", attributes: shared.text_attributes)
    let textRect =  CGRect(
                        x: page.origin.x,
                        y: page.origin.y + 15,
                        width: page.width / 2,
                        height: page.height
                    )

    attributedText.draw(in: textRect)
     */
    let attributedTitleText = NSAttributedString(
                            string: "Dirección: ",
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: shared.font_size, weight: .bold)
                            ]
                        )
    
    let paragraphSize = CGSize(width: page.width, height: page.height)
    let paragraphRect = attributedTitleText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    
    let textTitleRect = CGRect(
                        x: page.origin.x,
                        y: page.origin.y + 15,
                        width: paragraphRect.width,
                        height: paragraphRect.height
                    )
    
    attributedTitleText.draw(in: textTitleRect)

    // Value
    let width = page.width / 2
    let height = page.origin.y + 15
    let textFont = getTextFont(string: text, font: shared.font_size, width: width, height: height)

    let attributedText = NSAttributedString(
                            string: text,
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFont, weight: .regular)
                            ]
                        )
    
    let textRect = CGRect(
                        x: textTitleRect.minX + textTitleRect.width ,
                        y: height,
                        width: width,
                        height: page.height
                    )
    
    attributedText.draw(in: textRect)
}

func addFecha(shared: PDFData, page: CGRect, text: String) {
    /*
    let attributedText = NSAttributedString(string: "Fecha: \(text)", attributes: shared.text_attributes)
    let textRect =  CGRect(
                        x: page.origin.x + (page.width / 2) * 1.3,
                        y: page.origin.y + 15,
                        width: page.width - ((page.width / 2) * 1.3),
                        height: page.height
                    )

    attributedText.draw(in: textRect)
     */
    
    //Atributte
    let attributedTitleText = NSAttributedString(
                            string: "Fecha: ",
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: shared.font_size, weight: .bold)
                            ]
                        )
    
    let paragraphSize = CGSize(width: page.width, height: page.height)
    let paragraphRect = attributedTitleText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    
    let textTitleRect = CGRect(
                        x: page.origin.x + (page.width / 2) * 1.3,
                        y: page.origin.y + 15,
                        width: paragraphRect.width,
                        height: paragraphRect.height
                    )
    
    attributedTitleText.draw(in: textTitleRect)

    // Value
    let width = page.width - ((page.width / 2) * 1.3) - paragraphRect.width
    let height = page.origin.y + 15
    let textFont = getTextFont(string: text, font: shared.font_size, width: width, height: height)

    let attributedText = NSAttributedString(
                            string: text,
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFont, weight: .regular)
                            ]
                        )
    
    let textRect = CGRect(
                        x: textTitleRect.minX + textTitleRect.width ,
                        y: height,
                        width: width,
                        height: page.height
                    )
    
    attributedText.draw(in: textRect)
}

func addEmail(shared: PDFData, page: CGRect, text: String) {
    /*
    let attributedText = NSAttributedString(string: "Email: \(text)", attributes: shared.text_attributes)
    let textRect =  CGRect(
                        x:  page.origin.x,
                        y:  page.origin.y + 30,
                        width: page.width / 2,
                        height: page.height
                    )

    attributedText.draw(in: textRect)
     */
    let attributedTitleText = NSAttributedString(
                            string: "Email: ",
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: shared.font_size, weight: .bold)
                            ]
                        )
    
    let paragraphSize = CGSize(width: page.width, height: page.height)
    let paragraphRect = attributedTitleText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    
    let textTitleRect = CGRect(
                        x: page.origin.x,
                        y: page.origin.y + 30,
                        width: paragraphRect.width,
                        height: paragraphRect.height
                    )
    
    attributedTitleText.draw(in: textTitleRect)

    // Value
    let width = page.width / 2
    let height = page.origin.y + 30
    let textFont = getTextFont(string: text, font: shared.font_size, width: width, height: height)

    let attributedText = NSAttributedString(
                            string: text,
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFont, weight: .regular)
                            ]
                        )
    
    let textRect = CGRect(
                        x: textTitleRect.minX + textTitleRect.width ,
                        y: height,
                        width: width,
                        height: page.height
                    )
    
    attributedText.draw(in: textRect)
}

func addReferencia(shared: PDFData, page: CGRect, text: String) {
    /*
    let attributedText = NSAttributedString(string: "Referencia: \(text)", attributes: shared.text_attributes)
    let textRect =  CGRect(
                        x: page.origin.x + (page.width / 2) * 1.3,
                        y: page.origin.y + 30,
                        width: page.width - ((page.width / 2) * 1.3),
                        height: page.height
                    )

    attributedText.draw(in: textRect)
     */
    //Atributte
    let attributedTitleText = NSAttributedString(
                            string: "Referencia: ",
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: shared.font_size, weight: .bold)
                            ]
                        )
    
    let paragraphSize = CGSize(width: page.width, height: page.height)
    let paragraphRect = attributedTitleText.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    
    let textTitleRect = CGRect(
                        x: page.origin.x + (page.width / 2) * 1.3,
                        y: page.origin.y + 30,
                        width: paragraphRect.width,
                        height: paragraphRect.height
                    )
    
    attributedTitleText.draw(in: textTitleRect)

    // Value
    let width = page.width - ((page.width / 2) * 1.3) - paragraphRect.width
    let height = page.origin.y + 30
    let textFont = getTextFont(string: text, font: shared.font_size, width: width, height: height)

    let attributedText = NSAttributedString(
                            string: text,
                            attributes: [
                                NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFont, weight: .regular)
                            ]
                        )
    
    let textRect = CGRect(
                        x: textTitleRect.minX + textTitleRect.width ,
                        y: height,
                        width: width,
                        height: page.height
                    )
    
    attributedText.draw(in: textRect)
}
 
