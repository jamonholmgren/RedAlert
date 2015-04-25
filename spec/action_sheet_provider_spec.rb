describe "RubyMotionQuery" do
  describe "ActionSheetProvider" do

    before do
      @p      = RubyMotionQuery::ActionSheetProvider.new
      @ok     = RubyMotionQuery::AlertAction.new(title: "OK", tag: :ok, style: :default)
      @cancel = RubyMotionQuery::AlertAction.new(title: "Cancel", tag: :cancel, style: :cancel)
      @boom   = RubyMotionQuery::AlertAction.new(title: "Boom!", tag: :boom, style: :destructive)
    end

    it "should prevent nil actions" do
      oops = @p.build(nil) rescue :oops
      oops.should == :oops
    end

    it "should prevent empty actions" do
      oops = @p.build([]) rescue :oops
      oops.should == :oops
    end

    describe "action sheet with ok button" do

      before do
        @p.build [@ok], title: "title"
      end

      it "should have the right title" do
        @p.action_sheet.title.should == "title"
      end

      it "should create a UIActionSheet" do
        @p.action_sheet.class.should == UIActionSheet
      end

      it "should have 1 button" do
        @p.action_sheet.numberOfButtons.should == 1
      end

      it "should have 0 cancel buttons" do
        @p.action_sheet.cancelButtonIndex.should < 0
      end

      it "should have 0 destructive buttons" do
        @p.action_sheet.destructiveButtonIndex.should < 0
      end

      it "should have the right button title" do
        @p.action_sheet.buttonTitleAtIndex(0).should == @ok.title
      end

    end

    describe "action sheet with a cancel button" do

      before do
        @p.build [@cancel], title: "title"
      end

      it "should have 1 button" do
        @p.action_sheet.numberOfButtons.should == 1
      end

      it "should have 1 cancel button" do
        @p.action_sheet.cancelButtonIndex.should == 0
      end

      it "should have 0 destructive buttons" do
        @p.action_sheet.destructiveButtonIndex.should < 0
      end

      it "should have the right button title" do
        @p.action_sheet.buttonTitleAtIndex(0).should == @cancel.title
      end

    end

    describe "action sheet with a destructive button" do

      before do
        @p.build [@boom], title: "title"
      end

      it "should have 1 button" do
        @p.action_sheet.numberOfButtons.should == 1
      end

      it "should have 0 cancel buttons" do
        @p.action_sheet.cancelButtonIndex.should < 0
      end

      it "should have 1 destructive buttons" do
        @p.action_sheet.destructiveButtonIndex.should == 0
      end

      it "should have the right button title" do
        @p.action_sheet.buttonTitleAtIndex(0).should == @boom.title
      end

    end


  end
end
