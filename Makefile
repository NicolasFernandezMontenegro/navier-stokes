CC=gcc
CFLAGS=-std=c11 -Wall -Wextra -Wno-unused-parameter $(EXTRA_FLAGS)
LDFLAGS=

TARGETS=demo headless
SOURCES=$(shell echo *.c)
COMMON_OBJECTS=solver.o wtime.o

# Definir las optimizaciones
OPTIMIZATION_LEVELS = O0 O1 O2 O3 Ofast

OPTIMIZATION_CACHE = funroll-loops floop-block fprefetch-loop-arrays floop-interchange floop-strip-mine


# Directorio para los resultados
RESULTS_DIR=results

#Metricas para perf:
STATS_PERF=instructions,branches,branch-misses,cycles,page-faults,context-switches

all: $(TARGETS)

demo: demo.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS) -lGL -lGLU -lglut

headless: headless.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

run_all: on native flto ffast-math cache-aware fprofile fprofile_comb
	
	
on: 
	$(foreach OPT, $(OPTIMIZATION_LEVELS), \
		$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS=-$(OPT) && \
		echo "Running perf for -$(OPT) optimization..." && \
		perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_$(OPT)_headless.txt ./headless && \
		echo "Results saved to $(RESULTS_DIR)/perf_$(OPT)_headless.txt"; )

native:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_native_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_native_headless.txt"; 
	
flto:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -flto" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_flto_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_flto_headless.txt"; 

ffast-math:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -ffast-math" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_ffast_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_ffast_headless.txt"; 
	
cache-aware: 
	$(foreach OPT, $(OPTIMIZATION_CACHE), \
		$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -$(OPT)" && \
		echo "Running perf for -$(OPT) optimization..." && \
		perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_$(OPT)_headless.txt ./headless && \
		echo "Results saved to $(RESULTS_DIR)/perf_$(OPT)_headless.txt"; )
	
hugepage:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -falign-functions=32 -falign-jumps=32 -falign-loops=32 -D USE_HUGEPAGES" && \
	echo "Running perf for -march=native optimization..." && \
	LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libhugetlbfs.so HUGETLB_MORECORE=yes HUGETLB_FORCE=yes perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_huge_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_huge_headless.txt"; 
	
comb_1:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O2 -march=native -flto -funroll-loops -fprefetch-loop-arrays" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_comb_1_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_comb_1_headless.txt"; 
	
comb_2:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -ffast-math -flto -funroll-loops -floop-block -fprefetch-loop-arrays" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_comb_2_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_comb_2_headless.txt"; 

comb_3:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -ffast-math -flto -funroll-loops -floop-block -fprefetch-loop-arrays -floop-interchange" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_comb_3_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_comb_3_headless.txt"; 

fprofile:
	rm -f *.gcda
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -g -march=native -fprofile-generate" && \
	./headless > /dev/null && \
	echo "Running first time | Recollecting data"
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -g -march=native -fprofile-use" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_fprofile_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_fprofile_headless.txt"; 

fprofile_comb:
	rm -f *.gcda
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -g -march=native -ffast-math -flto -funroll-loops -floop-block -fprefetch-loop-arrays -floop-interchange -fprofile-generate" && \
	./headless > /dev/null && \
	echo "Running first time | Recollecting data"
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -g -march=native -ffast-math -flto -funroll-loops -floop-block -fprefetch-loop-arrays -floop-interchange -fprofile-use" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_fprofile_comb_headless.txt ./headless && \
	echo "Results saved to $(RESULTS_DIR)/perf_fprofile_comb_headless.txt"; 
	
clean:
	rm -f $(TARGETS) *.o .depend *~

.depend: *.[ch]
	$(CC) -MM $(SOURCES) >.depend

-include .depend

.PHONY: clean all
