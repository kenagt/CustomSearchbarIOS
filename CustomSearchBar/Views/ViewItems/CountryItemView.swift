//
//  CountryItemView.swift
//  CustomSearchBar
//
//  Created by Kenan Begić on 24. 3. 2022..
//

import Foundation
import SwiftUI

struct CountryItemView: View {
    //MARK: vars
    let countryModel: CountryModel
    var selected: Bool = false
    
    //MARK: init
    init(countryModel: CountryModel, selected: Bool) {
        self.countryModel = countryModel
        self.selected = selected
    }
    
    //MARK: body
    var body: some View {
        VStack {
            HStack {
                Text("\(countryModel.name)\("(")\(countryModel.dial_code)\(")")")
                    .font(Font.system(size: 20))
                    .foregroundColor(Color.textColorPrimary)
                    .fontWeight(.light)
                    .padding(.top, 7)
                    .padding(.bottom, 7)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 17, height: 13, alignment: .center)
                    .foregroundColor(Color.colorBackground)
                    .opacity(selected ? 1 : 0)
            }
            Divider().background(Color.gray)
        }
        .padding(.leading, 19)
        .padding(.trailing, 19)
    }
}
