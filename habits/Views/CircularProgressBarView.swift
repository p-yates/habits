//
//  CircularProgressBarView.swift
//  habits
//
//  Created by Paul Y on 2023-11-20.
//

import SwiftUI

struct CircularProgressBarView: View {
    
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.teal.opacity(0.5),
                    lineWidth: 20
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.teal,
                    style: StrokeStyle(
                        lineWidth: 20,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
        .padding()
    }
}

#Preview {
    CircularProgressBarView(progress: 0.8)
}
