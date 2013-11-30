class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow
    buildServer
  end

  def buildWindow
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
  end


  def buildServer
    @connection_name = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @identifier = NSBundle.mainBundle.bundleIdentifier
    @server = IMKServer.alloc.initWithName(@connection_name,
                                           bundleIdentifier: @identifier)
  end
end
