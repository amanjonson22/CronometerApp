//
//  ContentView.swift
//  test2
//
//  Created by Amanda Rodrigues on 10/05/25.
//

import SwiftUI

struct TimerView: View {
    
    @State var isCounting: Bool
    @State var timeRemaining: Int
    @State private var selectedMinutes: Int = 0
    @State private var selectedSeconds: Int = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            if !isCounting {
                HStack {
                    Picker("Minutes", selection: $selectedMinutes) {
                        ForEach(0..<60, id: \.self) { min in
                            Text("\(min)").tag(min)
                        }
                    }.pickerStyle(WheelPickerStyle())
                    Text("min")
                    Picker("Seconds", selection: $selectedSeconds) {
                        ForEach(0..<60, id: \.self) { sec in
                            Text("\(sec) ").tag(sec)
                        }
                    }.pickerStyle(WheelPickerStyle())
                    
                    Text("sec")
                }
                .frame(width: 300)
                Button("Start", systemImage: "play.circle.fill", action: {
                    timeRemaining = (selectedMinutes * 60) + selectedSeconds
                    isCounting = true
                    UseTimer(isCounting: isCounting)
                })
                .padding()
                
            } else {
                Text(timeString(timeRemaining))
                    .font(.largeTitle)
                    .padding()
                
                Button("Pause", systemImage: "pause.circle.fill", action: {
                    isCounting = false
                    UseTimer(isCounting: isCounting)
                })
                
            }
        }
    }
    
    init(isCounting: Bool = false, remainingSeconds: Int) {
        self.isCounting = isCounting
        self.timeRemaining = remainingSeconds
    }
    
    
    private func timeString(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secondsPart = seconds % 60
        return String(format: "%02d:%02d", minutes, secondsPart)
    }
    
    private func UseTimer(isCounting: Bool) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 && isCounting {
                timeRemaining -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    TimerView(remainingSeconds: 60)
}
