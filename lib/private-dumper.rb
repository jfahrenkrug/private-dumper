# 4 December 2011
# Framework Dumping utility; requires class-dump
# Inspired by Erica Sadun's DumpFrameworks perl script
#
# by Johannes Fahrenkrug, springenwerk.com

# This command must be in your path.
# http://www.codethecode.com/projects/class-dump/

module PrivateDumper
  module Application

    CLASS_DUMP = 'class-dump' 

    def self.run!(*args)

      if args.size < 2
        puts "Usage: "
        puts "private-dumper <iOS SDK version> <path to headers output directory>"
        puts
        puts "Please provide both the iOS SDK version you want to dump (for example 4.2) and the path to the output directory."
        puts "Example: private-dumper 4.2 ~/Headers"
        puts
        puts "NOTE: You need to have class-dump (http://www.codethecode.com/projects/class-dump/) installed and in your $PATH!"
        return -1
      end

      sdk_version = args[0]


      #sdk_path = "/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator#{sdk_version}.sdk/"
      sdk_path = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator#{sdk_version}.sdk/"
      if !File.exists?(sdk_path)
        puts "The directory #{sdk_path} does not exist. Did you possibly provide an invalid SDK version?"
        return -2
      end

      headers_path = args[1]

      if !File.exists?(headers_path)
        # we will try to create it...
        Dir.mkdir(File.expand_path(headers_path))
      end


      if !File.exists?(headers_path)
        puts "The output directory #{headers_path} does not exist and could not be created."
        return -3
      end

      ["#{sdk_path}System/Library/Frameworks", "#{sdk_path}System/Library/PrivateFrameworks", "#{sdk_path}Developer/Library/Frameworks", "#{sdk_path}Developer/Library/PrivateFrameworks"].each do |frmwk_path|
        puts frmwk_path

        Dir["#{frmwk_path}/**/*.framework"].sort.each do |frmwk|
          frmwk_name = File.basename(frmwk, '.*')
          puts "Framework: #{frmwk_name}"
          cmd = "#{CLASS_DUMP} -H -o #{headers_path}/#{frmwk_name} -s -S #{frmwk}"

          if !system(cmd)
            puts "Command #{cmd} failed with exit code #{$?.exitstatus}"
          else
            # Remove unnecessary imports
            puts "Fixing imports..."
            Dir["#{headers_path}/#{frmwk_name}/*.h"].each do |header|
              # Read...
              lines = []
              File.open(header, 'r') do |header_file| 
                header_file.each_line do |line|
                  if line =~ /#import\s<#{frmwk_name}\/([^\.]*\.h)>/
                    line = %{#import "#{$1}"}
                  end

                  lines << line unless line =~ /#import\s"NSObject\.h"/
                end
              end

              # Write...
              File.open(header, 'w') {|header_file| header_file.puts lines.join("\n")}
            end
          end
        end
      end

      puts "Done."
      return 0
    end

  end
end
