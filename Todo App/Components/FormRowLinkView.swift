//
//  FormRowLinkView.swift
//  Todo App
//
//  Created by Matteo Buompastore on 11/08/23.
//

import SwiftUI

struct FormRowLinkView: View {
    
    //MARK: - PROPERTIES
    var icon : String
    var color : Color
    var text : String
    var link : String
    
    //MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(.white)
            } //: ZSTACK
            .frame(width: 36, height: 36, alignment: .center)
            
            if let url = URL(string: link) {
                Link(destination: url) {
                    HStack {
                        Text(text)
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                    }
                }
            } else {
                Text(text)
            }
            Spacer()
            
            

        } //: HSTACK
    }
}


//MARK: - PREVIEW
struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "link", color: .blue, text: "Website", link: "https://swiftuimasterclass.com")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
