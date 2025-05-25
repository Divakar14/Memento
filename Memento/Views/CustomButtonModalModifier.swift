//
//  CustomButtonModalModifier.swift
//  Memento
//
//  Created by Divakar T R on 25/05/25.
//

import SwiftUI

struct CustomButtonModalModifier<ModalContent: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    let modalContent: ModalContent
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> ModalContent) {
        self._isPresented = isPresented
        self.modalContent = content()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                Color.primary.opacity(0.7)
                    .ignoresSafeArea(.all)
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isPresented = false
                        }
                    }

                VStack {
                    Spacer()
                    modalContent
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.ultraThinMaterial)
                                .shadow(radius: 10)
                        )
                        .padding()
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .zIndex(1)

            }
        }
        .animation(.spring(response: 0.45, dampingFraction: 0.85), value: isPresented)
    }
    
}

extension View {
    func customModal<ModalContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> ModalContent
    ) -> some View {
        self.modifier(CustomButtonModalModifier(isPresented: isPresented, content: content))
    }
}
