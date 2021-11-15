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
    
    @Published var proyecto: Proyecto
    
    @Published var productos: [Producto] = []
            
    // Refact
    @Published var otro = ""
    @Published var especifico = ""
    @Published var anotacion = ""
    
    // Constructores

    init() {
        print("New ProductViewModel")
        proyecto = Proyecto()
    }
    
    init(product: Producto) {
        proyecto = product.proyecto
        setProductVM(product: product)
    }
    
    
    // Funciones públicas

    func setAnotherProductVM(productVM: ProductViewModel) {
        print("Copiando valores del producto original")
        familia = productVM.familia
        tapajuntas = productVM.tapajuntas
        color = productVM.color
        cristal = productVM.cristal
        instalacion = productVM.instalacion
    }
    
    func addProject(projectVM: ProjectViewModel) {
        let product = getProduct()
        let project = projectVM.getProject()
        product?.proyecto = project
        context.save()
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
        return getFormattedName(name: familia)
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

        //return ["Falta \(option)"]

        // Autogenerado
        let directorios_Estructuras_ordenadas = ["1-CORREDERAS", "2-PRACTICABLES", "3-PUERTAS", "4-PERSIANA", "5-FIJOS", "6-PLEGABLE", "7-CURVAS", "8-PERSIANAS ENROLLABLES", "9-MOSQUITERA", "10-CANCELAS", "11-BARANDILLA"]
        let archivos_1_CORREDERAS = ["1-C2", "2-C3C", "3-C4", "4-C6"]
        let directorios_1_CORREDERAS = ["5-CORREDERA + FIJO", "6-COLADURIAS", "7-CORREDERA GALANDAS", "8-CORREDERAS ELEVADORAS", "9-CORREDERA FIJO+ZOCALO"]
        let archivos_5_CORREDERA_mas_FIJO = ["1-C2FI", "2-C2FS", "3-C2FSFI", "6-C3FI", "7-C3FS", "8-C3FSFI", "10-C4FI", "11-C4FS", "12-C4FSFI", "14-C6FI", "15-C6FS", "16-C6FSFI"]
        let archivos_6_COLADURIAS = ["1-PTA 1H FD", "2-PTA 1H FI"]
        let archivos_7_CORREDERA_GALANDAS = ["1-PCM1D", "2-PCM1DE", "3-PCM2"]
        let archivos_8_CORREDERAS_ELEVADORAS = ["1-PC2E1", "2-PC2E1I", "3-PC2E2", "4-PC3E1F2", "5-PC4E2F2"]
        let archivos_9_CORREDERA_FIJOmasZOCALO = ["1-C2PFS", "2-C3PFS", "3-C4PFS", "4-C6PFS"]
        let archivos_2_PRACTICABLES = ["1-1D", "1-1O", "1-1OD", "1-1", "2-2-DE", "2-2I", "2-2O", "2-2OI", "3-1+2", "3-1+", "4-1VS", "11-3O-DE", "11-3O", "12-4-DE", "12-4", "13-P4-DE", "13-P4", "14-1+1"]
        let directorios_2_PRACTICABLES = ["14-VENTANAS + FIJO", "15-VENTANA HOJAS DESIGUALES", "16-PIVOTANTE", "17-VENTANA + PIVE", "18-VENTANAS FALSO VIAS"]
        let archivos_14_VENTANAS_mas_FIJO = ["1-1FI-DE", "1-1FI", "1-1FL2FI-DE", "1-1FL2FIZ", "1-1FL-DE", "1-1FL", "1-1FS-DE", "1-1FS", "1-1FSFI-DE", "1-1FSFI", "1-1FSFIFL-DE", "1-1FSFIFL", "1-1O1FL-IZ", "1-1O1FL", "1-1O2FL-IZ", "1-1O2FL", "1-1OFD", "1-1OFI", "1-1OFL2FD", "1-1OFL2FI", "1-1OFSFD", "1-1OFSFI", "1-1OFSFIFL", "1-1OFSFIFLD", "1-1OP1FL", "1-1OP1FLI", "1-1OP2FL", "1-1OP2FLD", "1-1P2FL", "1-1P2FLI", "1", "2-1O+1F+1O", "2-1O+1F+1OI", "2-1O+2F+1O", "2-1O+2F+1OI", "2-2FDE", "2-2FIZ", "2-2FL", "2-2FLFDE", "2-2FLFI", "2-2FLI", "2-2FS", "2-2FSFIFL", "2-2FSFIFLDE", "2-2FSI", "2-2HF", "2-2O2FDE", "2-2O2FIZ", "2-2O2FS2FD", "2-2O2FS2FI", "2-2ODESC", "2-2ODESCI", "2-2OFD", "2-2OFI", "2-2OFL2FD", "2-2OFL2FI", "2-2OFLFD", "2-2OFLFI", "2-2OFLFSFD", "2-2OFLFSFI", "2-2OFSFIFL", "2-2OFSFIFLD", "8-1O+1OFI", "24-2O+1OFD", "24-2O+1OFI", "25-2O+1OFIFS", "25-2O+1OFIFSI", "26-2O+2O4FD", "26-2O+2O4FI", "27-2O+2OFD", "27-2O+2OFI"]
        let archivos_15_VENTANA_HOJAS_DESIGUALES = ["1-2D", "2-2DI", "3-2OD", "4-2OI"]
        let archivos_16_PIVOTANTE = ["1-PIVH", "2-PIVV"]
        let archivos_17_VENTANA_mas_PIVE = ["1-1+VS", "1-1+VSD", "2-1O+VS", "2-1O+VSDE"]
        let archivos_18_VENTANAS_FALSO_VIAS = ["1-1IND", "1-1INDE", "2-1IND", "2-1INI", "3-2I", "3-2IND", "3-2INI", "4-2IN", "5-2INID"]
        let archivos_3_PUERTAS = ["3-1P", "6-1PE", "6-2PE-CERRADURA-DE", "6-2PE-CERRADURA", "7-2OPD", "7-2OPI", "10-2PD", "10-2PDE", "11-1V3CUE-DE", "11-1V3CUERPOS"]
        let directorios_3_PUERTAS = ["PUERTA + FIJO", "PUERTA + PIVE", "PUERTA+BANDERA"]
        let archivos_PUERTA_mas_FIJO = ["1-12F", "1-12FL-DE", "1-12FL-IZ", "1-12FL", "2-2OP2FL-IZ", "2-2OP2FL", "2-2P2FL-IZ", "2-2P2FL", "3-2OPFS-IZ", "3-2OPFS", "3-2PFS-IZ", "3-2PFS", "4-2OPFSFL-IZ", "4-2OPFSFL", "6-2PCMA2FLFS-DE", "6-2PCMA2FLFS", "7-2PCMAFL-DE", "7-2PCMAFL-IZ", "13-PFIJOSUP.+LAT-DE", "13-PFIJOSUP.+LAT."]
        let archivos_PUERTA_mas_PIVE = ["1-2OP+VS-IZ", "1-2OP+VS", "2-2P+VS-IZ", "2-2P+VS"]
        let archivos_PUERTAmasBANDERA = ["4-1OP+1OBAN", "4-1OP+1OBANIZQUIERDA", "5-1P+1BAN", "BANDERA IZQUIERDA"]
        let archivos_4_PERSIANA = ["1-1MFAD", "2-1MFAI", "3-1MFATHD", "4-1MFATHI", "6-211MG", "8-2MFTHAD", "9-312M", "10-321M", "11-4M", "12-4MT", "13-6M", "14-MALL.2HTRAV."]
        let directorios_4_PERSIANA = ["FIJOS PERSIANA", "PERSIANA CON CRUCETA", "PERSIANA PLEGABLE", "PERSIANAS SOBRE MURO", "PÈRSIANAS CON ZOCALO"]
        let archivos_FIJOS_PERSIANA = ["1-0LM"]
        let archivos_PERSIANA_CON_CRUCETA = ["1-1MFATVI", "2-1MFATVD", "3-1MFATXI", "4-1MFATXD", "7-2MFTVAD", "8-2MFTVAI", "9-2MFTXAD", "10-2MFTXAI", "11-2PMFTVAD", "11-2PMFTVAI", "12-2PMFTXAD", "13-2PMFTXAI", "Inked8-2MFTVAI_LI"]
        let archivos_PERSIANA_PLEGABLE = ["1-PLMF303I", "1-PLMF303", "2-PLMF404", "3-PLMF404T", "4-PLMF505I", "4-PLMF505", "5-PLMF505T", "5-PLMF505TI", "6-PLMF606", "7-PLMF707IZ", "7-PLMF707"]
        let archivos_PERSIANAS_SOBRE_MURO = ["1-PCM1MDF", "2-PCM1MDFE", "3-PCM2MF"]
        let archivos_PÈRSIANAS_CON_ZOCALO = ["1-1MFAZD", "2-1MFAZI", "5-1MFAZTVD", "5-1PMFAZTXD", "6-1MFAZTVI", "6-1PMFAZTXI", "7-2MZ", "8-2PMTHZD", "10-2PMTVZD"]
        let archivos_5_FIJOS = ["1-0", "2-02H", "3-02V", "4-03H", "5-03V", "6-4", "7-6", "8-0IND", "9-0INI", "12-CF", "13-CFT"]
        let archivos_6_PLEGABLE = ["1-PL10010", "2-PL1055", "3-PL11011", "4-PL12012", "5-PL13013", "6-PL14014", "7-PL15015", "8-PL202", "9-PL303", "10-PL321", "11-PL330", "12-PL404", "13-PL505", "14-PL505T", "15-PL550", "16-PL606", "17-PL633", "18-PL651", "19-PL707", "20-PL808", "21-PL909"]
        let archivos_7_CURVAS = ["1-F+1+FC", "1-F+1+FCD", "1-F+1+FPC", "1-F+1+FPCD", "1-FS+1C", "1-FS+1CI", "3-1C", "3-1CI", "5-2C", "5-2CI", "6-C2015DE", "6-C2015", "9-F+2+FC", "9-F+2+FCI", "10-F+2+FPC", "10-F+2+FPCI", "12-OB+1VS", "13-OB"]
        let directorios_7_CURVAS = ["CURVAS CON ZOCALO"]
        let archivos_CURVAS_CON_ZOCALO = ["1-1CZ", "1-1CZD", "3-F+2+FCIZ", "3-F+2+FCZ", "4-F+2+FPCIZ", "4-F+2+FPCZ"]
        let archivos_8_PERSIANAS_ENROLLABLES = ["ENROLLABLE 1 PAÑO", "ENROLLABLE 2 PAÑO"]
        let archivos_9_MOSQUITERA = ["1-MOSQUITERA ENROLLABLE", "2-MOSQUITERA PLISADA 2 HOJAS CENTRAL 25", "3-MOSQUITERA PLISADA 25", "4-MOSQUITERA PLISADA REVERSIBLE 25", "5-MOSQUITERA PLISADA APERTURA CENTRAL", "6-MOSQUITERA CORREDERA", "7-MOSQUITERA ENROLLABLE LATERAL", "9-MOSQUITERA PUERTA DE PASO"]
        let archivos_10_CANCELAS = ["1 HOJA MACHIMBRADO HORIZONTAL", "1 HOJA TUBO 60X20+ZOCALO", "2 HOJAS BARROTE OK", "2 HOJAS BARROTE", "2 HOJAS MACHIMBRADO HORIZONTAL", "2 HOJAS MACHIMBRADO VERTICAL", "2 HOJAS TUBO 60X20 CURVA", "2 HOJAS TUBO 60X20 RECTO", "2 HOJAS TUBO 60X20", "CANCELA CORREDERA", "I HOJA TUBO 60X20+ZOCALO"]
        let archivos_11_BARANDILLA = ["1-BARANDILLA BARROTE CONVENCIONAL", "2-BARROTE convencional 2"]
        let directorios_11_BARANDILLA = ["Barana", "Q railing"]
        let archivos_Barana = ["SERIE BARANA BARROTE1", "SERIE BARANA BARROTE", "SERIE BARANA CRISTAL"]
        let archivos_Q_railing = ["Q RAILING EMPOTRADA", "Q RAILING SUJETCION FRONTAL", "Q RAILING"]
        
        switch attribute {
            // Autogenerado
            case "directorios Estructuras ordenadas":
                return directorios_Estructuras_ordenadas

            case "archivos 1-CORREDERAS":
                return archivos_1_CORREDERAS
            case "directorios 1-CORREDERAS":
                return directorios_1_CORREDERAS

            case "archivos 7-CORREDERA GALANDAS":
                return archivos_7_CORREDERA_GALANDAS

            case "archivos 5-CORREDERA + FIJO":
                return archivos_5_CORREDERA_mas_FIJO

            case "archivos 9-CORREDERA FIJO+ZOCALO":
                return archivos_9_CORREDERA_FIJOmasZOCALO

            case "archivos 8-CORREDERAS ELEVADORAS":
                return archivos_8_CORREDERAS_ELEVADORAS

            case "archivos 6-COLADURIAS":
                return archivos_6_COLADURIAS

            case "archivos 10-CANCELAS":
                return archivos_10_CANCELAS

            case "archivos 5-FIJOS":
                return archivos_5_FIJOS

            case "archivos 6-PLEGABLE":
                return archivos_6_PLEGABLE

            case "archivos 7-CURVAS":
                return archivos_7_CURVAS
            case "directorios 7-CURVAS":
                return directorios_7_CURVAS

            case "archivos CURVAS CON ZOCALO":
                return archivos_CURVAS_CON_ZOCALO

            case "archivos 4-PERSIANA":
                return archivos_4_PERSIANA
            case "directorios 4-PERSIANA":
                return directorios_4_PERSIANA

            case "archivos PERSIANA PLEGABLE":
                return archivos_PERSIANA_PLEGABLE

            case "archivos PERSIANAS SOBRE MURO":
                return archivos_PERSIANAS_SOBRE_MURO

            case "archivos PÈRSIANAS CON ZOCALO":
                return archivos_PÈRSIANAS_CON_ZOCALO

            case "archivos FIJOS PERSIANA":
                return archivos_FIJOS_PERSIANA

            case "archivos PERSIANA CON CRUCETA":
                return archivos_PERSIANA_CON_CRUCETA

            case "archivos 11-BARANDILLA":
                return archivos_11_BARANDILLA
            case "directorios 11-BARANDILLA":
                return directorios_11_BARANDILLA

            case "archivos Q railing":
                return archivos_Q_railing

            case "archivos Barana":
                return archivos_Barana

            case "archivos 3-PUERTAS":
                return archivos_3_PUERTAS
            case "directorios 3-PUERTAS":
                return directorios_3_PUERTAS

            case "archivos PUERTA + FIJO":
                return archivos_PUERTA_mas_FIJO

            case "archivos PUERTA+BANDERA":
                return archivos_PUERTAmasBANDERA

            case "archivos PUERTA + PIVE":
                return archivos_PUERTA_mas_PIVE

            case "archivos 2-PRACTICABLES":
                return archivos_2_PRACTICABLES
            case "directorios 2-PRACTICABLES":
                return directorios_2_PRACTICABLES

            case "archivos 15-VENTANA HOJAS DESIGUALES":
                return archivos_15_VENTANA_HOJAS_DESIGUALES

            case "archivos 17-VENTANA + PIVE":
                return archivos_17_VENTANA_mas_PIVE

            case "archivos 16-PIVOTANTE":
                return archivos_16_PIVOTANTE

            case "archivos 18-VENTANAS FALSO VIAS":
                return archivos_18_VENTANAS_FALSO_VIAS

            case "archivos 14-VENTANAS + FIJO":
                return archivos_14_VENTANAS_mas_FIJO

            case "archivos 8-PERSIANAS ENROLLABLES":
                return archivos_8_PERSIANAS_ENROLLABLES

            case "archivos 9-MOSQUITERA":
                return archivos_9_MOSQUITERA
                
            default:
                return []
        }
    }
    
    // Otros
    func getFormattedName(name: String) -> String {
        if name.range(of:"-") != nil {
            let nameWithOutNumber = name.components(separatedBy: "-")[1]
            return nameWithOutNumber.lowercased().firstUppercased
        }
        return name
    }
    
    func getSingularFamilia(name: String) -> String {
        if name != "" {
            var nombre = getFormattedName(name: name)
            nombre.removeLast()
            return nombre
        }
        return name
    }
}

