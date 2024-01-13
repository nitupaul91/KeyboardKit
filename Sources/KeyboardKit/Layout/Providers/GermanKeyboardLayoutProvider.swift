//
//  File.swift
//  
//
//  Created by Paul Nitu on 13.01.2024.
//

import Foundation

class GermanKeyboardLayoutProvider: InputSetBasedKeyboardLayoutProvider {
    
    init() {
        super.init(
            alphabeticInputSet: .qwertz,
            numericInputSet: .standardNumeric(currency: "€"),
            symbolicInputSet: .standardSymbolic(currencies: ["€", "$", "£", "¥"])
        )
        self.localeKey = KeyboardLocale.german.id
    }
    
}
