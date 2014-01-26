describe "Application 'AeroSKK'" do
  before do
    @app = NSApp
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
end
