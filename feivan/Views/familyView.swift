//
//  Familia.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

import SwiftUI
import CoreData

struct familyView: View {
    
    //var cliente: Cliente
        
    @Environment(\.managedObjectContext) var viewContext
    
    /*
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Cliente.timestamp, ascending: false)],
        predicate: NSPredicate(format: "nombre == A"),
        fetchLimit: 1,
        animation: .default
    )
    private var aaa: FetchedResults<Cliente>
     */
    
    @State private var selectedFamilia: String = ""
    let familias = ["Correderas", "Practicables", "Puertas", "Puertas apertura exterior", "Elevadoras", "Mallorquinas", "Barandillas", "Puerta bandera"]
    
    var body: some View {
        let producto = Producto(context: viewContext)
        
        // Form here ? - para unificar la estetica
        VStack(spacing: 25) {
            //Text(cliente.nombre ?? "no encontrado")
            ForEach(familias, id: \.self) { familia in
                VStack {
                    NavigationLink(destination: productView(), label: {
                        Text(familia)
                            .textStyle(NavigationLinkStyle())
                    })
                    .simultaneousGesture(TapGesture().onEnded{
                        producto.id = UUID()
                        producto.timestamp = Date()
                        producto.familia = selectedFamilia
                        do {
                            try viewContext.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    })
                }
            }
        }
        .navigationTitle("Familia")
    }
}

struct familyView_Previews: PreviewProvider {
    static var previews: some View {
        familyView()
    }
}
