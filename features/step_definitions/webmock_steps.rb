Given(/^the fixture "(.*?)" is available at the URL "(.*?)"$/) do |filename, url|
  stub_request(:get, url).to_return(:body => File.read(File.join(File.dirname(__FILE__), '..', 'fixtures', filename)))
end