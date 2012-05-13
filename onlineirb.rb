require 'sinatra'
require 'stringio'
require 'cgi'

__binding__ = binding


get '/run' do
  sio = StringIO.new
  
  code = CGI.unescapeHTML(params[:code])

  if code[-1] == '\\'
    CODES += code[0..-2] + "\n "
    return nil
  else
    if defined? CODES
      CODES += code
    else
      CODES = code
    end
  end
  
  begin
    old_stdout, $stdout = $stdout, sio
    ret = __binding__.eval(CODES, "IRB", 0)
  rescue Exception => e
    ret = e.message
    ret += e.backtrace.inspect
  ensure
    CODES.clear
    $stdout = old_stdout # restore stdout
  end
  
  if ret
    ret = ret.inspect + "\n" + sio.string
  else
    ret = sio.string
  end
  ret
end

get '/' do
  erb :index
end