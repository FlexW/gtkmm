# NMake Makefile portion for enabling features for Windows builds

# These are the base minimum libraries required for building gtkmm.
BASE_INCLUDES =	/I$(PREFIX)\include

# Please do not change anything beneath this line unless maintaining the NMake Makefiles

# NMake Options
SAVED_OPTIONS = CFG^=$(CFG)

!ifdef DISABLE_DEPRECATED
SAVED_OPTIONS = $(SAVED_OPTIONS) DISABLE_DEPRECATED^=$(DISABLE_DEPRECATED)
!endif

# Debug/Release builds
!if "$(CFG)" == "debug" || "$(CFG)" == "Debug"
DEBUG_SUFFIX = -d
!else
DEBUG_SUFFIX =
!endif

# Dependencies

GLIB_API_VERSION = 2.0
ATK_API_VERSION = 1.0
PANGO_API_VERSION = 1.0
GDK_PIXBUF_API_VERSION = 2.0
GTK_API_VERSION = 3

LIBSIGC_MAJOR_VERSION = 2
LIBSIGC_MINOR_VERSION = 0
CAIROMM_MAJOR_VERSION = 1
CAIROMM_MINOR_VERSION = 0
GLIBMM_MAJOR_VERSION = 2
GLIBMM_MINOR_VERSION = 4
ATKMM_MAJOR_VERSION = 1
ATKMM_MINOR_VERSION = 6
PANGOMM_MAJOR_VERSION = 1
PANGOMM_MINOR_VERSION = 4

GTKMM_MAJOR_VERSION = 3
GTKMM_MINOR_VERSION = 0

GTKMM_CXX_INCLUDES =	\
	/I$(PREFIX)\include\pangomm-$(PANGOMM_MAJOR_VERSION).$(PANGOMM_MINOR_VERSION)	\
	/I$(PREFIX)\lib\pangomm-$(PANGOMM_MAJOR_VERSION).$(PANGOMM_MINOR_VERSION)\include	\
	/I$(PREFIX)\include\atkmm-$(ATKMM_MAJOR_VERSION).$(ATKMM_MINOR_VERSION)	\
	/I$(PREFIX)\lib\atkmm-$(ATKMM_MAJOR_VERSION).$(ATKMM_MINOR_VERSION)\include	\
	/I$(PREFIX)\include\giomm-$(GLIBMM_MAJOR_VERSION).$(GLIBMM_MINOR_VERSION)	\
	/I$(PREFIX)\lib\giomm-$(GLIBMM_MAJOR_VERSION).$(GLIBMM_MINOR_VERSION)\include	\
	/I$(PREFIX)\include\glibmm-$(GLIBMM_MAJOR_VERSION).$(GLIBMM_MINOR_VERSION)	\
	/I$(PREFIX)\lib\glibmm-$(GLIBMM_MAJOR_VERSION).$(GLIBMM_MINOR_VERSION)\include	\
	/I$(PREFIX)\include\cairomm-$(CAIROMM_MAJOR_VERSION).$(CAIROMM_MINOR_VERSION)	\
	/I$(PREFIX)\lib\cairomm-$(CAIROMM_MAJOR_VERSION).$(CAIROMM_MINOR_VERSION)\include	\
	/I$(PREFIX)\include\sigc++-$(LIBSIGC_MAJOR_VERSION).$(LIBSIGC_MINOR_VERSION)	\
	/I$(PREFIX)\lib\sigc++-$(LIBSIGC_MAJOR_VERSION).$(LIBSIGC_MINOR_VERSION)\include

GTKMM_C_INCLUDES =	\
	/I$(PREFIX)\include\gtk-$(GTK_API_VERSION).0	\
	/I$(PREFIX)\include\gdk-pixbuf-$(GDK_PIXBUF_API_VERSION)	\
	/I$(PREFIX)\include\atk-$(ATK_API_VERSION)	\
	/I$(PREFIX)\include\pango-$(PANGO_API_VERSION)	\
	/I$(PREFIX)\include\glib-$(GLIB_API_VERSION)	\
	/I$(PREFIX)\lib\glib-$(GLIB_API_VERSION)\include

GTKMM_INCLUDES =	\
	$(GTKMM_CXX_INCLUDES)	\
	$(GTKMM_C_INCLUDES)

GOBJECT_LIBS = gobject-$(GLIB_API_VERSION).lib gmodule-$(GLIB_API_VERSION).lib glib-$(GLIB_API_VERSION).lib
GIO_LIBS = gio-$(GLIB_API_VERSION).lib $(GOBJECT_LIBS)

