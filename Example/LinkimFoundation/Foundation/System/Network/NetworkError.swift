//
//  NetworkError.swift
//  Pods
//
//  Created by 刘伟 on 16/7/1.
//
//

import UIKit

enum NetworkErrorType {
    
    case httpError(Int,String)
    
    case dataError(Int,String)
}

