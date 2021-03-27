//
//  LoginController.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 25.03.2021.
//

import UIKit
import WebKit
import Alamofire

class VKLoginController: UIViewController {

    static let token = Session.shared.token
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7802743"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.130")
        ]
        let request = URLRequest(url: components.url!)
        webView.load(request)
        WKWebView.clean()
    }
}
    
    extension VKLoginController: WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            guard navigationResponse.response.url?.path == "/blank.html",
            let fragment = navigationResponse.response.url?.fragment else {
                decisionHandler(.allow)
                return
            }
            
            let params = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, param in
                    var dict = result
                    let key = param[0]
                    let value = param[1]
                    dict[key] = value
                    return dict
                
        }
    
            print(params)
            Session.shared.token = params["access_token"] ?? ""
            Session.shared.userId = params["user_id"] ?? ""
            NetworkService.loadGroups(token: VKLoginController.token)
            NetworkService.loadFriends(token: VKLoginController.token)
            NetworkService.loadFriendsPhoto(token: VKLoginController.token)
            NetworkService.loadGroupSearch(token: VKLoginController.token)
            
            performSegue(withIdentifier: "ShowMainViewController", sender: nil)
            decisionHandler(.cancel)
    }
    

}
extension WKWebView {
    class func clean() {
        guard #available(iOS 9.0, *) else {return}

        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }

}


