//
//  CopyInClipboard.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 08/03/2025.
//

import UIKit

func copyInClipboard(string: String) {
    UIPasteboard.general.string = string
}
