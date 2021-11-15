# module load openmpi/4.0.1

CXX = mpicxx

INC = -I. \
  -I/rsrch3/home/mol_cell_onc/abacolla/include \

LDLIBS = 
LDFLAGS = 
CXXFLAGS = -std=c++17 -Wall -Wextra -O3

TARGET = vga_g4Search

BUILD_DIR = ./build
SRCS = $(wildcard *.cpp)
OBJ = $(SRCS:%.cpp=$(BUILD_DIR)/%.o)
DEPS = $(OBJ:%.o=%.d)

$(TARGET) : $(BUILD_DIR)/$(TARGET)

$(BUILD_DIR)/$(TARGET) : $(OBJ)
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS) $(LDLIBS)

-include $(DEPS)

$(BUILD_DIR)/%.o : %.cpp
	mkdir -p $(@D)
	$(CXX) -static $(CXXFLAGS) -MMD -c $< -o $@ $(INC)

.PHONY: all clean tests

all: clean $(TARGET)

clean:
	rm -fr $(BUILD_DIR)

tests: $(TARGET)
	$(BUILD_DIR)/$(TARGET)
