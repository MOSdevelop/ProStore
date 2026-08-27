import Cocoa
import WebKit

@main
class AppDelegate: NSObject, NSApplicationDelegate, WKNavigationDelegate {
    var window: NSWindow?
    var webView: WKWebView?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create window
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1200, height: 800),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )

        window?.center()
        window?.title = "ProStore"
        window?.makeKeyAndOrderFront(nil)

        // Create WebView
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.preferences.setValue(true, forKey: "developerExtrasEnabled")
        
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView?.navigationDelegate = self
        
        window?.contentView = webView

        // Load local HTML
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "Resources") {
            let url = URL(fileURLWithPath: htmlPath)
            webView?.load(URLRequest(url: url))
        } else {
            // Fallback to web version
            let url = URL(string: "https://cdn.jsdelivr.net/gh/MOSdevelop/ProStore@main/apps/prostore-web/index.html")!
            webView?.load(URLRequest(url: url))
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
