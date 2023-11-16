import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
	func makeUIView(context: Context) -> WKWebView {
		let webConfiguration = WKWebViewConfiguration()
		let webView = WKWebView(frame: .zero, configuration: webConfiguration)
		let html: String = """
<ul class="flat-list sr-bar hover" id="sr-bar">    <li><span class="separator">- </span><a href="https://www.reddit.com/r/AskReddit/" class="choice">AskReddit</a></li>
	<li><span class="separator">- </span><a href="https://www.reddit.com/r/news/" class="choice">news</a></li>
	<li><span class="separator">- </span><a href="https://www.reddit.com/r/funny/" class="choice">funny</a></li>
	<li><span class="separator">- </span><a href="https://www.reddit.com/r/worldnews/" class="choice">worldnews</a></li>
	<li><span class="separator">- </span><a href="https://www.reddit.com/r/gaming/" class="choice">gaming</a></li>
</ul>
"""
		webView.loadHTMLString(html, baseURL: nil)
		//		webView.load(myRequest)
		return webView
	}
	
	func updateUIView(_ uiView: WKWebView, context: Context) {
		
	}
}

#Preview {
    WebView()
}
