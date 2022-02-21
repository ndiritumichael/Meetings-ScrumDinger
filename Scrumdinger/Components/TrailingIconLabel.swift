//
//  TrailingIconLabel.swift
//  Scrumdinger
//
//  Created by mac on 09/02/2022.
//

import SwiftUI

struct TrailingIconLabelStyle:LabelStyle{
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.title
            configuration.icon
        }
       }
}


extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}
