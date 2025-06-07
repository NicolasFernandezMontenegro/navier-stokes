CC=nvcc
CFLAGS= -Xcompiler -Wall -02 -use_fast_math -arch=sm_50 
LDFLAGS= 
FLAGS_GCC= -ftree-vectorize -fopt-info-vec -fopt-info-vec-missed
FLAGS_CLANG = -Rpass=loop-vectorize -Rpass-missed=loop-vectorize

TARGETS=demo headless
SOURCES=$(shell echo *.c)
COMMON_OBJECTS=solver.o timing.o

# Definir las optimizaciones
OPTIMIZATION_LEVELS = O0 O1 O2 O3 Ofast
N_SIZE = 128 256 512 1024


# Directorio para los resultados
RESULTS_DIR=results

#Metricas para perf:
STATS_PERF=instructions,branches,branch-misses,cycles,page-faults,context-switches

all: $(TARGETS)

demo: demo.o $(COMMON_OBJECTS) 
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS) -lGL -lGLU -lglut

headless: headless.o $(COMMON_OBJECTS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

run_all:  o0 comb_2 comb_3

run_all_clang: comb_2_clang comb_3_clang

demo_1:
	$(MAKE) demo EXTRA_FLAGS="-O3 -march=native -ffast-math -flto -funroll-loops -floop-block -fprefetch-loop-arrays"

o0:
	for N in $(N_SIZE); do \
		$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O0" && \
		echo "Running perf for -march=native optimization..." && \
		perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_-O0_headless.txt ./headless > salida.text && \
		sed -n '2p' salida.text >> $(RESULTS_DIR)/perf_-O0_headless.txt && rm -f salida.text && \
			awk '/ns per cell total/ { \
			split($$0, a, ","); \
			ns=a[1]; \
			printf "\n%.6f cells per sec\n", 1e9/ns \
		}' $(RESULTS_DIR)/perf_-O0_headless.txt >> $(RESULTS_DIR)/perf_-O0_headless.txt && \
		echo "Results saved to $(RESULTS_DIR)/perf_-O0_headless.txt"; 
	done \

comb_1:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O2 -march=native -flto -funroll-loops -fprefetch-loop-arrays" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_comb_1_headless.txt ./headless > salida.text && \
	sed -n '2p' salida.text >> $(RESULTS_DIR)/perf_comb_1_headless.txt && rm -f salida.text && \
	echo "Results saved to $(RESULTS_DIR)/perf_comb_1_headless.txt"; 

comb_2:
	for N in $(N_SIZE); do \
		make clean && \
		make headless EXTRA_FLAGS="-DN_SIZE=$$N -O3 -march=native -flto -ffast-math -funroll-loops -fprefetch-loop-arrays -ftree-vectorize -fopt-info-vec" && \
		echo "Running perf for -march=native optimization..." && \
		perf stat  -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_comb_2_$$N.txt ./headless > salida.text && \
		sed -n '2p' salida.text >> $(RESULTS_DIR)/perf_comb_2_$$N.txt && rm -f salida.text && \
			awk '/ns per cell total/ { \
			split($$0, a, ","); \
			ns=a[1]; \
			printf "\n%.6f cells per sec\n", 1e6/ns \
		}' $(RESULTS_DIR)/perf_comb_2_$$N.txt >> $(RESULTS_DIR)/perf_comb_2_$$N.txt  && \
		echo "Results saved to $(RESULTS_DIR)/perf_comb_2_$$N.txt"; \
	done \
	
comb_3:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -flto -ffast-math -funroll-loops -floop-block -fprefetch-loop-arrays -ftree-vectorize -fopt-info-vec" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat  -e $(STATS_PERF) -o $(RESULTS_DIR)/perf_comb_3_headless.txt ./headless > salida.text && \
	sed -n '2p' salida.text >> $(RESULTS_DIR)/perf_comb_3_headless.txt && rm -f salida.text && \
		awk '/ns per cell total/ { \
		split($$0, a, ","); \
		ns=a[1]; \
		printf "\n%.6f cells per sec\n", 1e9/ns \
	}' $(RESULTS_DIR)/perf_comb_3_headless.txt >> $(RESULTS_DIR)/perf_comb_3_headless.txt  && \
	echo "Results saved to $(RESULTS_DIR)/perf_comb_3_headless.txt"; 

comb_2_clang:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O2 -march=native -ffast-math -flto -funroll-loops" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e $(STATS_PERF) -o $(RESULTS_DIR)/clag_perf_comb_2_headless.txt ./headless > salida.text && \
	sed -n '2p' salida.text >> $(RESULTS_DIR)/clag_perf_comb_2_headless.txt && rm -f salida.text && \
		awk '/ns per cell total/ { \
		split($$0, a, ","); \
		ns=a[1]; \
		printf "\n%.6f cells per sec\n", 1e9/ns \
	}' $(RESULTS_DIR)/clag_perf_comb_2_headless.txt >> $(RESULTS_DIR)/clag_perf_comb_2_headless.txt  && \
	echo "Results saved to $(RESULTS_DIR)/clag_perf_comb_2_headless.txt";
	
comb_3_clang:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -ffast-math -flto -funroll-loops" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat  -e $(STATS_PERF) -o $(RESULTS_DIR)/clag_perf_comb_3_headless.txt ./headless > salida.text && \
	sed -n '2p' salida.text >> $(RESULTS_DIR)/clag_perf_comb_3_headless.txt && rm -f salida.text && \
		awk '/ns per cell total/ { \
		split($$0, a, ","); \
		ns=a[1]; \
		printf "\n%.6f cells per sec\n", 1e9/ns \
	}' $(RESULTS_DIR)/clag_perf_comb_3_headless.txt >> $(RESULTS_DIR)/clag_perf_comb_3_headless.txt  && \
	echo "Results saved to $(RESULTS_DIR)/clag_perf_comb_3_headless.txt"; 

final_clang:
	$(MAKE) clean && $(MAKE) headless EXTRA_FLAGS="-O3 -march=native -ffast-math -funroll-loops" && \
	echo "Running perf for -march=native optimization..." && \
	perf stat -e task-clock -o $(RESULTS_DIR)/final_clang.txt ./headless > salida.text && \
	sed -n '2p' salida.text >> $(RESULTS_DIR)/final_clang.txt && rm -f salida.text && \
		awk '/ns per cell total/ { \
		split($$0, a, ","); \
		ns=a[1]; \
		printf "\n%.6f cells per sec\n", 1e9/ns \
	}' $(RESULTS_DIR)/final_clang.txt >> $(RESULTS_DIR)/final_clang.txt  && \
	echo "Results saved to $(RESULTS_DIR)/final_clang.txt"; 

clean:
	rm -f $(TARGETS) *.o .depend *~

.depend: *.[ch]
	$(CC) -MM $(SOURCES) >.depend

-include .depend

.PHONY: clean all
