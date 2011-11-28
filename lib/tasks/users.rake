namespace :profiles do
  namespace :users do
    desc 'Give a user the admin role. Pass id of profile, e.g.: rake "profiles:users:admin[6]"'
    task :admin, [:id] => :environment do |t, args|
      user = Profile.find(args[:id]).user
      user.roles << :admin
      user.save!
      puts "User #{user.profile.name} now has the admin role."
    end
  end
end
