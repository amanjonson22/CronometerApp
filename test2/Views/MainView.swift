//
//  TabView.swift
//  test2
//
//  Created by Amanda Rodrigues on 11/05/25.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            Tab("Timer", systemImage: "timer") {
                TimerView(remainingSeconds: 60)
            }
            
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }
    }
}

#Preview {
    MainView()
}
