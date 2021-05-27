//
//  CenterModifier.swift
//  critterclan
//
//  Created by Shameem Reza on 27/5/21.
//

import SwiftUI

struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
