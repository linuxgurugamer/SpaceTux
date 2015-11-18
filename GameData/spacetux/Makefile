# Makefile

# Name of text file containing version number.
VERSION_NUMBER_FILE=version-number.txt

# Name of text file containing build number.
BUILD_NUMBER_FILE=build-number.txt


AGENCY=spacetux

OBJECTS=CHANGELOG License.txt Agencies/spacetux.cfg Agencies/spacetux.png Agencies/spacetux_sm.png Flags/spacetux_flag.png spacetuxgroup.cfg



help:
	@echo "SpacetuxSA build commands:"
	@echo "make install      to install to release directory"
	@echo "make release      to build a new tarfile"
	@echo "make version      to increment the version and set build to 0"

install:	
	./update.sh install CHANGELOG License.txt Agencies Flags SpacetuxSA.version spacetuxgroup.cfg

release:
	./update.sh release $(OBJECTS)

version:	$(VERSION_NUMBER_FILE) 
	
# Version number file.  Increment if requested
$(VERSION_NUMBER_FILE):	nullfile
	@if ! test -f $(VERSION_NUMBER_FILE); then echo 0 > $(VERSION_NUMBER_FILE); fi
	@echo $$(($$(cat $(VERSION_NUMBER_FILE)) + 1)) > $(VERSION_NUMBER_FILE)
	@echo -1 > $(BUILD_NUMBER_FILE)

nullfile:

# Build number file.  Increment if any object file changes.
$(BUILD_NUMBER_FILE): $(OBJECTS)
	@if ! test -f $(BUILD_NUMBER_FILE); then echo 0 > $(BUILD_NUMBER_FILE); fi
	@echo $$(($$(cat $(BUILD_NUMBER_FILE)) + 1)) > $(BUILD_NUMBER_FILE)

SpacetuxSA.version:
	./update.sh version

mono:
	./update.sh mono
