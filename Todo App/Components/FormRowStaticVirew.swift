//
//  FormRowStaticVirew.swift
//  Todo App
//
//  Created by Matteo Buompastore on 11/08/23.
//

import SwiftUI

struct FormRowStaticVirew: View {
    
    //MARK: - PROPERTIES
    var icon : String
    var firstText : String
    var secondText : String
    
    //MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.gray)
                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 36, maxHeight: 36, alignment: .center)
            
            Text(firstText)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(secondText)
            
        }
    }
}

//MARK: - PREVIEW
struct FormRowStaticVirew_Previews: PreviewProvider {
    static var previews: some View {
        FormRowStaticVirew(icon: "gear", firstText: "Application", secondText: "Todo")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
