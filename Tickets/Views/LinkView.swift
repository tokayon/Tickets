//
//  LinkView.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import SwiftUI

struct LinkView: View {
    
    var link: String
    let width: CGFloat
    let color: Color
    
    var body: some View {
        HStack {
            if let link = URL(string: link) {
                let title = link.lastPathComponent
                Text(title)
                    .foregroundColor(color)
                    .onTapGesture {
                        NSWorkspace.shared.open(link)
                    }
            } else {
                Text("N/A")
            }
        }
        .frame(width: width)
    }
}

struct LinkView_Previews: PreviewProvider {
    
    static var previews: some View {
        LinkView(link: "https://google.com", width: 120, color: .pink)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
