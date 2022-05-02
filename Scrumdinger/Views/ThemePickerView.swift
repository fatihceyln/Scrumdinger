//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Fatih Kilit on 2.05.2022.
//

import SwiftUI

struct ThemePickerView: View {
    
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
                // You have to put theme inside the tag
                // I'm not sure but you have to do it
                // Maybe you can ask in stackoverflow
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePickerView(selection: .constant(.periwinkle))
    }
}
