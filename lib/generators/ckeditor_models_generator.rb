require 'rails/generators'

class CkeditorModelsGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  class_option :backend, :type => :string, :default => 'paperclip',
                         :desc => "Backend processor for upload support"
                        
  def self.source_root
    @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates', 'models/'))
  end

  def self.next_migration_number(dirname)
    Time.now.strftime("%Y%m%d%H%M%S")
  end
  
  def create_models
    template "#{generator_dir}/asset.rb",
             File.join('app/models', ckeditor_dir, "asset.rb")
    
    template "#{generator_dir}/picture.rb",
             File.join('app/models', ckeditor_dir, "picture.rb")
    
    template "#{generator_dir}/attachment_file.rb",
             File.join('app/models', ckeditor_dir, "attachment_file.rb")
  end
  
  def create_migration
    migration_template "#{generator_dir}/migration.rb", File.join('db/migrate', "create_ckeditor_assets.rb")
  end
  
  protected
    
    def ckeditor_dir
      'ckeditor'
    end
    
    def generator_dir
      options[:backend] || "paperclip"
    end
end
