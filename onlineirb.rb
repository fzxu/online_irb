require 'sinatra'
require 'stringio'
require 'cgi'

__binding__ = binding


get '/run' do
  unless defined? CODES
    CODES = ""
  end
  
  stdo = StringIO.new
  
  code = CGI.unescapeHTML(params[:code])

  if code[-1] == '\\'
    CODES += code[0..-2] + "\n "
    return CODES
  else
    CODES += code
  end
  
  begin
    old_stdout, $stdout = $stdout, stdo
    __binding__.eval(CODES, "IRB", 0)
  rescue Exception => e
    ret = "#{e.message}\n"
    e.backtrace.each do |l|
      ret += "#{l}\n"
    end
    return ret
  ensure
    CODES.clear
    $stdout = old_stdout # restore stdout
  end
  return stdo.string
end

get '/' do
  erb :index
end