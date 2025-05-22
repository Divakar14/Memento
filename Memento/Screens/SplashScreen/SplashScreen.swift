//
//  ContentView.swift
//  Memento
//
//  Created by Divakar T R on 20/05/25.
//

import SwiftUI

struct SplashScreen: View {
    
    var animationNamespace: Namespace.ID
    @State private var isActive = false
    @State private var logoAnimation = false
    @State private var nameAnimation = false
    var animateTransition: Bool
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack (spacing: 20) {
                Spacer()
                Image("Memento_Logo")
                    .resizable()
                    .frame(width: 187, height: 205)
                    .matchedGeometryEffect(id: "logo", in: animationNamespace)
                    .scaleEffect(logoAnimation ? 1.0 : 0.7)
                    .opacity(animateTransition ? 0 : 1)
                    .animation(.easeInOut(duration: 1.0), value: logoAnimation)
                Text("Memento")
                    .font(.sfPro(32, weight: .medium))
                    .foregroundStyle(.brandSecondary)
                    .matchedGeometryEffect(id: "appName", in: animationNamespace)
                    .offset(y: nameAnimation ? 0 : 20)
                    .opacity(animateTransition ? 0 : 1)
                    .animation(.easeInOut(duration: 1.0), value: nameAnimation)
                Spacer()
            }
            .padding()
            VStack {
                Spacer()
                HStack {
                    Text("Capture")
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 6, height: 6)
                    Text("Organize")
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 6, height: 6)
                    Text("Remember")
                }
                .font(.sfPro(14, weight: .regular))
                .foregroundStyle(.brandHighlight)
                .offset(y: nameAnimation ? 0 : 20)
                .opacity(nameAnimation ? 1.0 : 0.0)
                .animation(.easeInOut(duration: 1.0).delay(0.3), value: nameAnimation)
                .padding(.bottom, 15)
            }
        }
        .onAppear() {
            logoAnimation = true
            nameAnimation = true
        }
    }
}



#Preview {
    @Namespace var namespace
    var animateTransition: Bool = false
    SplashScreen(animationNamespace: namespace, animateTransition: animateTransition)
}
