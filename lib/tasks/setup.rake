namespace :setup do
	desc "Create Homepage"
  task :create_homepage => :environment do
  	Page.create(:name => "Home", :slug => 'home')
  end

  desc "Create Admin User"
  task :create_user => :environment do
  	User.create(:name => 'Admin', :email => 'admin@staggeredink.com', :password => 'password', :password_confirmation => 'password')
  end

  desc "Create Main Nav"
  task :create_nav => :environment do
  	NavMenu.create(:name => 'Main Navigation', :menu_type => 'main_nav')
  end

  desc "all"
  task :all => [:environment, :create_homepage, :create_user, :create_nav]
end