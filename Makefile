
ELM_MAIN = Test
ELM_OUTPUT = elm.js
STATIC = test.html
BROWSER_TARGET = test.html

SOURCE_DIR = src
BUILD_DIR = build

###

ELM_SOURCE = $(SOURCE_DIR)/$(ELM_MAIN).elm
ELM_BUILD = $(BUILD_DIR)/$(ELM_OUTPUT)
STATIC_SOURCES = $(STATIC:%=$(SOURCE_DIR)/%)

###

.PHONY: all open clean clean-build clean-all static elm new

all: $(BUILD_DIR) $(ELM_BUILD) static

new: clean-build all

$(ELM_BUILD): elm

elm:
	elm make --yes --output $(ELM_BUILD) $(ELM_SOURCE)

open:
	xdg-open $(BUILD_DIR)/$(BROWSER_TARGET) 2>/dev/null

static: # : $(BUILD_DIR)/% : $(SOURCE_DIR)/%  $(BUILD_DIR)
	rsync -rpE $(STATIC_SOURCES) $(BUILD_DIR)

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

clean:
	rm -rf elm-stuff

clean-build:
	rm -rf $(BUILD_DIR)
	rm -rf elm-stuff/build-artifacts

clean-all: clean-build clean
