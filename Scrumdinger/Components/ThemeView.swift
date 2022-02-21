//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by mac on 11/02/2022.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(theme.mainColor)
            Label(theme.name,systemImage: "paintpalette")
                .padding(8)
            
            
        }  .foregroundColor(theme.accentColor)
            .fixedSize(horizontal: false, vertical: true)

       
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: .bubblegum)
    }
}
