//
//  ViewController.swift
//  OryKratos-Raghad'sTest
//
//  Created by raghad zuhdie on 22/05/2024.
//

import UIKit
import WebKit

class OryKratosSignUpViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properities
    var webView: WKWebView!
    var closeButton: UIButton!
    
    
    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Action
    @IBAction func openURL(_ sender: Any) {
        
        webView = WKWebView(frame: self.view.frame)
        self.webView.navigationDelegate = self
        
        self.view.addSubview(webView)
        self.view.bringSubviewToFront(activityIndicator)
        
        // Load the Ory Kratos registration URL
        guard let url =  getOryKratosURL() else { return }
        let request = URLRequest(url: url)
        webView.load(request)

        addCloseButton()
    }
    
    @objc func closeButtonTapped() {
        webView.removeFromSuperview()
    }

    //MARK: - Setup View
    private func addCloseButton() {
        // Add close button
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.frame = CGRect(x: 0, y: 50, width: 100, height: 50)
        webView.addSubview(closeButton)
        
    }
    
   //MARK: - SetupURL
    private func getOryKratosURL() -> URL? {
        if let infoDict = Bundle.main.infoDictionary,
           let apiUrl = infoDict["OryKratosURL"] as? String,
           let url = URL(string: apiUrl) {
            return url
        } else {
            return nil
        }
    }
}

//MARK: - WKNavigationDelegate Methods

extension OryKratosSignUpViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // Show activity indicator when navigation starts
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // Hide activity indicator if navigation fails
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // Hide activity indicator if navigation fails provisionally
        activityIndicator.stopAnimating()
    }
    
    
}
