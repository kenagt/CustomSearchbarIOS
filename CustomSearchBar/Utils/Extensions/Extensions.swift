//
//  Extensions.swift
//  CustomSearchBar
//
//  Created by Kenan Begić on 24. 3. 2022..
//

import Foundation
import SwiftUI

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        /*
         self.windows
             .filter{$0.isKeyWindow}
             .first?
             .endEditing(force)
         */
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)?
            .endEditing(force)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
