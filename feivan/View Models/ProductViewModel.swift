//
//  ProductViewModel.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import CoreData
import SwiftUI

class ProductViewModel: ObservableObject {
    private let context = PersistenceController.shared

    @Published var id_producto: UUID = UUID()
    @Published var foto: Data = Data()
    @Published var familia: String = ""
    @Published var nombre: String = ""
    @Published var curvas: String = ""
    @Published var material: String = ""
    @Published var color: String = ""
    @Published var tapajuntas: String = ""
    @Published var dimensiones: String = ""
    @Published var apertura: String = ""
    @Published var compacto: String = ""
    @Published var marco_inferior: String = ""
    @Published var huella: String = ""
    @Published var forro_exterior: String = ""
    @Published var cristal: String = ""
    @Published var cerraduras: String = ""
    @Published var manetas: String = ""
    @Published var herraje: String = ""
    @Published var posicion: String = ""
    @Published var instalacion: String = ""
    @Published var persiana: String = ""
    @Published var unidades: Int16 = 1
    @Published var timestamp: Date = Date()
    
    @Published var proyecto: Proyecto?

    @Published var productos: [Producto] = []
            
    // Refact
    @Published var otro = ""
    @Published var especifico = ""
    @Published var anotacion = ""
    
    // Constructores

    init() {
    }
    
    init(product: Producto) {
        setProductVM(product: product)
    }
    
    // Getters y Setters
    
