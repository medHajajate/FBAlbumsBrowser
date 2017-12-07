//
//  Log.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/7/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import Foundation


import Foundation

class Log {
    class func msg(message: String,
                   functionName:  String = #function, fileNameWithPath: NSString = #file, lineNumber: Int = #line ) {
        #if DEBUG
            let output = "⭐️ \(NSDate()) [\(fileNameWithPath.lastPathComponent), \(functionName), line \(lineNumber)] \(message)"
            print(output)
        #endif
    }
    
    class func error(error: String,
                     functionName:  String = #function, fileNameWithPath: String = #file, lineNumber: Int = #line ) {
        #if DEBUG
            let output = "‼️ \(NSDate()) [\(functionName), line \(lineNumber)] \(error)"
            print(output)
        #endif
    }
    
    
}
