//
//  ContentView.swift
//  CustomSearchBar
//
//  Created by Kenan Begić on 24. 3. 2022..
//

import SwiftUI

struct MainView: View {
    @StateObject var countryCodeViewModel = CountryCodeViewModel()
        
    var body: some View {
        CountryCodeView(countryCodeViewModel: countryCodeViewModel)
    }
}
