//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Fatih Kilit on 1.05.2022.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
        .padding(.trailing, 20)
    }
}

extension View {
    func trailingIconLabelStyle() -> some View {
        labelStyle(TrailingIconLabelStyle())
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}

// These two extension does same thing.
