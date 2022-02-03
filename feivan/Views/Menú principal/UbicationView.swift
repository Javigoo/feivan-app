//
//  UbucationView.swift
//  Feivan
//
//  Created by javigo on 3/2/22.
//

import SwiftUI
import MapKit

struct UbicationView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                getUbi()
            }
    }
}

func getUbi() {
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: 40.429248, longitude: -3.664194)
    geoCoder.reverseGeocodeLocation(location, completionHandler: {
        placemarks, error -> Void in

        // Place details
        guard let placeMark = placemarks?.first else { return }

        print(placeMark)
        print(placeMark.description)
        
        if let street = placeMark.thoroughfare {
            print("Calle: ",street)
        }
            
        if let numero = placeMark.subThoroughfare {
            print("Número: ",numero)
        }
            
        if let city = placeMark.subAdministrativeArea {
            print("Ciudad: ",city)
        }
        
    })
}

