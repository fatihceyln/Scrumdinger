//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Fatih Kilit on 1.05.2022.
//

import SwiftUI

// if we want to write an custom 'LabelStyle', first of all we have to create an struct that conforms 'LabelStyle' protocol. After we do that we can configure our custom LabelStyle. To handle with that we have to create an makeBody() function. This function allows us to make our custom LabelStyle and return it later as a view.

// After doing this, we can use our custom LabelStyle just writing 'labelStyle(TrailingIconLabelStyle())'

// But if we want to use it withing custom view modifier, we have to write an extension to View

// After doing this, we can use our custom LabelStyle with view modifier.

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
