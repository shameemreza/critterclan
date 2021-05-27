//
//  CreditsView.swift
//  critterclan
//
//  Created by Shameem Reza on 27/5/21.
//

import SwiftUI

struct CreditsView: View {
    // MARK: PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Image("compass")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            Text("""
    Copyright © Shameem Reza
    Allrights reserved
    Better Apps ♡ Less code
    """)
                .font(.footnote)
                .multilineTextAlignment(.center)
        } //: VSTACK
        .padding()
        .opacity(0.4)
    }
}

// MARK - PREVIEW
struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
