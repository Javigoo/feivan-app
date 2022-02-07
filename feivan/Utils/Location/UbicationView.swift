//
//  UbucationView.swift
//  Feivan
//
//  Created by javigo on 3/2/22.
//

import SwiftUI
import MapKit
import CoreLocation

struct Direccion {
    var calle: String = ""
    var numero: String = ""
    var codigo_postal: String = ""
    var ciudad: String = ""
    
    func getAddress() -> String {
        var resultado: [String] = []

        if !calle.isEmpty {
            resultado.append(calle)
        }
        if !numero.isEmpty {
            resultado.append(numero)
        }
        if !codigo_postal.isEmpty {
            resultado.append(codigo_postal)
        }
        if !ciudad.isEmpty {
            resultado.append(ciudad)
        }
        return resultado.joined(separator: ", ")
    }
}

func getAddress(handler: @escaping (Direccion) -> Void) {
    var direccion: Direccion = Direccion()

    let locManager = CLLocationManager()
    locManager.requestWhenInUseAuthorization()
    var currentLocation: CLLocation!

    if
        locManager.authorizationStatus == .authorizedWhenInUse ||
        locManager.authorizationStatus ==  .authorizedAlways
    {
        currentLocation = locManager.location
    } else {
        handler(direccion)
        return
    }
    
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
    
    geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

        guard let placeMark = placemarks?.first else { return }
        
        if let calle = placeMark.thoroughfare {
            direccion.calle = calle
        }

        if let numero = placeMark.subThoroughfare {
            direccion.numero = numero
        }

        if let codigo_postal = placeMark.postalCode {
            direccion.codigo_postal = codigo_postal
        }

        if let ciudad = placeMark.locality {
            direccion.ciudad = ciudad
        }

        handler(direccion)
    })
}


//struct UbicationView: View {
//    @State var direccion: Direccion = Direccion()
//
//    var body: some View {
//        VStack {
//            Text("Calle: \(direccion.calle)")
//            Text("Número: \(direccion.numero)")
//            Text("Código postal: \(direccion.codigo_postal)")
//            Text("Ciudad: \(direccion.ciudad)")
//        }.onAppear{
//            getAddress { (address) in
//                direccion = address
//            }
//        }
//    }
//}
