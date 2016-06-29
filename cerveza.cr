require "option_parser"

username, commit = nil, nil

OptionParser.parse! do |parser|
  parser.banner = "Usage: cerveza [command] [arguments]"
  parser.separator
  parser.separator "Commands:"
  parser.separator "   appeal     Object to the master breakage"
  parser.separator
  parser.separator "Arguments:"
  parser.on("-u HANDLE", "--user=HANDLE", "Your Github username") { |name| username = name }
  parser.on("-c COMMIT", "--commit=COMMIT", "SHA hash of the commit that broke the build") { |sha| commit = sha }
  parser.on("-h", "--help", "Show this help") { puts parser }
end

