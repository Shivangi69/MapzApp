//
//  SearchBarView.swift
//  
//
//  Created by Alex Nagy on 17.01.2021.
//

import SwiftUI

@available(iOS 14.0, *)
public struct SearchBarView: View {
    
    var title: String
    @Binding var text: String
    private var font: Font
    private var iconView: () -> AnyView
    private var showsCancelButton: Bool
    private var cancelButtonLabel: () -> AnyView
    private var showsClearSearchButton: Bool
    private var clearSearchButtonLabel: () -> AnyView
    private var textBackgroundView: () -> AnyView
    private var backgroundView: () -> AnyView
    private var spacing: CGFloat
    private var onEditingChanged: (Bool) -> Void
    private var onCommit: () -> Void
    private let onCancel: () -> Void
    
    public init(title: String = "Search",
         text: Binding<String>,
         onCancel: @escaping () -> ()) {
        self.title = title
        self._text = text
        self.font = .subheadline
        self.iconView = { AnyView(Image(systemName: "magnifyingglass").foregroundColor(.gray)) }
        self.showsCancelButton = true
        self.cancelButtonLabel = { AnyView(Text("Cancel")) }
        self.showsClearSearchButton = true
        self.clearSearchButtonLabel =  { AnyView(Image(systemName: "xmark.circle.fill").foregroundColor(Color(.systemGray3))) }
        self.textBackgroundView = { AnyView(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.secondarySystemBackground))) }
        self.backgroundView = { AnyView(Color(.systemBackground)) }
        self.spacing = 8
        self.onEditingChanged = {_ in}
        self.onCommit = {}
        self.onCancel = onCancel
    }
    
    public init(title: String = "Search",
         text: Binding<String>,
         font: Font = .subheadline,
         iconView: @escaping () -> AnyView = { AnyView(Image(systemName: "magnifyingglass").foregroundColor(.gray)) },
         showsCancelButton: Bool = true,
         cancelButtonLabel: @escaping () -> AnyView = { AnyView(Text("Cancel")) },
         showsClearSearchButton: Bool = true,
         clearSearchButtonLabel: @escaping () -> AnyView = { AnyView(Image(systemName: "xmark.circle.fill").foregroundColor(Color(.systemGray3))) },
         textBackgroundView: @escaping () -> AnyView = { AnyView(RoundedRectangle(cornerRadius: 8).foregroundColor(Color(.secondarySystemBackground))) },
         backgroundView: @escaping () -> AnyView = { AnyView(Color(.systemBackground)) },
         spacing: CGFloat = 8,
         onEditingChanged: @escaping (Bool) -> Void = {_ in},
         onCommit: @escaping () -> Void = {},
         onCancel: @escaping () -> () = {}) {
        self.title = title
        self._text = text
        self.font = font
        self.iconView = iconView
        self.showsCancelButton = showsCancelButton
        self.cancelButtonLabel = cancelButtonLabel
        self.showsClearSearchButton = showsClearSearchButton
        self.clearSearchButtonLabel = clearSearchButtonLabel
        self.textBackgroundView = textBackgroundView
        self.backgroundView = backgroundView
        self.spacing = spacing
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.onCancel = onCancel
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            
            HStack(spacing: 3) {
                iconView()
                TextField(title, text: $text, onEditingChanged: onEditingChanged, onCommit: onCommit).foregroundColor(.primary)
                if text != "", showsClearSearchButton {
                    Button {
                        text = ""
                    } label: {
                        clearSearchButtonLabel()
                    }
                }
            }
            .font(font)
            .padding(5)
            .background(
                textBackgroundView()
            )
            
            if showsCancelButton {
                Button {
                    onCancel()
                } label: {
                    cancelButtonLabel()
                }
            }
        }
        .padding()
        .background(backgroundView().ignoresSafeArea())
    }
}

