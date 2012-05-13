require 'sinatra'
require "sinatra/json"
require 'stringio'
require 'cgi'

__binding__ = binding

def __sanit_str__(str)
  if str.nil?
    return 'nil'
  end
  str.to_s
end

get '/run' do
  unless defined? CODES
    CODES = ""
  end
  ret = opt = err = nil
  
  stdo = StringIO.new
  
  code = CGI.unescapeHTML(params[:code])

  if code[-1] == '\\'
    CODES += code[0..-2] + "\n "
    return(json :ret => CODES, :err => __sanit_str__(err), :opt => __sanit_str__(opt))
  else
    CODES += code
  end
  
  begin
    old_stdout, $stdout = $stdout, stdo
    ret = __binding__.eval(CODES, "IRB", 0)
  rescue Exception => e
    err = "#{e.message}\n"
    e.backtrace.each do |l|
      err += "#{l}\n"
    end
  ensure
    CODES.clear
    $stdout = old_stdout # restore stdout
  end
  json :ret => __sanit_str__(ret), :err => __sanit_str__(err), :opt => __sanit_str__(stdo.string)
end

get '/' do
  erb :index
end