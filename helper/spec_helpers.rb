class SpecHelpers
  attr_reader :browser, :driver

  def initialize sauce_driver
    browser_name = :firefox

    if sauce_driver
      @driver = sauce_driver.driver
    else
      @driver = Selenium::WebDriver.for browser_name
    end

    @browser = driver.browser
    raise 'Browser is nil' unless browser
    # @driver = browser.driver
    raise 'Driver is nil!' unless driver

    # Must call after Protractor.new and not before.
    # AngularWebdriver.install_rspec_helpers

    # Promote SpecHelpers onto RSpec as well.
    context         = ::RSpec::Core::ExampleGroup
    helper_instance = self
    self.class.instance_methods(false).each do |method_symbol|
      context.send(:define_method, method_symbol) do |*args, &block|
        args.length == 0 ? helper_instance.send(method_symbol, &block) :
          helper_instance.send(method_symbol, *args, &block)
      end
    end

    # override stub methods
    # AngularWebdriver.define_page_methods page_module:  ::Page,
    #                                    target_class: context,
    #                                    method:       :define_method,
    #                                    watir:        browser

    # set script timeout for protractor client side javascript
    # https://github.com/angular/protractor/issues/117
    _60_seconds                           = 15
    driver.manage.timeouts.script_timeout = _60_seconds
    # some browsers are slow to load.
    # https://github.com/angular/protractor/blob/6ebc4c3f8b557a56e53e0a1622d1b44b59f5bc04/spec/ciSmokeConf.js#L73
    #
    # Safari does not implement the page load timeout. Invoking it will cause
    # Unknown command: setTimeout
    driver.manage.timeouts.page_load      = _60_seconds unless driver.browser == :safari
    driver.manage.timeouts.implicit_wait  = 0

    # sometimes elements just don't exist even though the page has loaded
    # and wait for angular has succeeded. in these situations, use client wait.
    #
    # implicit wait shouldn't ever be used. client wait is a reliable replacement.
    # driver.set_max_wait 10 # seconds
    # driver.set_max_page_wait 30 # seconds

    # set window size
    driver.manage.window.resize_to 1024, 768
  end

  def driver_quit
    driver.quit rescue nil
  end
end


