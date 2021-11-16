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
    @Published var remates_albanileria: Bool = false
    @Published var medidas_no_buenas: Bool = false
    @Published var persiana: String = ""
    @Published var copias: Int16 = 1
    @Published var timestamp: Date = Date()
    
    @Published var proyecto: Proyecto?
    
    @Published var productos: [Producto] = []
            
    // Refact
    @Published var otro = ""
    @Published var especifico = ""
    @Published var anotacion = ""
    
    // Constructores

    init() {
        print("ProductViewModel - init()")
    }
    
    init(product: Producto) {
        print("ProductViewModel - init(product)")
        setProductVM(product: product)
    }
    
    
    // Funciones públicas

    func setProductVMAddMore(productVM: ProductViewModel) {
        print("Copiando valores del producto original")
        if familia == "" { familia = productVM.familia }
        if nombre == "" { nombre = productVM.nombre }
        if tapajuntas == "" { tapajuntas = productVM.tapajuntas }
        if color == "" { color = productVM.color }
        if cristal == "" { cristal = productVM.cristal }
        if instalacion == "" { instalacion = productVM.instalacion }
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
            print("Productos: \(productos.count)")
        } catch {
            print("ERROR in ProductViewModel at getAllProducts()\n")
        }
    }
    
    // Funciones privadas
    
    private func setProductVM(product: Producto) {
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
        remates_albanileria = product.remates_albanileria
        medidas_no_buenas = product.medidas_no_buenas
        persiana = product.persiana ?? persiana
        copias = product.copias
        timestamp = product.timestamp ?? timestamp
        proyecto = product.proyecto ?? proyecto
    }
    
    private func setProduct(product: Producto) {
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
        product.remates_albanileria = remates_albanileria
        product.medidas_no_buenas = medidas_no_buenas
        product.persiana = persiana
        product.copias = copias
        product.timestamp = timestamp
        product.proyecto = proyecto
    }
    
    private func getProduct(id: UUID) -> Producto? {
        let request: NSFetchRequest<Producto> = Producto.fetchRequest()
        let query = NSPredicate(format: "%K == %@", "id_producto", id as CVarArg)
        // todo: limitar a una entidad
        request.predicate = query
        do {
            let foundEntities: [Producto] = try context.viewContext.fetch(request)
            return foundEntities.first
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
    func showIf(familias: [String]) -> Bool {
        let familiaSeleccionada = getFamilia()
        for familia in familias {
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
            return currentDimensiones[0].components(separatedBy: " ")[1] + " mm"
        }
        
        return dimensiones
    }
    
    func optionsFor(attribute: String) -> [String] {
        for elemento in hierarchy().elementos {
            if attribute == elemento.nombre {
                return elemento.opciones
            }
        }
        return []
    }
    
    func getSingularFamilia(name: String) -> String {
        if name != "" {
            var nombre = getFamilia()
            nombre.removeLast()
            return nombre
        }
        return name
    }
}

