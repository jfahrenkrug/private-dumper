# 4 December 2011
# Framework Dumping utility; requires class-dump
# Inspired by Erica Sadun's DumpFrameworks perl script
#
# by Johannes Fahrenkrug, springenwerk.com
STDOUT.sync = true

# This command must be in your path.
# http://www.codethecode.com/projects/class-dump/
CLASS_DUMP = 'class-dump' 

if ARGV.size < 2
  puts "Usage: "
  puts "ruby private-dumper <iOS SDK version> <path to headers output directory>"
  puts
  puts "Please provide both the iOS SDK version you want to dump (for example 4.2) and the path to the output directory."
  puts "Example: ruby private-dumper.rb 4.2 ~/Headers"
  exit -1
end

SDK_VERSION = ARGV[0]

SDK_PATH = "/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator#{SDK_VERSION}.sdk/System/Library/"

if !File.exists?(SDK_PATH)
  puts "The directory #{SDK_PATH} does not exist. Did you possibly provide an invalid SDK version?"
  exit -1
end

HEADERS_PATH = ARGV[1]

if !File.exists?(HEADERS_PATH)
  # we will try to create it...
  Dir.mkdir(File.expand_path(HEADERS_PATH))
end


if !File.exists?(HEADERS_PATH)
  puts "The output directory #{HEADERS_PATH} does not exist and could not be created."
  exit -1
end

["#{SDK_PATH}Frameworks", "#{SDK_PATH}PrivateFrameworks"].each do |frmwk_path|
  puts frmwk_path

  Dir["#{frmwk_path}/**/*.framework"].sort.each do |frmwk|
    frmwk_name = File.basename(frmwk, '.*')
    puts "Framework: #{frmwk_name}"
    cmd = "#{CLASS_DUMP} -H -o #{HEADERS_PATH}/#{frmwk_name} -s -S #{frmwk}"

    if !system(cmd)
      puts "Command #{cmd} failed with exit code #{$?.exitstatus}"
    end
  end
end

# Remove unnecessary imports
puts "Removing unnecessary imports..."
Dir["#{HEADERS_PATH}/**/*.h"].each do |header|
  # Read...
  lines = []
  File.open(header, 'r') do |header_file| 
    header_file.each_line do |line|
      lines << line unless line =~ /#import "NSObject\.h"/
    end
  end

  # Write...
  File.open(header, 'w') {|header_file| header_file.puts lines.join("\n")}
end
puts "Done."

