//
//  Emoji+KeyboardWrapper.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Emoji {
    
    /**
     This is used as a view eraser for the emoji keyboard to
     make it possible to inject it with the standard builder
     in the system keyboard initializer.
     */
    struct KeyboardWrapper: View {
        
        let actionHandler: KeyboardActionHandler
        let keyboardContext: KeyboardContext
        let styleProvider: KeyboardStyleProvider
        
        init(
            actionHandler: KeyboardActionHandler,
            keyboardContext: KeyboardContext,
            calloutContext: CalloutContext?,
            styleProvider: KeyboardStyleProvider
        ) {
            self.actionHandler = actionHandler
            self.keyboardContext = keyboardContext
            self.styleProvider = styleProvider
        }
        
        public var body: some View {
            EmojiKeyboardView(
                actionHandler: actionHandler,
                keyboardContext: keyboardContext,
                style: KeyboardStyle.EmojiKeyboard.standard(for: keyboardContext)
            )
        }
        
        static let isPro = false
    }
}

struct EmojiKeyboardView: View {
    
    var actionHandler: KeyboardActionHandler
    var keyboardContext: KeyboardContext
    let style: KeyboardStyle.EmojiKeyboard
    
    let emojis: [String] = ["😀", "😃", "😄", "😁"]
    
    var body: some View {
        let rows = Array(repeating: GridItem(.fixed(style.itemSize + style.verticalPadding * 2), spacing: style.verticalItemSpacing), count: style.rows)
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: style.horizontalItemSpacing) {
                ForEach(emojis, id: \.self) { emoji in
                    Button(action: {
                        actionHandler.handle(.emoji(emoji))
                    }) {
                        Text(emoji)
                            .font(style.itemFont)
                            .frame(width: style.itemSize, height: style.itemSize)
                            .padding(.vertical, style.verticalPadding)
                    }
                }
            }
        }
    }
}
