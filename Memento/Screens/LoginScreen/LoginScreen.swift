//
//  LoginScreen.swift
//  Memento
//
//  Created by Divakar T R on 21/05/25.
//

import SwiftUI

struct LoginScreen: View {
    
    var animationNamespace: Namespace.ID
    @State private var isChecked: Bool = false
    @State private var animateButtons = false
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack (spacing: 20) {
//                Spacer()
                Image("Memento_Logo")
                    .resizable()
                    .frame(width: 187, height: 205)
                    .matchedGeometryEffect(id: "logo", in: animationNamespace)
                Text("Memento")
                    .font(.sfPro(32, weight: .medium))
                    .foregroundStyle(.brandSecondary)
                    .matchedGeometryEffect(id: "appName", in: animationNamespace)
                Text("Capture your tasks, notes, and moments")
                    .frame(width: 200, height: 55)
                    .font(.sfPro(20, weight: .light))
                    .foregroundStyle(.brandSecondary)
                    .opacity(0.6)
                Spacer()
                VStack (spacing: 20) {
                    Spacer()
                    Button {
                        
                    } label: {
                        HStack {
                            Image("Google_Logo")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding(.trailing)
                            Text("Continue with Google")
                                .font(.sfPro(18, weight: .medium))
                                .foregroundStyle(.black)
                        }
                        .frame(width: 300, height: 55)
                        .background(.white)
                        .cornerRadius(10)
                    }
                    .disabled(!isChecked)
                    Button {
                        
                    } label: {
                        HStack {
                            Image("Apple_Logo")
                                .resizable()
                                .frame(width: 20, height: 24)
                                .padding(.trailing)
                            Text("Continue with Apple")
                                .font(.sfPro(18, weight: .medium))
                                .foregroundStyle(.white)
                        }
                        .frame(width: 300, height: 55)
                        .background(.black)
                        .cornerRadius(10)
                    }
                    .disabled(!isChecked)
                    
                    Spacer(minLength: 150)
                }
                .opacity(animateButtons ? 1 : 0)
                .onAppear {
                    withAnimation(.easeIn(duration: 0.3).delay(0.1)) {
                        animateButtons = true
                    }
                }
                .padding()
            }
            .padding()
            VStack (spacing: 30) {
                Spacer()
                HStack {
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    Text("I agree to the Terms & Conditons and Privacy Policy")
                        .font(.sfPro(12, weight: .regular))
                }
                .foregroundStyle(.brandSecondary)
                .onTapGesture {
                    isChecked.toggle()
                }
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
                .padding(.bottom, 15)
            }
        }
    }
}

#Preview {
    @Namespace var namespace
    LoginScreen(animationNamespace: namespace)
}
