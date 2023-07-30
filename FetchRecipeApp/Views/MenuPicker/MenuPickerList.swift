//
//  MenuPickerList.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/15/23.
//

import SwiftUI

struct MenuPickerList: View {
    // The drop-down menu list options
    let options: [MenuPickerOption]
    
    // An action called when user select an action.
    let onSelectedAction: (_ option: MenuPickerOption) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 6) {
               
                ForEach(options) { option in
                    MenuPickerRow(option: option, onSelectedAction: self.onSelectedAction)
                       
                        .padding(.horizontal, 3)
                   
                }
            }
        }
        // Check first if number of options * 32 (Option height - CONSTANT - YOU
        // MAY CHANGE IT) is greater than 300 (MAX HEIGHT - ALSO, YOU MAY CHANGE
        // IT), if true, then make it options list scroll, if not set frame only
        // for available options.
        .frame(height: CGFloat(self.options.count * 32) > 300
               ? 300
               : CGFloat(self.options.count * 32)
        )
        .padding(.vertical, 5)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 2)
        }
    }
}

struct MenuPickerList_Previews: PreviewProvider {
    static var previews: some View {
        MenuPickerList(
            options:MenuPickerOption.testAllAreas,
            onSelectedAction: { _ in})
    }
}
