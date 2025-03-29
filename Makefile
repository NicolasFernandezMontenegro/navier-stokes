CC=gcc
CFLAGS=-std=c11 -Wall -Wextra -Wno-unused-parameter -fprofile-generate $(EXTRA_FLAGS)
LDFLAGS=

TARGETS=demo headless
SOURCES=$(shell echo *.c)
COMMON_OBJECTS=solver.o wtime.o

# Definir las optimizaciones
OPTIMIZATION_LEVELS = O0 O1 O2 O3 Ofast

OPTIMIZATION_CACHE = funroll-loops floop-block fprefetch-loop-arrays floop-interchange floop-strip-mine

# Directorio para los resultados
RESULTS_DIR=results

all: $(TARGETS)

demo: demo.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS) -lGL -lGLU -lglut

headless: headless.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)
	
on: 
	mkdir -p $(RESULTS_DIR)
	$(foreach OPT, $(OPTIMIZATION_LEVELS), \
		$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS=-$(OPT) && \
		echo "Running perf for -$(OPT) optimization..." && \
		perf stat -o $(RESULTS_DIR)/perf_$(OPT)_headless.txt ./headless && \
		echo "Results saved to $(RESULTS_DIR)/perf_$(OPT)_headless.txt"; )

native:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -o $(RESULTS_DIR)/perf_native_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_native_headless.txt"; 
	
flto:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -flto" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -o $(RESULTS_DIR)/perf_flto_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_flto_headless.txt"; 

ffast-math:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -ffast-math" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -o $(RESULTS_DIR)/perf_ffast_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_ffast_headless.txt"; 
	
cache-aware: 
	mkdir -p $(RESULTS_DIR)
	$(foreach OPT, $(OPTIMIZATION_CACHE), \
		$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS=-$(OPT) && \
		echo "Running perf for -$(OPT) optimization..." && \
		perf stat -o $(RESULTS_DIR)/perf_$(OPT)_headless.txt ./headless && \
		echo "Results saved to $(RESULTS_DIR)/perf_$(OPT)_headless.txt"; )

	
clean:
	rm -f $(TARGETS) *.o .depend *~

.depend: *.[ch]
	$(CC) -MM $(SOURCES) >.depend

-include .depend

.PHONY: clean all
