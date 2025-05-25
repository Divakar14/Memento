//
//  ContentView.swift
//  Memento
//
//  Created by Divakar T R on 21/05/25.
//

import SwiftUI

struct ContentView: View {
    
    @Namespace private var namespace
    @State private var showLaunchScreen = true
    @State private var animateTransition: Bool = false
    
    var body: some View {
        ZStack {
            if showLaunchScreen {
                SplashScreen(animationNamespace: namespace, animateTransition: animateTransition)
            } else {
//                LoginScreen(animationNamespace: namespace)
                MementoTabView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    animateTransition = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        showLaunchScreen = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
