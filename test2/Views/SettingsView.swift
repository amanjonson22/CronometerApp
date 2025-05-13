//
//  SettingsView.swift
//  test2
//
//  Created by Amanda Rodrigues on 11/05/25.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) private var colorScheme
    @State private var isOn: Bool = false
    
    @State private var viewColorScheme: ColorScheme = .light
    
    var body: some View {
        HStack {
            Text("Dark Mode")
            Toggle("", isOn: $isOn)
                .onAppear() {
                    print(colorScheme)
                }
        }
        .padding()
        .onAppear() {
            switchAppearance()
        }
        .preferredColorScheme(viewColorScheme)
        .onChange(of: isOn) { oldValue, newValue in
            if newValue == true {
                viewColorScheme = .dark
            } else {
                viewColorScheme = .light
            }
        }
    }
    
    func switchAppearance() {
        viewColorScheme = colorScheme
        
        if colorScheme == .dark {
            isOn = true
            return
        } else {
            isOn = false
            return
        }
    }
}

#Preview {
    SettingsView()
}
