  namespace :db do
    desc "Generate slugs for users, tags, and shows"
    task :generateSlugs => :environment do
      User.find_each(&:save)
      Show.find_each(&:save)
      Tag.find_each(&:save)
    end
  end
