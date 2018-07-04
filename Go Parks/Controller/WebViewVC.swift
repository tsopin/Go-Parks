//
//  WebViewVC.swift
//  Go Parks
//
//  Created by Timofei Sopin on 2018-05-17.
//  Copyright © 2018 Timofei Sopin. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, UIWebViewDelegate {
  
  @IBOutlet weak private var progressBar: UIProgressView!
  @IBOutlet weak private var loadingPage: UIActivityIndicatorView!
  @IBOutlet weak private var webView: WKWebView!
  @IBOutlet weak private var refreshBtn: UIBarButtonItem!
  
  var receivedUrl : String?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    progressBar.isHidden = false
    loadingPage.hidesWhenStopped = true
    loadingPage.startAnimating()
    refreshBtn.isEnabled = false
    
    let url = URL(string: receivedUrl!)
    let request = URLRequest(url: url!)
    
    webView.load(request)
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      self.progressBar.progress = Float(self.webView.estimatedProgress)
    }
    if self.webView.estimatedProgress == 1.0 {
      loadingPage.stopAnimating()
      refreshBtn.isEnabled = true
      progressBar.isHidden = true
    }
  }
  
  @IBAction private func refreshPressed(_ sender: Any) {
    webView.reload()
  }
  
  @IBAction private func dismissButton(_ sender: Any) {
    dismissVC()
  }
  
  @IBAction private func edgeGesture(_ sender: Any) {
    dismissVC()
  }
  
  func dismissVC() {
    DispatchQueue.main.async {
      self.navigationController?.popViewController(animated: true)
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  deinit {}
}
