//
//  AutocompleteToolbarItemText.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view replicates the standard autocomplete toolbar item
 text that is used in native iOS keyboards.
 
 The view will enforce a single line limit and resize itself
 to share the available horizontal space with other views.
 */
public struct AutocompleteToolbarItemText: View {
    
    /**
     Create an autocomplete toolbar item text view.
     
     - Parameters:
       - suggestions: The suggestion to display in the view.
     */
    public init(
        suggestion: AutocompleteSuggestion,
        locale: Locale) {
        self.suggestion = suggestion
        self.locale = locale
    }
    
    private let locale: Locale
    private let suggestion: AutocompleteSuggestion
        
    public var body: some View {
        Text(displayTitle)
            .lineLimit(1)
            .frame(maxWidth: .infinity)
    }
}

private extension AutocompleteToolbarItemText {
    
    var displayTitle: String {
        if !suggestion.isUnknown { return suggestion.title }
        let beginDelimiter = locale.quotationBeginDelimiter ?? "\""
        let endDelimiter = locale.quotationEndDelimiter ?? "\""
        return "\(beginDelimiter)\(suggestion.title)\(endDelimiter)"
    }
}

struct AutocompleteToolbarItemText_Previews: PreviewProvider {
    
    static var previews: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                ForEach(KeyboardLocale.allCases) {
                    preview(for: $0)
                }
            }.padding()
        }
    }
    
    static func preview(for locale: KeyboardLocale) -> some View {
        VStack(spacing: 5) {
            Text(locale.localeIdentifier).font(.headline)
            HStack {
                ForEach(Array(previewSuggestions.enumerated()), id: \.offset) {
                    AutocompleteToolbarItemText(
                        suggestion: $0.element,
                        locale: locale.locale)
                }
            }.previewBar()
        }
    }
    
    static let previewSuggestions: [AutocompleteSuggestion] = [
        StandardAutocompleteSuggestion("Foo", isUnknown: true),
        StandardAutocompleteSuggestion("Bar", isAutocomplete: true),
        StandardAutocompleteSuggestion(text: "", title: "Baz", subtitle: "Recommended")]
}

private extension View {
    
    func previewBar() -> some View {
        self.padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
}
