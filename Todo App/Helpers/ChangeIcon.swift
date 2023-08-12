//
//  ChangeIcon.swift
//  Todo App
//
//  Created by Matteo Buompastore on 11/08/23.
//

import Foundation
import UIKit

class IconNames: ObservableObject {
    
    /*var iconNames : [String?] = [nil]
    @Published var currentIndex = 0
    
    init() {
        getAlternateIconNames()
        if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    func getAlternateIconNames() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String : Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String : Any] {
            for (_, value) in alternateIcons {
                guard let iconList = value as? Dictionary<String, Any> else {return}
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else {return}
                guard let icon = iconFiles.first else {return}
                
                iconNames.append(icon)
            }
        }
    }*/
    
    static func changerIcon(with icon : String?)  {
        print("Icon chosen")
        UIApplication.shared.setAlternateIconName(icon) { error in
            if error != nil {
                print("Failed to request to update the app's icon: \(String(describing: error?.localizedDescription))")
            } else {
                print("Icon changed to \(String(describing: icon))")
            }
        }
    }
    
}