    /*
    func get(attribute: String, product: Producto) -> String {
        switch attribute {
            case "Familia":
                return product.familia ?? familia
            case "Nombre":
                return product.nombre ?? nombre
            case "Curvas":
                return product.curvas ?? curvas
            case "Material":
                return product.material ?? material
            case "Color":
                return product.color ?? color
            case "Tapajuntas":
                return product.tapajuntas ?? tapajuntas
            case "Dimensiones":
                return product.dimensiones ?? dimensiones
            case "Apertura":
                return product.apertura ?? apertura
            case "Compacto":
                return product.compacto ?? compacto
            case "Marco inferior":
                return product.marco_inferior ?? marco_inferior
            case "Huella":
                return product.huella ?? huella
            case "Forro exterior":
                return product.forro_exterior ?? forro_exterior
            case "Cristal":
                return product.cristal ?? cristal
            case "Cerraduras":
                return product.cerraduras ?? cerraduras
            case "Manetas":
                return product.manetas ?? manetas
            case "Herraje":
                return product.herraje ?? herraje
            case "Posición":
                return product.posicion ?? posicion
            case "Instalación":
                return product.instalacion ?? instalacion
            case "Remates albañilería":
                return String(product.remates_albanileria)
            case "Medidas no buenas":
                return String(product.medidas_no_buenas)
            case "Persiana":
                return product.persiana ?? persiana
            default:
                print("Error getting \(attribute), \"\(attribute)\" not found")
        }
        return ""
    }
    
    func set(attribute: String, product: Producto) {
        switch attribute {
            case "Familia":
                product.familia = familia
            case "Nombre":
                product.nombre = nombre
            case "Curvas":
                product.curvas = curvas
            case "Material":
                product.material = material
            case "Color":
                product.color = color
            case "Tapajuntas":
                product.tapajuntas = tapajuntas
            case "Dimensiones":
                product.dimensiones = dimensiones
            case "Apertura":
                product.apertura = apertura
            case "Compacto":
                product.compacto = compacto
            case "Marco inferior":
                product.marco_inferior = marco_inferior
            case "Huella":
                product.huella = huella
            case "Forro exterior":
                product.forro_exterior = forro_exterior
            case "Cristal":
                product.cristal = cristal
            case "Cerraduras":
                product.cerraduras = cerraduras
            case "Manetas":
                product.manetas = manetas
            case "Herraje":
                product.herraje = herraje
            case "Posición":
                product.posicion = posicion
            case "Instalación":
                product.instalacion = instalacion
            case "Remates albañilería":
                product.remates_albanileria = remates_albanileria
            case "Medidas no buenas":
                product.medidas_no_buenas = medidas_no_buenas
            case "Persiana":
                product.persiana = persiana
            default:
                print("Error setting \(attribute), \"\(attribute)\" not found")
        }
    }
        
    func get(attribute: String) -> String {
        switch attribute {
            case "Familia":
                return familia
            case "Nombre":
                return nombre
            case "Curvas":
                return curvas
            case "Material":
                return material
            case "Color":
                return color
            case "Tapajuntas":
                return tapajuntas
            case "Dimensiones":
                return dimensiones
            case "Apertura":
                return apertura
            case "Compacto":
                return compacto
            case "Marco inferior":
                return marco_inferior
            case "Huella":
                return huella
            case "Forro exterior":
                return forro_exterior
            case "Cristal":
                return cristal
            case "Cerraduras":
                return cerraduras
            case "Manetas":
                return manetas
            case "Herraje":
                return herraje
            case "Posición":
                return posicion
            case "Instalación":
                return instalacion
            case "Remates albañilería":
                return String(remates_albanileria)
            case "Medidas no buenas":
                return String(medidas_no_buenas)
            case "Persiana":
                return persiana
            default:
                print("Error getting \(attribute), \"\(attribute)\" not found")
        }
        return ""
    }
    
    func set(attribute: String, value: String) {
        switch attribute {
            case "Foto":
                familia = value
            case "Familia":
                familia = value
            case "Nombre":
                nombre = value
            case "Curvas":
                curvas = value
            case "Material":
                material = value
            case "Color":
                color = value
            case "Tapajuntas":
                tapajuntas = value
            case "Dimensiones":
                dimensiones = value
            case "Apertura":
                apertura = value
            case "Compacto":
                compacto = value
            case "Marco inferior":
                marco_inferior = value
            case "Huella":
                huella = value
            case "Forro exterior":
                forro_exterior = value
            case "Cristal":
                cristal = value
            case "Cerraduras":
                cerraduras = value
            case "Manetas":
                manetas = value
            case "Herraje":
                herraje = value
            case "Posición":
                posicion = value
            case "Instalación":
                instalacion = value
            case "Remates albañilería":
                remates_albanileria = Bool(value) ?? remates_albanileria
            case "Medidas no buenas":
                medidas_no_buenas = Bool(value) ?? medidas_no_buenas
            case "Persiana":
                persiana = value
            default:
                print("Error setting \(attribute), \"\(attribute)\" not found")
        }
    }
    */
    
    private func setProductVM(product: Producto) {
        /*
        for attribute in optionsFor(attribute: "Atributos Producto") {
            set(attribute: attribute, value: get(attribute: attribute, product: product))
        }
        
        id_producto = product.id_producto ?? id_producto
        foto = product.foto ?? foto
        timestamp = product.timestamp ?? timestamp
        proyecto = product.proyecto ?? proyecto
        */
        
        id_producto = product.id_producto ?? id_producto
        foto = product.foto ?? foto
        familia = product.familia ?? familia
        nombre = product.nombre ?? nombre
        curvas = product.curvas ?? curvas
        material = product.material ?? material
        color = product.color ?? color
        tapajuntas = product.tapajuntas ?? tapajuntas
        dimensiones = product.dimensiones ?? dimensiones
        apertura = product.apertura ?? apertura
        compacto = product.compacto ?? compacto
        marco_inferior = product.marco_inferior ?? marco_inferior
        huella = product.huella ?? huella
        forro_exterior = product.forro_exterior ?? forro_exterior
        cristal = product.cristal ?? cristal
        cerraduras = product.cerraduras ?? cerraduras
        manetas = product.manetas ?? manetas
        herraje = product.herraje ?? herraje
        posicion = product.posicion ?? posicion
        instalacion = product.instalacion ?? instalacion
        persiana = product.persiana ?? persiana
        unidades = product.unidades
        timestamp = product.timestamp ?? timestamp
        proyecto = product.proyecto ?? proyecto
         
    }
    
