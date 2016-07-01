//
//  NetworkError.swift
//  Pods
//
//  Created by 刘伟 on 16/7/1.
//
//

import UIKit

public enum NetworkError {
    case httpError(Int,String)
    case dataError(String)
}
