#!/bin/bash
source /software/scripts/init_synopsys_64.18
vcd2saif -input ../vcd/IIR_filter_syn.vcd -output ../saif/IIR_filter_syn.saif
