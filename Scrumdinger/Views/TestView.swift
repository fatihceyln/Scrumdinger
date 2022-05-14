//
//  TestView.swift
//  Scrumdinger
//
//  Created by Fatih Kilit on 13.05.2022.
//

import SwiftUI

enum ActiveButton {
    case start, pause, stop
}

struct TestView: View {
    
    let colors: [Color] = [.red, .blue, .pink, .orange, .cyan, .purple]
    @State private var backgroundColor: Color = .clear
    @State private var timer: Timer?
    @State private var count: Double = 0
    @State private var timerIsActive: Bool = false
    @State private var activeButton: ActiveButton = .stop
    
    var body: some View {
        ZStack(alignment: .bottom) {
            backgroundColor.ignoresSafeArea()
            
            ZStack() {
                Text(count.description)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack {
                
                Button("START") {
                    guard !timerIsActive else {return}
                    activeButton = .start
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                        DispatchQueue.main.async {
                            count += 1
                            withAnimation {
                                backgroundColor = colors.randomElement() ?? .clear
                            }
                        }
                    })
                    timerIsActive = true
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .disabled(activeButton != .start ? false : true)
                .opacity(activeButton != .start ? 1 : 0.7)
                
                
                Spacer()
                
                Button("PAUSE") {
                    activeButton = .pause
                    timer?.invalidate()
                    timerIsActive = false
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .disabled(activeButton == .start ? false : true)
                .opacity(activeButton == .start ? 1.0 : 0.7)
                
                Spacer()
                
                Button("STOP") {
                    activeButton = .stop
                    timer?.invalidate()
                    timerIsActive = false
                    count = 0
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .disabled(activeButton != .stop ? false : true)
                .opacity(activeButton != .stop ? 1.0 : 0.7)
                
            }
            .font(.title2)
            .foregroundColor(.black)
            .padding(16)
            .background(.red, in: RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            .background(
                Color.white
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 0)
            )
            
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
