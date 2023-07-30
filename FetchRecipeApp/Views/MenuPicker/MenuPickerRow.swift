//
//  MenuPickerRow.swift
//  FetchRecipeApp
//
//  Created by Christian Pichardo on 6/14/23.
//

import SwiftUI

struct MenuPickerRow: View {
    let option: MenuPickerOption
    
    // An action called when user select an action.
    let onSelectedAction: (_ option: MenuPickerOption) -> Void
    
    var body: some View {
        ZStack{
            Color("pickerRowColor")
            Button(action: {
                self.onSelectedAction(option)
            }) {
                Text(option.option)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title2)
            }
            .foregroundColor(.black)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 2)
            }
            
       

        }
       
    }
}


struct MenuPickerRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuPickerRow(option:MenuPickerOption.testSingleArea, onSelectedAction: { _ in })
    }
}
