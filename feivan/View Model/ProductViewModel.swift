//
//  ProductViewModel.swift
//  Feivan
//
//  Created by javigo on 21/10/21.
//

import CoreData
import UIKit
import SwiftUI

class ProductViewModel: ObservableObject {
    @Published var foto = Data()
    @Published var familia = ""
    @Published var nombre = ""
    @Published var curvas = ""
    @Published var material = ""
    @Published var color = ""
    @Published var tapajuntas = ""
    @Published var dimensiones = ""
    @Published var apertura = ""
    @Published var marcoInferior = ""
    @Published var huella = ""
    @Published var forroExterior = ""
    @Published var cristal = ""
    @Published var cerraduras = ""
    @Published var manetas = ""
    @Published var herraje = ""
    @Published var posicion = ""
    @Published var instalacion = ""
    @Published var rematesAlbanileria = false
    @Published var medidasNoBuenas = false
    @Published var mallorquina = ""
    @Published var hojaPrincipal = ""

    @Published var otro = ""
    @Published var especifico = ""
    @Published var anotacion = ""

    @Published var timestamp = Date()
    @Published var productos: [Producto] = []
    private let context = PersistenceController.shared
    
    init() {
        getAllProducts()
    }
    
    func getAllProducts() {
        let request = Producto.fetchRequest()
        do {
            productos = try context.viewContext.fetch(request)
        } catch {
            print("ERROR in ProductViewModel at getAllProducts()\n")
        }
    }
    
    func getProduct(producto: Producto) {
        foto = producto.foto ?? foto
        familia = producto.familia ?? familia
        nombre = producto.nombre ?? nombre
        curvas = producto.curvas ?? curvas
        material = producto.material ?? material
        color = producto.color ?? color
        tapajuntas = producto.tapajuntas ?? tapajuntas
        dimensiones = producto.dimensiones ?? dimensiones
        apertura = producto.apertura ?? apertura
        marcoInferior = producto.marcoInferior ?? marcoInferior
        huella = producto.huella ?? huella
        forroExterior = producto.forroExterior ?? forroExterior
        cristal = producto.cristal ?? cristal
        cerraduras = producto.cerraduras ?? cerraduras
        manetas = producto.manetas ?? manetas
        herraje = producto.herraje ?? herraje
        posicion = producto.posicion ?? posicion
        instalacion = producto.instalacion ?? instalacion
        rematesAlbanileria = producto.rematesAlbanileria
        medidasNoBuenas = producto.medidasNoBuenas
        mallorquina = producto.mallorquina ?? mallorquina
        hojaPrincipal = producto.hojaPrincipal ?? hojaPrincipal
    }
    
    func setProduct(producto: Producto) {
        producto.foto = foto
        producto.familia = familia
        producto.nombre = nombre
        producto.curvas = curvas
        producto.material = material
        producto.color = color
        producto.tapajuntas = tapajuntas
        producto.dimensiones = dimensiones
        producto.apertura = apertura
        producto.marcoInferior = marcoInferior
        producto.huella = huella
        producto.forroExterior = forroExterior
        producto.cristal = cristal
        producto.cerraduras = cerraduras
        producto.manetas = manetas
        producto.herraje = herraje
        producto.posicion = posicion
        producto.instalacion = instalacion
        producto.rematesAlbanileria = rematesAlbanileria
        producto.medidasNoBuenas = medidasNoBuenas
        producto.mallorquina = mallorquina
        producto.hojaPrincipal = hojaPrincipal
    }
    
    func save() {
        let producto = Producto(context: context.viewContext)
        
        setProduct(producto: producto)
        producto.timestamp = timestamp
    
        context.save()
        getAllProducts()
    }
    
    func update(producto: Producto) {
        setProduct(producto: producto)
        
        context.save()
        getAllProducts()
    }
    
    func delete(at offset: IndexSet, for productos: [Producto]) {
        if let first = productos.first, case PersistenceController.shared.viewContext = first.managedObjectContext {
            offset.map { productos[$0] }.forEach(PersistenceController.shared.viewContext.delete)
        }
        
        context.save()
        getAllProducts()
        
    }
    // Others
    func getFormattedName(name: String) -> String {
        if name.range(of:"-") != nil {
            return name.components(separatedBy: "-")[1]
        }
        return name
    }
    
    // Getters

