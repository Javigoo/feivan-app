//
//  Home.swift
//  feivan
//
//  Created by javigo on 22/7/21.
//

import SwiftUI

struct homeView: View {
    var body: some View {
        NavigationView {
        
            VStack(spacing: 15){
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                
                NavigationLink(destination: clientView(), label: {
                    Text("Nuevo")
                        .frame(width: 250, height: 20, alignment: .center)
                        .foregroundColor(.black)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                })
                
                Spacer()
                            
            }
        }
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
