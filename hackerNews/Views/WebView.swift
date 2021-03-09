//
//  WebView.swift
//  hackerNews
//
//  Created by Patrick Chen on 2021/3/6.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let urlString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let safeURL = urlString {
            if let url = URL(string: safeURL) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
        }
    }
}
