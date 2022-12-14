//
//  PressureSectionView.swift
//  GVC-Apple-Multiplatform
//
//  Created by Zaid Neurothrone on 2022-10-26.
//

import GVCCore
import SwiftUI

struct PressureSectionView: View {
  @Binding var text: String
  @Binding var selection: PressureSelection
  
  var body: some View {
    Section {
      Picker(
        LocalizedStrings.Form.pressurePickerHint,
        selection: $selection
      ) {
        ForEach(PressureSelection.allCases) {
          Text($0.toString)
        }
      }
      .pickerStyle(.segmented)
      .listRowBackground(EmptyView())
      .listRowInsets(EdgeInsets())
      .listRowSeparator(.hidden)
      
      if selection == .custom {
        CustomTextFieldView(
          placeholder: LocalizedStrings.Form.pressureFieldPlaceholder,
          text: $text
        )
      }
      
    } header: {
      SectionHeaderView(text: LocalizedStrings.Form.pressureLabel)
    }
  }
}

struct PressureSectionView_Previews: PreviewProvider {
  static var previews: some View {
    PressureSectionView(
      text: .constant(""),
      selection: .constant(.fourThousand)
    )
  }
}
