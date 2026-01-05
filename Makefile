DIR_OBJ := build

CC := gcc
CPP:= g++
AS := as
CP := objcopy
SZ := size

DEBUG := 1 # TODO: release version!
FLAGS_C_COMMON := 
FLAGS_C_COMMON += -gdwarf-3 -fdata-sections -ffunction-sections
FLAGS_C_COMMON += -Ofast
FLAGS_C_COMMON += -ffast-math -funsafe-math-optimizations
ifeq ($(DEBUG), 1)
FLAGS_C_COMMON += -DDEBUG=1
endif

#################################################################################3

TARGET_PE := $(DIR_OBJ)/test
.DEFAULT_GOAL := $(TARGET_PE)

DIR_APP := m-osc
DIR_HWPANELEMU := libs/hwPanelEmulator
DIR_MBWMIDI := libs/mbwmidi
DIR_MINIMALGRAPHICS := libs/minimalgraphics

FLAGS_C_HWPANELEMU_CONFIG := $(addprefix -I,$(DIR_APP) $(DIR_MBWMIDI) $(DIR_MINIMALGRAPHICS))
FLAGS_C_HWPANELEMU_EXPORT := $(shell sdl2-config --cflags)
FLAGS_C_COMMON += $(FLAGS_C_HWPANELEMU_EXPORT)
FLAGS_C_MBWMIDI_CONFIG := $(addprefix -I,$(DIR_HWPANELEMU))
FLAGS_C_MINIMALGRAPHICS_CONFIG := $(addprefix -I,$(DIR_HWPANELEMU))

#################################################################################3

SOURCES_C_APP := $(wildcard $(DIR_APP)/*.c)
OBJECTS_APP := $(addprefix $(DIR_OBJ)/, $(SOURCES_C_APP:.c=.o))
OBJECTS_TARGET += $(OBJECTS_APP)
DIR_OBJ_APP := $(DIR_OBJ)/$(DIR_APP)

include $(DIR_HWPANELEMU)/make.mk
include $(DIR_MBWMIDI)/make.mk
include $(DIR_MINIMALGRAPHICS)/make.mk

FLAGS_C_APP := $(FLAGS_C_COMMON)
FLAGS_C_APP += $(addprefix -I,$(DIR_APP) $(DIRS_INCLUDE_HWPANELEMU) $(DIRS_INCLUDE_MBWMIDI) $(DIRS_INCLUDE_MINIMALGRAPHICS))
FLAGS_C_APP += -std=c11
FLAGS_C_APP += -MMD -MP
FLAGS_C_APP += -Wall -Wextra -Wpedantic
FLAGS_C_APP += -Wdouble-promotion

$(DIR_OBJ_APP):
	mkdir -p $@

$(DIR_OBJ_APP)/%.o: $(DIR_APP)/%.c | $(DIR_OBJ_APP)
	@echo "App C> $(notdir $<)"
	@$(CC) -c $(FLAGS_C_APP) $< -o $@

$(OBJECTS_APP): Makefile

-include $(wildcard $(DIR_OBJ_APP)/*.d)

$(TARGET_PE) : $(OBJECTS_TARGET)
	@echo "LD> $@..."
	@$(CPP) $^ -o $@ $(LINKER_FLAGS_HWPANELEMU)

clean:
	-rm -fR $(DIR_OBJ)




