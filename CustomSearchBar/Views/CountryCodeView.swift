//
//  CountryCodeView.swift
//  CustomSearchBar
//
//  Created by Kenan Begić on 24. 3. 2022..
//

import Foundation
import SwiftUI

struct CountryCodeView: View {
    //MARK: vars
    @ObservedObject var countryCodeViewModel: CountryCodeViewModel
    @State private var countryName: String = ""
    @State private var scrollTarget: String?
    
    //MARK: init
    init(countryCodeViewModel: CountryCodeViewModel){
        self.countryCodeViewModel = countryCodeViewModel
    }
    
    //MARK: searchBar
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField(LocalizedStringKey("search"), text: $countryName)
                .font(Font.system(size: 21))
        }
        .padding(7)
        .background(Color.searchBarColor)
        .cornerRadius(50)
    }
    
    //MARK: countriesListView
    var countriesListView: some View {
        ScrollView {
            ScrollViewReader { scrollProxy in
                LazyVStack(pinnedViews:[.sectionHeaders]) {
                    ForEach(countryCodeViewModel.sections.filter{ self.searchForSection($0)}, id: \.self) { letter in
                        Section(header: CountrySectionHeaderView(text: letter).frame(width: nil, height: 35, alignment: .leading)) {
                            ForEach(countryCodeViewModel.countryCodes.filter{ self.searchForCountry($0.name!)} ) { countryModel in
                                CountryItemView(countryModel: countryModel, selected: (countryModel.code == countryCodeViewModel.code) ? true : false)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        print("TZAP!!!!!")
                                        selectCountryCode(selectedCountry: countryModel)
                                    }
                            }
                        }
                    }
                }
                .onChange(of: scrollTarget) { target in
                    if let target = target {
                        scrollTarget = nil

                        withAnimation {
                            scrollProxy.scrollTo(target, anchor: .topLeading)
                        }
                    }
                }
            }
        }
    }
    
    private func searchForCountry(_ txt: String) -> Bool {
        return (txt.lowercased(with: .current).hasPrefix(countryName.lowercased(with: .current)) || countryName.isEmpty)
    }
    
    private func searchForSection(_ txt: String) -> Bool {
        return (txt.prefix(1).lowercased(with: .current).hasPrefix(countryName.prefix(1).lowercased(with: .current)) || countryName.isEmpty)
    }
    
    //MARK: lettersListView
    var lettersListView: some View {
        VStack {
            ForEach(countryCodeViewModel.sections, id: \.self) { letter in
                HStack {
                    Spacer()
                    Button(action: {
                        if countryCodeViewModel.countryCodes.first(where: { $0.name!.prefix(1) == letter }) != nil {
                            withAnimation {
                                scrollTarget = letter
                            }
                        }
                    }, label: {
                        Text(letter)
                            .font(.system(size: 12))
                            .padding(.trailing, 7)
                            .foregroundColor(Color.textColorPrimary)
                    })
                }
            }
        }
    }
    
    //MARK: selectCountryCode
    func selectCountryCode(selectedCountry: CountryModel){
        countryCodeViewModel.countryCodeNumber = selectedCountry.dial_code ?? ""
        countryCodeViewModel.country = selectedCountry.name ?? ""
        countryCodeViewModel.code = selectedCountry.code ?? ""
    }
    
    //MARK: body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            searchBar
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .background(Color.barTintColor)
            Divider().background(Color.gray)
                .padding(.top, 10)
            ZStack {
                countriesListView
                lettersListView
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(LocalizedStringKey("choose.country"), displayMode: .inline)
    }
}

struct CountryCodeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CountryCodeView(countryCodeViewModel: CountryCodeViewModel()).environment(\.colorScheme, .light).previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
            CountryCodeView(countryCodeViewModel: CountryCodeViewModel()).environment(\.colorScheme, .dark).previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        }
    }
}
