//
//  Logging.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import OSLog

var logger = Logging.shared.logger
let bundleIdentifier = Bundle.main.bundleIdentifier!

class Logging {

    static let shared = Logging()

    private init() { }

    static var isEnableLogging = true

    private let disabledLogger = Logger.init(OSLog.disabled)
    private let enabledLogger = Logger(subsystem: bundleIdentifier, category: "global")

    var logger: Logger {
        if Logging.isEnableLogging {

            return enabledLogger
        } else {
            return disabledLogger
        }
    }
}
