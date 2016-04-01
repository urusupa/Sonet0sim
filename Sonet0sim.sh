#!/bin/sh
###############################################################################
# Sonet0sim.sh
# in:
# out:
# return RETCD
###############################################################################

. ${LIB_DIR}/common.sh

###############################################################################
# メイン
###############################################################################
JOBSTART $*

STEPSTART getSonet0sim

EXECRUBY ${RUBY_DIR}/getSonet0sim.rb
echo ${RETCD} >> ${LOGFILE}

STEPEND

STEPSTART makeSonet0sim

EXECRUBY ${RUBY_DIR}/makeSonet0sim.rb
echo ${RETCD} >> ${LOGFILE}

STEPEND

JOBEND
