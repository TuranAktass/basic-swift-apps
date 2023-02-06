//
//  CircularImageView.swift
//  widget-kit
//
//  Created by Turan Aktaş on 6.02.2023.
//

import SwiftUI

struct CircularImageView: View {
    var image : Image
    var body: some View {
        image.resizable().aspectRatio( contentMode: .fit).clipShape(Circle()).overlay(Circle().stroke())
    }
}

struct CircularImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularImageView(image: Image("batman"))
    }
}
