import SwiftUI
import SwiftData

@main
struct WebflowApp: App {
	@UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
	
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
				.fullScreenCover(item: $navigationManager.selectedWebsite) { website in
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
		.commands {
			ReplacementCommands()
			ViewCommands()
		}
		.modelContainer(sharedModelContainer)
		.environment(websiteManager)
		.environment(navigationManager)
	}
}
