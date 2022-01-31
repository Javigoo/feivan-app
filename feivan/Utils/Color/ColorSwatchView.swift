//
//  ColorSwatchView.swift
//  Feivan
//
//  Created by javigo on 31/1/22.
//

import SwiftUI

struct ColorSwatchView: View {

    @Binding var selection: String

    var body: some View {

        let swatches = [
            "red",
            "blue",
            "green"
        ]

        let columns = [
            GridItem(.adaptive(minimum: 60))
        ]

        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(swatches, id: \.self){ swatch in
                ZStack {
                    Circle()
                        .fill(Color("red"))
                        .frame(width: 50, height: 50)
                        .onTapGesture(perform: {
                            selection = swatch
                        })
                        .padding(10)

                    if selection == swatch {
                        Circle()
                            .stroke(Color("red"), lineWidth: 5)
                            .frame(width: 60, height: 60)
                    }
                }
            }
        }
        .padding(10)
    }
}

struct ColorSwatchView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSwatchView(selection: .constant("red"))
    }
}