    private func setProduct(product: Producto) {
        /*
        for attribute in optionsFor(attribute: "Atributos Producto") {
            set(attribute: attribute, product: product)
        }
        
        product.id_producto = id_producto
        product.foto = foto
        product.timestamp = timestamp
        product.proyecto = proyecto
        */
        
        product.id_producto = id_producto
        product.foto = foto
        product.familia = familia
        product.nombre = nombre
        product.curvas = curvas
        product.material = material
        product.color = color
        product.tapajuntas = tapajuntas
        product.dimensiones = dimensiones
        product.apertura = apertura
        product.compacto = compacto
        product.marco_inferior = marco_inferior
        product.huella = huella
        product.forro_exterior = forro_exterior
        product.cristal = cristal
        product.cerraduras = cerraduras
        product.manetas = manetas
        product.herraje = herraje
        product.posicion = posicion
        product.instalacion = instalacion
        product.persiana = persiana
        product.unidades = unidades
        product.timestamp = timestamp
        product.proyecto = proyecto
        
    }

    
    // Funciones públicas
    
    func setProductVMAddMore(productVM: ProductViewModel) {
        familia = productVM.familia
        nombre = productVM.nombre
        curvas = productVM.curvas
        material = productVM.material
        color = productVM.color
        tapajuntas = productVM.tapajuntas
        dimensiones = productVM.dimensiones
        apertura = productVM.apertura
        compacto = productVM.compacto
        marco_inferior = productVM.marco_inferior
        huella = productVM.huella
        forro_exterior = productVM.forro_exterior
        cristal = productVM.cristal
        cerraduras = productVM.cerraduras
        manetas = productVM.manetas
        herraje = productVM.herraje
        posicion = productVM.posicion
        instalacion = productVM.instalacion
        persiana = productVM.persiana
        proyecto = productVM.proyecto
    }
    
    func addProject(projectVM: ProjectViewModel) {
        proyecto = projectVM.getProject()
    }
    
    func save() {
        let product: Producto
        if exist() {
            product = getProduct()!
        } else {
            product = Producto(context: context.viewContext)
        }
        setProduct(product: product)
        context.save()
        getAllProducts()
    }
    
    func delete(at offset: IndexSet, for productos: [Producto]) {
        if let first = productos.first, case context.viewContext = first.managedObjectContext {
            offset.map { productos[$0] }.forEach(context.viewContext.delete)
        }
        
        context.save()
        getAllProducts()
        
    }
    
    func exist() -> Bool {
        if getProduct() == nil {
            return false
        }
        return true
    }
    
    func getProduct() -> Producto? {
        return getProduct(id: id_producto)
    }
    
    func getAllProducts() {
        let request = Producto.fetchRequest()
        do {
            productos = try context.viewContext.fetch(request)
        } catch {
            print("ERROR in ProductViewModel at getAllProducts()\n")
        }
    }
    
    // Funciones privadas
    
    
    
    private func getProduct(id: UUID) -> Producto? {
        let request: NSFetchRequest<Producto> = Producto.fetchRequest()
        let query = NSPredicate(format: "%K == %@", "id_producto", id as CVarArg)
        let sort = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        request.predicate = query
        request.sortDescriptors = sort
        
        do {
            let foundEntities: [Producto] = try context.viewContext.fetch(request)
            return foundEntities.first  // todo: limitar a una entidad
        } catch {
            let fetchError = error as NSError
            debugPrint(fetchError)
        }

        return nil
    }
    
    // Otras
    
    /** Devuelve falso si la familia del producto es igual a alguna de las familias pasadas como parámetro, verdadero de lo contrario **/
    func notShowIf(familias: [String]) -> Bool {
        let familiaSeleccionada = getFamilia()
        for familia in familias {
            if familiaSeleccionada == familia {
                return false
            }
        }
        return true
    }
    
