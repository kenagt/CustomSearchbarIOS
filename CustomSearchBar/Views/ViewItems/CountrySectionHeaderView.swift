//
//  CountrySectionHeaderView.swift
//  CustomSearchBar
//
//  Created by Kenan Begić on 24. 3. 2022..
//

import Foundation
import SwiftUI

struct CountrySectionHeaderView: View {
    //MARK: vars
    let text: String
    
    //MARK: body
    var body: some View {
        Rectangle()
            .fill(Color.backgroundColor)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .overlay(
                Text(text)
                    .font(Font.system(size: 21))
                    .foregroundColor(Color.textColorPrimary)
                    .fontWeight(.semibold)
                    .padding(.leading, 17)
                    .padding(.trailing, 17)
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    .frame(maxWidth: nil, maxHeight: nil, alignment: .leading),
                alignment: .leading
            )
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CountrySectionHeaderView(text: "A").environment(\.colorScheme, .light).previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        }
    }
}
