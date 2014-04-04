ENV['RAILS_ENV'] = 'test'

# rails test help
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'minitest/autorun'
require 'rubygems'

# Tests are conducted with health_test as a plugin
environment_file = File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'config', 'environment.rb')

if File.exists?(environment_file) # test as plugin

  require environment_file
  require File.join(File.dirname(__FILE__), '..', 'init')

else
# elsif Rails.version >= '3.0' #tests as gem
  require File.expand_path("../dummy/config/environment.rb",  __FILE__)

# else
#   fail "Testing as a gem not supported on Rails < 3.0. Please test as a plugin instead."

end

require 'rails/test_help'
require 'shoulda'

Rails.application.routes.routes.map do |route|
  puts route.path.spec.to_s
end

# ActiveSupport::TestCase.class_eval do
#   include Shoulda::Context::Assertions
#   include Shoulda::Context::InstanceMethods
# end
# ActiveSupport::TestCase.extend(Shoulda::Context::ClassMethods)

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:", :database => 'health_check_test')

EXAMPLE_SMTP_SETTINGS = {
  :address => "smtp.gmail.com",
  :domain => "test.example.com",
  :port => 587
}

ActionMailer::Base.delivery_method = :test

# Make sure sendmail settings are set to something that is executrable (we wont actually execute it)
sendmail_path = '/usr/sbin/sendmail'
['/bin/true', 'c:/windows/explorer.exe', 'c:/winnt/explorer.exe',
  File.join(Rails.root, 'script', 'about')].each do |f|
  sendmail_path = f if File.executable? f
end

EXAMPLE_SENDMAIL_SETTINGS = {
  :location => sendmail_path,
  :arguments => '--help'
}

def setup_db(version)
  ActiveRecord::Base.connection.initialize_schema_migrations_table
  ActiveRecord::Schema.define(:version => version) do
    create_table :kitchen do |t|
      t.column :owner, :string
      t.column :description, :string
    end
  end if version
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end
