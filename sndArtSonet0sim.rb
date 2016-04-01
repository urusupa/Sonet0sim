#! ruby -Ku
# encoding: utf-8

###############################################################################
# makeSonet0sim.rb
# in:
# out:
# 
###############################################################################

require 'rubygems'
require 'mechanize'
require 'nkf'
require 'fileutils'
require 'date'
require 'common'

begin

	fary = Array.new
	File.open(DATADIR + "sonet0sim.txt") {|f|
		f.each_line {|line|
			fary.push line
		}
	}
	
	connection = Mysql::new(DBHOST, DBUSER, DBPASS , DBSCHEMA)
	connection.charset = "utf8"
	lastconnday = connection.query("SELECT DATA1 FROM M_EAV WHERE CODE = 'Sonet0sim' AND CODEVALUE = '0'")
	lastconnday = lastconnday.fetch_row().join("")
	connection.close
	
	lastconnday = Date.strptime(lastconnday, "%Y/%m/%d")
	nowday = Date.today
	diffday = nowday - lastconnday
	
	lastconnday = lastconnday.strftime("%Y/%m/%d")
	
	if diffday.to_i > 70 then
		result = `SENDMAIL.sh 9 1 "So-net 0sim 最終接続日："#{lastconnday}"\n経過日数："#{diffday.to_i}`
	end

rescue => ex
	APPEND_LOGFILE(ex)
	result = `SENDMAIL.sh 9 1 "So-net 0sim check エラー"`
ensure

end



