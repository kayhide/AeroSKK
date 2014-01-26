class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildServer
  end

  def buildServer
    @identifier = NSBundle.mainBundle.bundleIdentifier
    @server = IMKServer.alloc.initWithName(
      NSBundle.mainBundle.infoDictionary['InputMethodConnectionName'],
      bundleIdentifier: @identifier
    )
  end
end
