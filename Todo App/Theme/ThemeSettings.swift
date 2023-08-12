//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Matteo Buompastore on 12/08/23.
//

import SwiftUI
import Combine

class ThemeSettings: ObservableObject {
    
    @AppStorage("Theme") var themeSettings : Int = 0
    
}
