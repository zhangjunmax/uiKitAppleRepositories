//
//  String+Date.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation

let dateAndTimeAmPmFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return dateFormatter
}()

let shortDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
}()

extension String {

    var shortDateString: String {
        guard let date = dateAndTimeAmPmFormatter.date(from: self) else {
            return ""
        }

        return shortDateFormatter.string(from: date)
    }
}