ATK_LIB = atk-$(ATK_API_VERSION).lib
CAIRO_LIBS = cairo-gobject.lib cairo.lib
EPOXY_LIB = epoxy.lib
GDK_PIXBUF_LIB = gdk_pixbuf-$(GDK_PIXBUF_API_VERSION).lib
GTK_LIBS = gtk-$(GTK_API_VERSION).0.lib gdk-$(GTK_API_VERSION).0.lib
PANGO_LIBS = pangocairo-$(PANGO_API_VERSION).lib pango-$(PANGO_API_VERSION).lib

GTKMM_LIBS_C_BASE =	\
	$(GDK_PIXBUF_LIB)	\
	$(GIO_LIBS)	\
	$(CAIRO_LIBS)

GDKMM_LIBS_C = \
	$(GTK_LIBS)	\
	$(GTKMM_LIBS_C_BASE)

GDKMM_LIBS_CXX =	\
	$(GIOMM_LIB)	\
	$(GLIBMM_LIB)	\
	$(CAIROMM_LIB)	\
	$(LIBSIGC_LIB)

GTKMM_LIBS_C =	\
	$(GTK_LIBS)	\
	$(PANGO_LIBS)	\
	$(ATK_LIB)	\
	$(GTKMM_LIBS_C_BASE)

GDKMM_DEP_LIBS = $(GDKMM_LIBS_CXX) $(GDKMM_LIBS_C)

GTKMM_DEP_LIBS =	\
	$(ATKMM_LIB)	\
	$(PANGOMM_LIB)	\
	$(GDKMM_LIBS_CXX)	\
	$(GTKMM_LIBS_C)

GTKMM_DEMO_DEP_LIBS = $(GTKMM_DEP_LIBS) $(EPOXY_LIB)

# CXXFLAGS
GDKMM_BASE_CFLAGS =		\
	/I..\gdk /I.\gdkmm	\
	/wd4530			\
	/FImsvc_recommended_pragmas.h

GTKMM_BASE_CFLAGS =		\
	/I..\gtk /I.\gtkmm	\
	/wd4250				\
	$(GDKMM_BASE_CFLAGS)

LIBGDKMM_CFLAGS =	\
	/DGDKMM_BUILD	\
	$(GDKMM_BASE_CFLAGS)	\
	$(GTKMM_INCLUDES)

LIBGTKMM_CFLAGS =	\
	/DGTKMM_BUILD	\
	$(GTKMM_BASE_CFLAGS)	\
	$(GTKMM_INCLUDES)

GTKMM_DEMO_CFLAGS =	\
	/wd4275	\
	$(GTKMM_BASE_CFLAGS)	\
	$(GTKMM_INCLUDES)

# We build gdkmm-vc$(PDBVER)0-$(GTKMM_MAJOR_VERSION)_$(GTKMM_MINOR_VERSION).dll or
#          gdkmm-vc$(PDBVER)0-d-$(GTKMM_MAJOR_VERSION)_$(GTKMM_MINOR_VERSION).dll at least
#          gtkmm-vc$(PDBVER)0-$(GTKMM_MAJOR_VERSION)_$(GTKMM_MINOR_VERSION).dll or
#          gtkmm-vc$(PDBVER)0-d-$(GTKMM_MAJOR_VERSION)_$(GTKMM_MINOR_VERSION).dll at least

LIBSIGC_LIBNAME = sigc-vc$(PDBVER)0$(DEBUG_SUFFIX)-$(LIBSIGC_MAJOR_VERSION)_$(LIBSIGC_MINOR_VERSION)

LIBSIGC_DLL = $(LIBSIGC_LIBNAME).dll
LIBSIGC_LIB = $(LIBSIGC_LIBNAME).lib

GLIBMM_LIBNAME = glibmm-vc$(PDBVER)0$(DEBUG_SUFFIX)-$(GLIBMM_MAJOR_VERSION)_$(GLIBMM_MINOR_VERSION)

GLIBMM_DLL = $(GLIBMM_LIBNAME).dll
GLIBMM_LIB = $(GLIBMM_LIBNAME).lib

GIOMM_LIBNAME = giomm-vc$(PDBVER)0$(DEBUG_SUFFIX)-$(GLIBMM_MAJOR_VERSION)_$(GLIBMM_MINOR_VERSION)

GIOMM_DLL = $(GIOMM_LIBNAME).dll
GIOMM_LIB = $(GIOMM_LIBNAME).lib

