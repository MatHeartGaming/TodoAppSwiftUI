//
//  CustomAlertDialog.swift
//  Todo App
//
//  Created by Matteo Buompastore on 11/08/23.
//

import SwiftUI

struct CustomAlertDialog: View {
    
    //MARK: - PROPERTIES
    var title = "Title"
    var message = "Message..."
    var backgroundColor : Color?
    var titleColor : Color?
    var messageColor : Color?
    
    //MARK: - BODY
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(titleColor ?? .red)
                .lineLimit(1)
                .multilineTextAlignment(.center)
            
            Text(message)
                .font(.system(size: 22, weight: .medium, design: .rounded))
                .foregroundColor(messageColor ?? .black)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
        } //: VSTACK
        .frame(minWidth: 320, maxWidth: 380, minHeight: 160, maxHeight: 220)
        .background(backgroundColor ?? .green)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}


//MARK: - PREVIEW
struct CustomAlertDialog_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertDialog()
            .previewLayout(.sizeThatFits)
            .padding(8)
    }
}
