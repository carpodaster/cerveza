require "option_parser"

arguments = {} of String => String | Nil

homerc = File.expand_path "~/.cervezarc"
arguments.merge! Cerveza::ConfigFileParser.new(homerc).parse if File.exists? homerc

OptionParser.parse! do |parser|
  parser.banner = "Usage: cerveza [command] [arguments]"
  parser.separator
  parser.separator "Commands:"
  parser.separator "   appeal     Object to the master breakage"
  parser.separator
  parser.separator "Arguments:"
  parser.on("-u HANDLE", "--user=HANDLE", "Your Github username") { |name| arguments["username"] = name }
  parser.on("-c COMMIT", "--commit=COMMIT", "SHA hash of the commit that broke the build") { |sha| arguments["commit"] = sha }
  parser.on("-h", "--help", "Show this help") { puts parser }
end

module Cerveza
  class ConfigFileParser
    getter :config
    def initialize(@file : String)
      @config = File.read_lines @file
    end

    def parse
      @config.each_with_object({} of String => String) do |line, hash|
        key, value = line.to_s.strip.split("=", 2)
        hash[key] = value
      end
    end
  end
end

STDERR.puts "DEBUG: extracted runtime arguments:"
STDERR.puts arguments.inspect

