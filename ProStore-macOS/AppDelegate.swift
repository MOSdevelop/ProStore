import Cocoa
import WebKit

@main
class AppDelegate: NSObject, NSApplicationDelegate, WKNavigationDelegate, WKUIDelegate {
    var window: NSWindow?
    var webView: WKWebView?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create main window with custom appearance
        let screenSize = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1400, height: 900)
        
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1400, height: 900),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )

        window?.center()
        window?.title = "ProStore"
        window?.titlebarAppearsTransparent = true
        window?.isOpaque = false
        window?.backgroundColor = NSColor.clear
        window?.makeKeyAndOrderFront(nil)

        // Configure WebView with modern settings
        let webViewConfig = WKWebViewConfiguration()
        webViewConfig.preferences.setValue(true, forKey: "developerExtrasEnabled")
        webViewConfig.preferences.isElementFullscreenEnabled = true
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 1400, height: 900), configuration: webViewConfig)
        webView?.navigationDelegate = self
        webView?.uiDelegate = self
        
        window?.contentView = webView

        // Load HTML from resources
        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "Resources") {
            let url = URL(fileURLWithPath: htmlPath)
            webView?.load(URLRequest(url: url))
        } else {
            // Fallback to jsDelivr CDN
            let url = URL(string: "https://cdn.jsdelivr.net/gh/MOSdevelop/ProStore@main/ProStore-macOS/Resources/index.html")!
            webView?.load(URLRequest(url: url))
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
