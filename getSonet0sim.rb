#! ruby -Ku
# encoding: utf-8

###############################################################################
# getSonet0sim.rb
# in:
# out:
# 
###############################################################################

require 'rubygems'
require 'mechanize'
require 'nkf'
require 'fileutils'
require 'common'

###############################################################################
# メイン
###############################################################################

begin
	agent = Mechanize.new
	agent.follow_meta_refresh = true
	page = agent.get('https://www.so-net.ne.jp/retail/u/userMenu/')

	page = page.form_with(:action => '/retail/u/login?realm=/retail/retail_userweb') do |form|
		formdata = {
			:mail => SonetUSER,
			:password => SonetPASS,
		}
		form.field_with(:name => 'IDToken1').value = formdata[:mail]
		form.field_with(:name => 'IDToken2').value = formdata[:password]
	end.submit

	page = page.form_with(:name => 'userUsageActionForm') do |form|
	end.submit
	page = page.at('.useConditionDisplay')

	open(DATADIR + "sonet0sim_tmp.txt", "w") {|f| f.write page}

rescue => ex
	APPEND_LOGFILE(ex)

end


