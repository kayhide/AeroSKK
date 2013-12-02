describe "Application 'AeroSKK'" do
  before do
    @app = NSApplication.sharedApplication
    @delegate = @app.delegate
  end

  it "has no window" do
    @app.windows.size.should == 0
  end

  it "is running" do
    @app.isRunning.should == true
  end

  it 'has bundle' do
    @bundle = NSBundle.mainBundle
    @bundle.infoDictionary['InputMethodServerControllerClass'].should == 'AeroSKKInputController'
  end

  it 'has IMKServer' do
    @delegate.instance_variable_get('@server').should != nil
  end

  describe 'IMKServer' do
    before do
      @server = @delegate.instance_variable_get('@server')
    end

    it 'has bundle with indentifier of AeroSKK' do
      @server.bundle.should == NSBundle.mainBundle
    end

    it 'has proper connection name' do
      @server.bundle.infoDictionary['InputMethodConnectionName'].should == 'AeroSKKConnection'
    end
  end
end
