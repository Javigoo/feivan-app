//
//  Data.swift
//  Feivan
//
//  Created by javigo on 16/12/21.
//

import SwiftUI

//let available_size = CGSize(width: page.width, height: page.height)
//let used_space = attributes_text.boundingRect(with: available_size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
let black: UIImage = UIImage(named: "black")!
let green: UIImage = UIImage(named: "green")!
let purple: UIImage = UIImage(named: "purple")!

func addBottomProduct(shared: PDFData, page: CGRect, context: CGContext, product: Producto) {
    let product = ProductViewModel(product: product)
    
    let page_image = CGRect(
        x: page.origin.x,
        y: page.origin.y + (page.height / 2) + shared.half_padding,
        width: (page.width / 3) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )

    let page_foto = CGRect(
        x: page_image.origin.x + page_image.width + shared.half_padding,
        y: page.origin.y + (page.height / 2) + shared.half_padding,
        width: (page.width / 3) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )
    
    let page_data = CGRect(
        x: page_foto.origin.x + page_foto.width + shared.half_padding,
        y: page.origin.y + (page.height / 2) + shared.half_padding,
        width: (page.width / 3),
        height: (page.height / 2) - shared.half_padding
    )
    
//    black.draw(in: page_image)
//    green.draw(in: page_foto)
//    purple.draw(in: page_data)
    
    addProductImage(shared: shared, page: page_image, product: product)
    addProductPhoto(shared: shared, page: page_foto, product: product)
    addProductData(shared: shared, page: page_data, context: context, product: product)
    
}

func addTopProduct(shared: PDFData, page: CGRect, context: CGContext, product: Producto) {
    let product = ProductViewModel(product: product)
    
    let page_image = CGRect(
        x: page.origin.x,
        y: page.origin.y,
        width: (page.width / 3) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )

    let page_foto = CGRect(
        x: page_image.origin.x + page_image.width + shared.half_padding,
        y: page.origin.y,
        width: (page.width / 3) - shared.half_padding,
        height: (page.height / 2) - shared.half_padding
    )
    
    let page_data = CGRect(
        x: page_foto.origin.x + page_foto.width + shared.half_padding,
        y: page.origin.y,
        width: (page.width / 3),
        height: (page.height / 2) - shared.half_padding
    )
    
//    black.draw(in: page_image)
//    green.draw(in: page_foto)
//    purple.draw(in: page_data)
    
    addProductImage(shared: shared, page: page_image, product: product)
    addProductPhoto(shared: shared, page: page_foto, product: product)
    addProductData(shared: shared, page: page_data, context: context, product: product)
    
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
    
//    black.draw(in: page_image)
//    green.draw(in: page_foto)
//    purple.draw(in: page_data)
    
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
    
    let atributos = ["Unidades", "Curvas", "Material", "Color", "Tapajuntas", "Dimensiones", "Apertura", "Compacto", "Marco inferior", "Huella", "Forro exterior", "Cristal", "Cerraduras", "Manetas", "Herraje", "Posición", "Instalación", "Remates albañilería", "Medidas no buenas", "Persiana"]
    var resultado_atributos: String = ""
    for atributo_to_print in atributos {
        let lineas_atributo = product.get(attribute: atributo_to_print).split(separator: "\n").count
        if lineas_atributo != 0 {
            resultado_atributos += "\(atributo_to_print)" + String(repeating: "\n", count: lineas_atributo+1)
        }
    }
    
    var resultado_valores = ""
    for atributo_to_print in atributos {
        let lineas = product.get(attribute: atributo_to_print).split(separator: "\n")
        let lineas_atributo = lineas.count
        if lineas_atributo != 0 {
            for value in lineas{
                resultado_valores += "\(value)\n"
            }
            resultado_valores += "\n"
        }
    }
    
    let attributes_page = CGRect(x: page.origin.x,
                             y: page.origin.y,
                             width: page.width * 0.4,
                             height: page.height
                        )
    let values_page = CGRect(x: page.origin.x + attributes_page.width,
                             y: page.origin.y,
                             width: page.width - attributes_page.width,
                             height: page.height
                        )
    
    let attributes_font_size = getTextFont(string: resultado_atributos, font: shared.font_size, width: attributes_page.width, height: attributes_page.height)
    let values_font_size = getTextFont(string: resultado_valores, font: shared.font_size, width: values_page.width, height: values_page.height)
    let fontSize = min(attributes_font_size, values_font_size)
    
    //let attributes_max_lenght = get_max_lenght(text: resultado_atributos)
    
    var textFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    let text_attributes = [
        NSAttributedString.Key.paragraphStyle: shared.paragraph_style,
        NSAttributedString.Key.font: textFont
        ]
    
    textFont = UIFont.systemFont(ofSize: fontSize, weight: .regular)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .right
    paragraphStyle.lineBreakMode = .byWordWrapping
    let text_values = [
        NSAttributedString.Key.paragraphStyle: paragraphStyle,
        NSAttributedString.Key.font: textFont
    ]
    
    
    let attributes_text = NSAttributedString(string: resultado_atributos, attributes: text_attributes)
    attributes_text.draw(in: attributes_page)

    //let paragraphSize = CGSize(width: page.width, height: page.height)
    //let paragraphRect = attributes_text.boundingRect(with: paragraphSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    //print("max width: ", page.width)
    //print("needed width: ", paragraphRect.width)
        
    let values_text = NSAttributedString(string: resultado_valores, attributes: text_values)
    values_text.draw(in: values_page)

}

func get_max_lenght(text: String) -> Int {
    let lines = text.split(separator: "\n")
    var max_lenght = 0
    for line in lines {
        if line.count > max_lenght {
            print("new max lenght line: ", line, line.count)
            max_lenght = line.count
        }
    }
    return max_lenght
}

func addProductTopPage(shared: PDFData, product: Producto) {
    let product = ProductViewModel(product: product)
    print("\(product.familia) se dibuja arriba en la página" )
}

func addProductBottomPage(shared: PDFData, product: Producto) {
    let product = ProductViewModel(product: product)
    print("\(product.familia) se dibuja abajo en la página" )
}
