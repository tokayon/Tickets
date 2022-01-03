//
//  HeaderView.swift
//  Tickets
//
//  Created by Serge Sinkevych on 1/2/22.
//

import SwiftUI

struct HeaderView: View {
    
    var body: some View {
        HStack(spacing: 20) {
            Text("Date")
                .frame(minWidth: 100, alignment: .center)
            Divider()
            Text("Status")
                .frame(minWidth: 60, alignment: .center)
            Divider()
            Text("PR")
                .frame(minWidth: 80, alignment: .center)
            Divider()
            Text("JIRA")
                .frame(minWidth: 110, alignment: .center)
            Divider()
            Text("Name")
                .frame(minWidth: 200, maxWidth: .infinity, alignment: .center)
        }
        .foregroundColor(.white)
        .font(.system(size: 15, weight: .bold, design: .rounded))
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
