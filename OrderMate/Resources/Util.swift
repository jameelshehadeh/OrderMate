//
//  Util.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import Foundation

class Util {
    
    
    class func formatDate(timeStamp: TimeInterval) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        let date = Date(timeIntervalSince1970: timeStamp)
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    
}
