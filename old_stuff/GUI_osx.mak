#
# glBSPX Makefile for FLTK under MacOS X
#

MAIN=src
SYSDIR=gui
SRC_DIR=glbsp

FLTK_PREFIX=../fltk-1.1.6
FLTK_CFLAGS=-I$(FLTK_PREFIX) -I$(FLTK_PREFIX)/zlib
FLTK_LIBS=-L$(FLTK_PREFIX)/lib -lfltk_images -lfltk_png -lfltk_z -lfltk_jpeg -lfltk

PROGNAME=$(SYSDIR)/glBSPX.app/Contents/glBSPX

CC=gcc
CXX=g++
CFLAGS=-O2 -Wall -DGLBSP_GUI -DMACOSX -DINLINE_G=inline $(FLTK_CFLAGS)
CXXFLAGS=$(CFLAGS)
LDFLAGS=-framework Carbon -framework ApplicationServices -Wl,-x
LIBS=-lm $(FLTK_LIBS)
REZ=/Developer/Tools/Rez -t APPL

OBJS=$(SYSDIR)/main.o     \
     $(SYSDIR)/about.o    \
     $(SYSDIR)/book.o     \
     $(SYSDIR)/booktext.o \
     $(SYSDIR)/cookie.o   \
     $(SYSDIR)/dialog.o   \
     $(SYSDIR)/files.o    \
     $(SYSDIR)/helper.o   \
     $(SYSDIR)/images.o   \
     $(SYSDIR)/license.o  \
     $(SYSDIR)/menu.o     \
     $(SYSDIR)/options.o  \
     $(SYSDIR)/prefs.o    \
     $(SYSDIR)/progress.o \
     $(SYSDIR)/textbox.o  \
     $(SYSDIR)/window.o   \
     \
     $(MAIN)/analyze.o    \
     $(MAIN)/blockmap.o   \
     $(MAIN)/glbsp.o      \
     $(MAIN)/level.o      \
     $(MAIN)/node.o       \
     $(MAIN)/reject.o     \
     $(MAIN)/seg.o        \
     $(MAIN)/system.o     \
     $(MAIN)/util.o       \
     $(MAIN)/wad.o


# ----- TARGETS ------------------------------------------------------

all:    $(PROGNAME)

clean:
	rm -f $(PROGNAME) $(MAIN)/*.o $(SYSDIR)/*.o
	rm -f $(MAIN)/core $(SYSDIR)/core $(MAIN)/glbsp.txt

localclean:
	rm -f $(PROGNAME) $(SYSDIR)/*.o $(SYSDIR)/core

$(PROGNAME): $(OBJS)
	$(CXX) $(CFLAGS) $(OBJS) -o $(PROGNAME) $(LDFLAGS) $(LIBS)
## ??	$(REZ) -o $(PROGNAME) glBSPX.r

bin: all
	strip --strip-unneeded $(PROGNAME)
	cat $(MAIN)/README.txt $(MAIN)/USAGE.txt $(MAIN)/CHANGES.txt > $(MAIN)/glbsp.txt

.PHONY: all clean localclean bin