    /** Devuelve verdadero si la familia del producto es igual a alguna de las familias pasadas como parámetro, falso de lo contrario **/
    func showIf(equalTo: [String]) -> Bool {
        let familiaSeleccionada = getFamilia()
        for familia in equalTo {
            if familiaSeleccionada == familia {
                return true
            }
        }
        return false
    }
    
    // Getters
    
    func getDimensiones(option: String?) -> String {
        if dimensiones != "" {
            if option == "ancho x alto" {
                return getDimensionesAnchoAlto()
            }
        }
        
        return dimensiones
    }
    
    func getMaterial(option: String?) -> String {
        if material != "" {
            if option == "tipo" {
                return getMaterialTipo()
            }
            if option == "opcion" {
                return getMaterialOpcion()
            }
        }
        
        return dimensiones
    }
    
    func getFamilia() -> String {
        return familia
    }

    // Formatters
    private func getDimensionesAnchoAlto() -> String {
        let currentDimensiones = dimensiones.components(separatedBy: "\n")
        if currentDimensiones.count >= 2 {
            let ancho = currentDimensiones[0].components(separatedBy: " ")[1]
            let alto = currentDimensiones[1].components(separatedBy: " ")[1]
            return ancho+" x "+alto+" mm"
        } else if currentDimensiones.count == 1 {
            return currentDimensiones[0].components(separatedBy: " ")[1]
        }
        
        return dimensiones
    }
    
    private func getMaterialTipo() -> String {
        let currentMaterial = material.components(separatedBy: "\n")
        if currentMaterial.count >= 2 {
            let tipo = currentMaterial[1].components(separatedBy: ":")[1]
            return tipo
        } else if currentMaterial.count == 1 {
            return currentMaterial[0]
        }
        
        return material
    }
    
    private func getMaterialOpcion() -> String {
        let currentMaterial = material.components(separatedBy: "\n")
        return currentMaterial[0]
        
    }
    
    func optionsFor(attribute: String) -> [String] {
        for elemento in hierarchy().elementos {
            if attribute == elemento.nombre {
                return elemento.opciones
            }
        }
        return []
    }
    
    func getRalCodes() -> [String] {
        var ral_codes: [String] = []
        for elemento in ral().elementos {
            ral_codes.append(elemento.code)
        }
        return ral_codes
    }
    
    func getRalColor(code: String, color: String) -> Double {
        for elemento in ral().elementos {
            if code == elemento.code{
                if color == "r"{
                    return Double(elemento.color.rgb.r)
                }
                if color == "g"{
                    return Double(elemento.color.rgb.g)
                }
                if color == "b"{
                    return Double(elemento.color.rgb.b)
                }
            }
        }
        return 0.0
    }
    
    
    
    func getSingularFamilia(name: String) -> String {
        if name != "" {
            var nombre = getFamilia()
            nombre.removeLast()
            return nombre
        }
        return name
    }
    
    func getAttributeValue(attribute_data: String, select_atributte: String) -> String {
        let attribute_data: [String] = attribute_data.components(separatedBy: "\n")
        for data in attribute_data {
            if data.contains(":") {
                let split_data: [String] = data.components(separatedBy: ":")
                let attribute: String = split_data[0]
                let value: String = split_data[1]
                
                if attribute == select_atributte {
                    return value.trimmingCharacters(in: .whitespaces)
                }
                
            }
            if data.contains("\""){
                if select_atributte == "Otro" {
                    return data.replacingOccurrences(of: "\"", with: "")
                }
                return ""
            }
            if data.contains("(") && data.contains(")") {
                if select_atributte == "Anotacion" {
                    let first = data.dropFirst()
                    let second = first.dropLast()
                    return String(second)
                }
                return ""
            }
            if select_atributte == "Valor" {
                return data
            }
        }
        return ""
    }
}

