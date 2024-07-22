# Build rules associated with cdc_snitch
# For documentation see
#   https://berkeleylab.github.io/Bedrock/_gen_md/build-tools/cdc_snitch_md.html
# Requires a couple of files checked out from bedrock
#   https://github.com/BerkeleyLab/Bedrock
# and you point the make variable BEDROCK to your clone.

PYTHON = python3
YOSYS = yosys
YOSYS_QUIET = -q
BEDROCK = $(HOME)/lbl/git/bedrock
BUILD_DIR = $(BEDROCK)/build-tools
YOSYS_JSON_OPTION = -DSIMULATE

%_yosys.json: %.v $(BUILD_DIR)/cdc_snitch_proc.ys
	$(YOSYS) --version
	$(YOSYS) $(YOSYS_QUIET) -p "read_verilog $(YOSYS_JSON_OPTION) $(filter %.v, $^); script $(filter %_proc.ys, $^); write_json $@"

%_cdc.txt: $(BUILD_DIR)/cdc_snitch.py %_yosys.json
	$(PYTHON) $^ -o $@

all: top_cdc.txt
top_yosys.json: top_skin.v

clean:
	rm -f top_yosys.json top_cdc.txt
