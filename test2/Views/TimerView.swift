//
//  ContentView.swift
//  test2
//
//  Created by Amanda Rodrigues on 10/05/25.
//

import SwiftUI

struct TimerView: View {
    
    private let predefinedSeconds: [Int] = [10, 30, 60, 120, 300]
    private let symbolActive = "play.circle.fill"
    private let symbolInactive = "pause.circle.fill"
    
    @State var isCounting: Bool
    @State var remainingSeconds: Int

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(getTimeString(totalSeconds: remainingSeconds))")
                .onReceive(timer) { _ in
                    if isCounting && remainingSeconds > 0 {
                        remainingSeconds -= 1
                    } else {
                        isCounting = false
                    }
                }
                .padding()
            
        }
        VStack {
            HStack {
                ForEach(predefinedSeconds, id: \.self) { seconds in
                    Button(getButtonString(seconds)) {
                        addSeconds(seconds)
                    }.padding(5)
                }
            }.padding()
            
            Button {
                isCounting.toggle()
            } label: {
                Image(systemName: isCounting ? symbolInactive : symbolActive)
                    .font(.system(size: 50))
            }

        }
    }
    
    init(isCounting: Bool = false, remainingSeconds: Int) {
        self.isCounting = isCounting
        self.remainingSeconds = remainingSeconds
    }
    
    
    private func addSeconds(_ seconds: Int) {
        self.remainingSeconds += seconds
    }
    
    private func getTimeString(totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = totalSeconds / 60 % 60
        let seconds = totalSeconds % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    private func getButtonString(_ totalSeconds: Int) -> String {
        if totalSeconds >= 60 {
            return "+\(totalSeconds/60) min"
        } else {
            return "+\(totalSeconds) sec"
        }
    }
}

#Preview {
    TimerView(remainingSeconds: 60)
}