    /*
    func getAttribute(option: String) -> Binding<String> {
        switch option {
            case "Material":
            return Binding(projectedValue: self.material)
            default:
                return ""
        }
    }
    */
    func listOf(option: String) -> [String] {
        
//        if let localData = readLocalFile(forName: "Hierarchy") {
//            parse(jsonData: localData)
//        }
        
        let materialOpciones = ["PVC", "Aluminio"]
        let materialAluminioOpciones = ["800", "CT", "Cor 4200", "Cor Vision", "Cor Vision Plus", "Lumeal", "Soleal", "Arteal", "APG", "ATI 55", "ATI 70", "COR 60", "COR 70", "COR.OC 60", "COR.OC 70"]
        let tapajuntasOpciones = ["30", "40", "60", "80", "100"]
        let colorOpciones =  [
            "Ral",
            "Anonizados",
            "Madera",
            "Más utilizados"
          ]
        
        let opcionesAnonizados = [
                  "Oro",
                  "Plata",
                  "Bronce",
                  "Inox"
                ]
        let opcionesMadera = [
                  "Embero",
                  "Nogal",
                  "Pino envejecido",
                  "Pino pollo"
                ]
        let opcionesMasUtilizados = [
                  "Blanco",
                  "Embero",
                  "Nogal",
                  "Pino envejecido",
                  "Plata",
                  "Bronce",
                  "Inox",
                  "Verde 6009",
                  "Verde 6002",
                  "Marrón 8014",
                  "Crema 1015",
                  "Ral.7022",
                  "Ral.7016",
                  "Plata ext/blanco int",
                  "Embero ext/blanco int",
                  "Bronce ext/blanco int",
                  "Blanco ext/embero int"
                ]
        
        let posicionOpciones = [
            "Cocina",
            "Habitación",
            "Sala de estar",
            "Trastero",
            "Recibidor",
            "Patio",
            "Lavadero"
          ]

        let marcoInferiorOpciones = ["Abierto", "Cerrado", "Solera", "Empotrado"]
        let forroExteriorOpciones = ["Pletina", "40", "60", "Otro"]
        let cristalOpciones = ["Cámara", "4/Cámara/6", "4/Cámara/4+4", "6/?/4+4 silence", "4+4", "5+5", "6+6"]
        let mallorquinaOpciones = ["Lama móvil", "Lama fija", "Travesaño horizontal", "Travesaño vertical", "Cruceta", "Persiana planta baja 4 hojas", "Persiana planta baja hoja sobre hoja", "Persiana planta baja apertura libro"]
        let cerradurasOpciones = ["Cerradura", "Cerradura multipunto", "Cerradura 3 puntos", "Cerradura gesa"]
        let manetasOpciones = ["Cremona", "Maneta presión", "Arch invisible", "Cremona minimalista", "Maneta interior/exterior", "Solo maneta interior", "Solo maneta exterior"]
        let herrajeOpciones = ["Mismo color", "Bisagras seguridad", "Bisagras oculta", "Cierre clip + Uñero", "Muelle", "Cerradura electrónica", "Tirador exterior", "Tirador exterior/interior", "Pasadores resaltados"]
        let instalacionOpciones = ["Huella obra", "Premarco", "Desmontando madera", "Desmontando hierro", "Desmontando aluminio"]
        let curvasOpciones = ["Medio punto", "Carpanel", "Arco", "Segmento"]
        let hojaPrincipalOpciones = ["Izquierda", "Derecha"]
        

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
        let archivos_5_FIJOS = ["1-0", "2-02H", "3-02V", "4-03H", "5-03V", "6-04", "7-06", "8-0IND", "9-0INI", "12-CF", "13-CFT"]
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
        
        switch option {
            case "Material":
                return materialOpciones
            case "Material Aluminio":
                return materialAluminioOpciones
            case "Tapajuntas":
                return tapajuntasOpciones
            case "Color":
                return colorOpciones
            case "Anonizados":
                return opcionesAnonizados
            case "Madera":
                return opcionesMadera
            case "Más utilizados":
                return opcionesMasUtilizados
            case "MarcoInferior":
                return marcoInferiorOpciones
            case "Forro exterior":
                return forroExteriorOpciones
            case "Cristal":
                return cristalOpciones
            case "Mallorquina":
                return mallorquinaOpciones
            case "Cerraduras":
                return cerradurasOpciones
            case "Manetas":
                return manetasOpciones
            case "Herraje":
                return herrajeOpciones
            case "Instalación":
                return instalacionOpciones
            case "Curvas":
                return curvasOpciones
            case "Hoja principal":
                return hojaPrincipalOpciones
            case "Posición":
                return posicionOpciones
                    
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
    
}

