//
//  Data.swift
//  Feivan
//
//  Created by javigo on 16/12/21.
//

import SwiftUI

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
    
    let scaled_page = CGRect(x: page.origin.x,
                             y: page.origin.y,
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
    
    let scaled_page = CGRect(x: page.origin.x,
                             y: page.origin.y,
                             width: scaledWidth,
                             height: scaledHeight
                        )

    image.draw(in: scaled_page)
    
}

func addProductData(shared: PDFData, page: CGRect, context: CGContext, product: ProductViewModel) {
    /*
     // Value
     let textFont = getTextFont(string: text, font: shared.font_size, width: width, height: height)

     let attributedText = NSAttributedString(
                             string: text,
                             attributes: [
                                 NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
                                 NSAttributedString.Key.font: textFont
                             ]
                         )
     
     let textRect = CGRect(
                         x: textTitleRect.minX + textTitleRect.width ,
                         y: height,
                         width: width,
                         height: page.height
                     )
     
     attributedText.draw(in: textRect)
     */
    // Titulo
    let atributos = ["Curvas", "Material", "Color", "Tapajuntas", "Dimensiones", "Apertura", "Compacto", "Marco inferior", "Huella", "Forro exterior", "Cristal", "Cerraduras", "Manetas", "Herraje", "Posición", "Instalación", "Remates albañilería", "Medidas no buenas", "Persiana"]
    
    var resultado_atributos: String = ""
    for atributo_to_print in atributos {
        let lineas_atributo = product.get(attribute: atributo_to_print).split(separator: "\n").count
        if lineas_atributo != 0 {
            resultado_atributos += "\(atributo_to_print)" + String(repeating: "\n", count: lineas_atributo+1)
        }
    }
    
    let fontSize = getTextFont(string: resultado_atributos, font: shared.font_size, width: page.width, height: page.height)

    var textFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    var text_attributes = [
        NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
        NSAttributedString.Key.font: textFont
        ]
    
    var attributedText = NSAttributedString(string: resultado_atributos, attributes: text_attributes)
    attributedText.draw(in: page)
    
    // Datos
    textFont = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    let paragraphStyle = NSMutableParagraphStyle()
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

func addProductTopPage(shared: PDFData, product: Producto) {
    let product = ProductViewModel(product: product)
    print("\(product.familia) se dibuja arriba en la página" )
}

func addProductBottomPage(shared: PDFData, product: Producto) {
    let product = ProductViewModel(product: product)
    print("\(product.familia) se dibuja abajo en la página" )
}
