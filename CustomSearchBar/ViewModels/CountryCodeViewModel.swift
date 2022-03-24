//
//  CountryCodeViewModel.swift
//  CustomSearchBar
//
//  Created by Kenan Begić on 24. 3. 2022..
//

import Foundation

class CountryCodeViewModel: ObservableObject {
    //MARK: vars
    var countryCodes = [CountryModel]()
    let sections = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    @Published var countryCodeNumber = ""
    @Published var country = ""
    @Published var code = ""
    
    //MARK: init
    init() {
        loadCountryCodes()
    }
    
    //MARK: functions
    func loadCountryCodes(){
        let countryCodesPath = Bundle.main.path(forResource: "CountryCodes", ofType: "json")!
        
        do {
            let fileCountryCodes = try? String(contentsOfFile: countryCodesPath).data(using: .utf8)!
            let decoder = JSONDecoder()
            countryCodes = try decoder.decode([CountryModel].self, from: fileCountryCodes!)
        }
        catch {
          print (error)
        }
        
        country = countryCodes.filter { $0.code == countryCodeNumber }.first?.name ?? ""
        code = countryCodes.filter { $0.code == countryCodeNumber }.first?.code ?? ""
        countryCodeNumber = countryCodes.filter { $0.code == countryCodeNumber }.first?.dial_code ?? ""
    }
}
