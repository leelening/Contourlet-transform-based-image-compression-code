# Makefile for examples and regression tests

SUBDIRS := $(subst ./,,$(shell find . -type d -name 'test_*'))

default: all

all clean:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $@ || exit 1; \
	done

# nice colored regression check
check:
	@for dir in $(SUBDIRS); do                    \
	  echo -en "\\033[1m\\033[34m$$dir\\033[0m";  \
	  if $(MAKE) -C $$dir $@ &> /dev/null; then   \
	    echo -en "\\033[300C\\033[20D";           \
	    echo -e "\\033[1;32m[ PASSED ]\\033[0m";  \
	  else                                        \
	    echo -en "\\033[300C\\033[20D";           \
	    echo -e "\\033[1;31m[ FAILED ]\\033[0m";  \
	    $(MAKE) --no-print-directory -C $$dir $@; \
	  fi;                                         \
	done
