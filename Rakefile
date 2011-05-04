require 'bundler'
require 'spec/rake/spectask'

Bundler::GemHelper.install_tasks

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = Dir.glob('spec/**/*_spec.rb')
  t.spec_opts << '--format specdoc'
  t.rcov = true
end