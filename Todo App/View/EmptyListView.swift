//
//  EmptyListView.swift
//  Todo App
//
//  Created by Matteo Buompastore on 11/08/23.
//

import SwiftUI

struct EmptyListView: View {
    
    //MARK: - PROPERTIES
    @State private var isAnimated : Bool = false
    private let images : [String] = ["illustration-no1", "illustration-no2", "illustration-no3"]
    private let tips : [String] = [
        "Use your time wisely",
        "Slow and steady wins the race",
        "Keep it short and sweet",
        "Put hard tasks first",
        "Reward yourself after work",
        "Collect tasks ahead of time",
        "Each night schedule for tomorrow",
    ]
    
    //THEME
    @EnvironmentObject private var theme : ThemeSettings
    private let themes : [Theme] = themeData
    
    private var chosenTip : String {
        return tips.randomElement()!
    }
    
    private var chosenImage : String {
        return images.randomElement()!
    }
    
    //MARK: - BODY
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image(chosenImage)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .foregroundColor(themes[theme.themeSettings].themeColor)
                    .layoutPriority(1)
                
                Text(chosenTip)
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(themes[theme.themeSettings].themeColor)
            } //: VSTACK
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0.5)
            .offset(y: isAnimated ? 0 : -50)
            .animation(.easeOut(duration: 1.5), value: isAnimated)
            .onAppear {
                isAnimated = true
            }
            
        } //: ZSTACK
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .ignoresSafeArea()
    }
}


//MARK: - PREVIEW
struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
            .previewLayout(.sizeThatFits)
            .environmentObject(ThemeSettings())
    }
}