CAIROMM_LIBNAME = cairomm-vc$(PDBVER)0$(DEBUG_SUFFIX)-$(CAIROMM_MAJOR_VERSION)_$(CAIROMM_MINOR_VERSION)

CAIROMM_DLL = $(CAIROMM_LIBNAME).dll
CAIROMM_LIB = $(CAIROMM_LIBNAME).lib

ATKMM_LIBNAME = atkmm-vc$(PDBVER)0$(DEBUG_SUFFIX)-$(ATKMM_MAJOR_VERSION)_$(ATKMM_MINOR_VERSION)

ATKMM_DLL = $(ATKMM_LIBNAME).dll
ATKMM_LIB = $(ATKMM_LIBNAME).lib

PANGOMM_LIBNAME = pangomm-vc$(PDBVER)0$(DEBUG_SUFFIX)-$(PANGOMM_MAJOR_VERSION)_$(PANGOMM_MINOR_VERSION)

PANGOMM_DLL = $(PANGOMM_LIBNAME).dll
PANGOMM_LIB = $(PANGOMM_LIBNAME).lib

GDKMM_LIBNAME = gdkmm-vc$(PDBVER)0$(DEBUG_SUFFIX)-$(GTKMM_MAJOR_VERSION)_$(GTKMM_MINOR_VERSION)

GDKMM_DLL = $(CFG)\$(PLAT)\$(GDKMM_LIBNAME).dll
GDKMM_LIB = $(CFG)\$(PLAT)\$(GDKMM_LIBNAME).lib

GTKMM_LIBNAME = gtkmm-vc$(PDBVER)0$(DEBUG_SUFFIX)-$(GTKMM_MAJOR_VERSION)_$(GTKMM_MINOR_VERSION)

GTKMM_DLL = $(CFG)\$(PLAT)\$(GTKMM_LIBNAME).dll
GTKMM_LIB = $(CFG)\$(PLAT)\$(GTKMM_LIBNAME).lib

GTKMM3_DEMO = $(CFG)\$(PLAT)\gtkmm3-demo$(DEBUG_SUFFIX).exe

TARGETS = $(GTKMM_LIB)

!if $(VSVER) > 12
TARGETS = $(TARGETS) $(GTKMM3_DEMO)
!else
!message gtkmm3-demo.exe built only on Visual Studio 2015 or later.
!endif


GENDEF = $(CFG)\$(PLAT)\gendef.exe

GDKMM_INT_GENERATED_SOURCES = $(gdkmm_files_any_hg:.hg=.cc)
GDKMM_INT_GENERATED_HEADERS = $(gdkmm_files_any_hg:.hg=.h)
GDKMM_INT_GENERATED_HEADERS_P = $(gdkmm_files_any_hg:.hg=_p.h)
GTKMM_INT_GENERATED_SOURCES = $(gtkmm_files_any_hg:.hg=.cc)
GTKMM_INT_GENERATED_HEADERS = $(gtkmm_files_any_hg:.hg=.h)
GTKMM_INT_GENERATED_HEADERS_P = $(gtkmm_files_any_hg:.hg=_p.h)
GTKMM_INT_EXTRA_SOURCES = $(gtkmm_files_extra_any_cc)
GTKMM_INT_EXTRA_HEADERS_P = $(gtkmm_files_extra_ph:/=\)

ENABLED_DEPRECATED = no

!ifndef DISABLE_DEPRECATED
GDKMM_INT_GENERATED_SOURCES = $(GDKMM_INT_GENERATED_SOURCES) $(gdkmm_files_deprecated_hg:.hg=.cc)
GTKMM_INT_GENERATED_SOURCES = $(GTKMM_INT_GENERATED_SOURCES) $(gtkmm_files_deprecated_hg:.hg=.cc)
GTKMM_INT_EXTRA_SOURCES = $(GTKMM_INT_EXTRA_SOURCES) $(gtkmm_files_extra_deprecated_cc)
ENABLED_DEPRECATED = yes
!endif

GDKMM_INT_GENERATED_SOURCES = $(GDKMM_INT_GENERATED_SOURCES) wrap_init.cc
GTKMM_INT_GENERATED_SOURCES = $(GTKMM_INT_GENERATED_SOURCES) wrap_init.cc

# Path to glib-compile-resources.exe
!ifndef GLIB_COMPILE_RESOURCES
GLIB_COMPILE_RESOURCES = $(PREFIX)\bin\glib-compile-resources.exe
!endif
