import SwiftUI
import SwiftData
import UIKit
import UniformTypeIdentifiers


@main
struct WebflowApp: App {
	@UIApplicationDelegateAdaptor private var appDelegate: MyAppDelegate
	
	@State private var websiteManager = WebsiteManager()
	@State private var navigationManager = NavigationManager()
	@State private var isPresented: Bool = false
	
	var sharedModelContainer: ModelContainer = {
		let schema = Schema([
			WebsiteModel.self
		])
		let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
		
		do {
			
			return try ModelContainer(for: schema, configurations: [modelConfiguration])
		} catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}()
	
	var body: some Scene {
		WindowGroup {
			WebflowEntryView()
				.frame(minWidth: 900, minHeight: 500)
				.fullScreenCover(item: $websiteManager.selectedWebsite) { website in
					VStack(spacing: 0) {
						EditorToolbar()
						
						Divider()
						
						WebsiteEntryView(website: website)
							.toolbar(.hidden)
					}
					.frame(minWidth: 900, minHeight: 500)
					.preferredColorScheme(.dark)
					.modelContainer(sharedModelContainer)
					.environment(websiteManager)
					.environment(navigationManager)
				}
		}
		
		.modelContainer(sharedModelContainer)
		.environment(websiteManager)
	}
}

class MyAppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		
		return true
	}
	
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
		configuration.delegateClass = MySceneDelegate.self
		return configuration
	}
}

class MySceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
#if targetEnvironment(macCatalyst)
		if let titlebar = windowScene.titlebar {
			titlebar.titleVisibility = .hidden
			titlebar.toolbar = nil
		}
#endif
		
	}
}

struct CustomHTMLDocument: FileDocument {
	var data: Data
	
	static var readableContentTypes: [UTType] { [UTType.websiteModel] }
	
	init(configuration: ReadConfiguration) throws {
		guard let data = configuration.file.regularFileContents
		else {
			throw CocoaError(.fileReadCorruptFile)
		}
		self.data = data
	}
	
	func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
		FileWrapper(regularFileWithContents: data)
	}
}
