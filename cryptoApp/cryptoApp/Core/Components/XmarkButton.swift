//
//  XmarkButton.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 15/08/2023.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        Button {
            presentation.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
        }

    }
}

struct XmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButton()
    }
}
