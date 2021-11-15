# before compiling do ml shared mpich/ge/gcc/64/3.2.1 mvapich2/gcc/64/2.3b
# OS has been updated, do ml shared mpich/3.2.1 mvapich2/2.3.6

CXX = mpicxx

INC = -I. \
  -I/rsrch3/home/mol_cell_onc/abacolla/include \
  -I/rsrch3/home/mol_cell_onc/abacolla/include/other

LDLIBS = 
LDFLAGS = 
CXXFLAGS = -Wall -Wextra -O3

TARGET = vga_submitMpiJob2_oldCompiler_newOS

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
