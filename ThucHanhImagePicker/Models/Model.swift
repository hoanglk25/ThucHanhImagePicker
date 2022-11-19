//
//  File.swift
//  ThucHanhImagePicker
//
//  Created by Hoàng Đức on 18/11/2022.
//

import Foundation
import UIKit
struct Infomation {
    var imageName: UIImageView?
    var name: String
    var age: String
}

func fetch() -> [Infomation] {
    let infor1 = Infomation(imageName: UIImageView.init(image: UIImage(named: "Image")), name: "Tran Duc Hoang", age: "23")
    return [infor1]
}
