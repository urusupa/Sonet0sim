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
require 'common'

begin
	filehdl = File.open(DATADIR + "sonet0sim.txt","w")
	File.open(DATADIR + "sonet0sim_tmp.txt") do |file|
		file.each_line do |line|
			line = line.gsub(/(\s|<dt>|<\/dt>|<dd>|<\/dd>|<dt class="end">|<dd class="end">|<dl class="useConditionDisplay">|<\/dl>)/,"")
			next if line.strip.empty?
			
			filehdl.puts "-" if line == "-"
			filehdl.puts line
		end
	end
	
rescue => ex
	APPEND_LOGFILE(ex)
ensure
	filehdl.close
	
	begin
		File.delete(DATADIR + "sonet0sim_tmp.txt")
	rescue
		APPEND_LOGFILE(ex)
	end
end



