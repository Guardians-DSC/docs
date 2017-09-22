require 'ascii_binder'
interactor :off
logger device: '/guard.log'
gem_dir = Gem::Specification.find_by_name("ascii_binder").lib_dirs_glob
instance_eval(File.read(File.join(gem_dir, 'ascii_binder/tasks/guards.rb')))
