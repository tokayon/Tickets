//
//  FlexibleSheet.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import SwiftUI

struct FlexibleSheet<Content: View>: View {
    
    @Binding var show: Bool
    
    let content: () -> Content
    
    init(show: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._show = show
        self.content = content
    }
    
    var body: some View {
        ZStack {
            content()
                .background(Color(.systemGray))
                .edgesIgnoringSafeArea(.all)
        }
        .animation(.easeOut(duration: 0.2))
        .offset(y: show ? 0 : NSScreen.main?.frame.height ?? 0)
    }
}
