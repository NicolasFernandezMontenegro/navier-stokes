# Mediciones

* En este archivo se encuentran algunos resultados de correr 10 veces el programa Stream en la computadora Atom y luego mediciones de correr 10 veces el programa time_sgemm.c y 10 veces el programa time_dgemm.c

## Stream en Atom 

-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 94476 microseconds.
   (= 94476 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           20973.2     0.112602     0.102386     0.120433
Scale:          21922.1     0.118827     0.097954     0.125794
Add:            23442.6     0.149141     0.137401     0.156458
Triad:          22194.2     0.152359     0.145130     0.161043
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ htop
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 89718 microseconds.
   (= 89718 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           20599.4     0.113186     0.104244     0.123188
Scale:          19214.4     0.124215     0.111758     0.133768
Add:            21700.0     0.156524     0.148435     0.162057
Triad:          22739.1     0.156232     0.141652     0.168026
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 55284 microseconds.
   (= 55284 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           33786.4     0.064607     0.063557     0.065724
Scale:          30305.6     0.071452     0.070857     0.072590
Add:            35861.0     0.090559     0.089820     0.091555
Triad:          36003.8     0.090128     0.089464     0.091845
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 55222 microseconds.
   (= 55222 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           33647.7     0.064452     0.063819     0.065966
Scale:          30466.4     0.070730     0.070483     0.071713
Add:            35908.2     0.089956     0.089702     0.090857
Triad:          36045.7     0.090820     0.089360     0.107264
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 55156 microseconds.
   (= 55156 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           33675.8     0.064821     0.063766     0.066617
Scale:          30432.3     0.070957     0.070562     0.071386
Add:            35913.4     0.090422     0.089689     0.091241
Triad:          36018.7     0.089903     0.089427     0.090744
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 55385 microseconds.
   (= 55385 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           33368.5     0.065214     0.064353     0.067189
Scale:          30199.0     0.071553     0.071107     0.072298
Add:            35496.7     0.091183     0.090742     0.092445
Triad:          35737.3     0.090792     0.090131     0.091505
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 55415 microseconds.
   (= 55415 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           33599.7     0.064534     0.063910     0.065851
Scale:          30383.6     0.070894     0.070675     0.071723
Add:            35787.4     0.090650     0.090005     0.095144
Triad:          35829.5     0.090278     0.089899     0.091140
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 54950 microseconds.
   (= 54950 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           33446.4     0.066004     0.064203     0.070167
Scale:          30367.2     0.072186     0.070713     0.076304
Add:            35696.6     0.092204     0.090234     0.097575
Triad:          35742.8     0.091381     0.090117     0.095941
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 55769 microseconds.
   (= 55769 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           33331.2     0.065549     0.064425     0.067942
Scale:          30188.8     0.071418     0.071131     0.072186
Add:            35560.2     0.091094     0.090580     0.093165
Triad:          35643.6     0.091406     0.090368     0.098033
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 56216 microseconds.
   (= 56216 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           33418.7     0.065109     0.064256     0.066168
Scale:          30036.4     0.071872     0.071492     0.073038
Add:            35451.7     0.091286     0.090857     0.092714
Triad:          35472.4     0.091164     0.090804     0.092382
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 54766 microseconds.
   (= 54766 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           33765.1     0.064346     0.063597     0.066148
Scale:          30392.7     0.070886     0.070654     0.071639
Add:            35849.9     0.089935     0.089848     0.090244
Triad:          35923.1     0.089918     0.089665     0.090969
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
cp2025_048@atom:~$ ./stream_exe 
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 15 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 55279 microseconds.
   (= 55279 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           33636.6     0.064451     0.063840     0.065665
Scale:          30451.6     0.070979     0.070517     0.072621
Add:            35885.9     0.090470     0.089758     0.095992
Triad:          35966.8     0.090813     0.089556     0.103585
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays

## Stream compilado con -fmopenmp 
Ejecución 1
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 48
Number of Threads counted = 48
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 23420 microseconds.
   (= 23420 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           92578.5     0.029506     0.023195     0.034110
Scale:          76699.6     0.030499     0.027997     0.032385
Add:            93330.9     0.038108     0.034512     0.042121
Triad:          88624.0     0.038342     0.036345     0.040320
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Ejecución 2
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 48
Number of Threads counted = 48
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 22238 microseconds.
   (= 22238 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           84230.5     0.028617     0.025494     0.030692
Scale:          82794.9     0.028443     0.025936     0.031417
Add:            92243.1     0.037810     0.034919     0.039957
Triad:          93480.1     0.036964     0.034457     0.039484
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Ejecución 3
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 48
Number of Threads counted = 48
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 21617 microseconds.
   (= 21617 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           85719.9     0.027671     0.025051     0.031849
Scale:          84432.6     0.028484     0.025433     0.032383
Add:            99151.8     0.037426     0.032486     0.041415
Triad:          99470.0     0.037550     0.032382     0.041280
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Ejecución 4
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 48
Number of Threads counted = 48
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 23553 microseconds.
   (= 23553 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           82753.1     0.030540     0.025949     0.035912
Scale:          88390.9     0.029797     0.024294     0.033949
Add:            95600.1     0.036924     0.033693     0.039601
Triad:         100069.8     0.037932     0.032188     0.042393
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Ejecución 5
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 48
Number of Threads counted = 48
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 25080 microseconds.
   (= 25080 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           84009.7     0.030704     0.025561     0.035657
Scale:          89477.2     0.027653     0.023999     0.032062
Add:           105149.4     0.036345     0.030633     0.043531
Triad:         106129.9     0.035283     0.030350     0.039559
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Ejecución 6
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 48
Number of Threads counted = 48
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 16710 microseconds.
   (= 16710 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           83822.1     0.029804     0.025618     0.031803
Scale:          87640.1     0.029356     0.024502     0.032694
Add:            95331.0     0.038700     0.033788     0.045507
Triad:          95602.2     0.037228     0.033692     0.042871
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Ejecución 7
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 48
Number of Threads counted = 48
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 30883 microseconds.
   (= 30883 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           81515.1     0.030166     0.026343     0.035537
Scale:          79943.6     0.030145     0.026861     0.031535
Add:            96960.7     0.037478     0.033220     0.041149
Triad:         102255.7     0.037292     0.031500     0.039334
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Ejecución 8
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 48
Number of Threads counted = 48
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 20115 microseconds.
   (= 20115 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           77946.9     0.030447     0.027549     0.033251
Scale:          88467.3     0.029112     0.024273     0.031493
Add:           100032.0     0.036166     0.032200     0.038252
Triad:          97904.4     0.037149     0.032900     0.042428
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Ejecución 9
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 48
Number of Threads counted = 48
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 24749 microseconds.
   (= 24749 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           91462.5     0.028630     0.023478     0.035361
Scale:          89198.9     0.030222     0.024074     0.036589
Add:            96047.4     0.038311     0.033536     0.043170
Triad:         102323.1     0.037487     0.031479     0.043608
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three arrays
-------------------------------------------------------------
Ejecución 10
-------------------------------------------------------------
STREAM version $Revision: 5.10 $
-------------------------------------------------------------
This system uses 8 bytes per array element.
-------------------------------------------------------------
Array size = 134210000 (elements), Offset = 0 (elements)
Memory per array = 1023.9 MiB (= 1.0 GiB).
Total memory required = 3071.8 MiB (= 3.0 GiB).
Each kernel will be executed 10 times.
 The *best* time for each kernel (excluding the first iteration)
 will be used to compute the reported bandwidth.
-------------------------------------------------------------
Number of Threads requested = 48
Number of Threads counted = 48
-------------------------------------------------------------
Your clock granularity/precision appears to be 1 microseconds.
Each test below will take on the order of 22948 microseconds.
   (= 22948 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:           86984.1     0.030246     0.024687     0.036932
Scale:          84085.0     0.030983     0.025538     0.037826
Add:           105618.8     0.036775     0.030497     0.046469
Triad:          91488.5     0.038264     0.035207     0.041730
-------------------------------------------------------------
Solution Validates: avg error less than 1.000000e-13 on all three array

## SGEMM N=K=M = 32768 

32768x32768x32768	34.104892 s	   2063303.533630 MFLOPS
32768x32768x32768	35.378323 s	   1989035.607416 MFLOPS
32768x32768x32768	31.432479 s	   2238727.151545 MFLOPS
32768x32768x32768	31.741009 s	   2216966.202230 MFLOPS
32768x32768x32768	31.136570 s	   2260003.082474 MFLOPS
32768x32768x32768	36.529122 s	   1926373.816969 MFLOPS
32768x32768x32768	36.592970 s	   1923012.649087 MFLOPS
32768x32768x32768	37.148205 s	   1894270.373970 MFLOPS
32768x32768x32768	39.397886 s	   1786104.568597 MFLOPS
32768x32768x32768	35.911552 s	   1959501.616017 MFLOPS


## DGEMM N=K=M = 32768 

32768x32768x32768	79.380900 s 	886469.467815 MFLOPS
32768x32768x32768	83.394277 s 	843807.833212 MFLOPS
32768x32768x32768	72.979739 s 	964223.017811 MFLOPS
32768x32768x32768	75.270246 s 	934881.283338 MFLOPS
32768x32768x32768	90.836180 s 	774677.492797 MFLOPS
32768x32768x32768	77.495293 s	   908038.946026 MFLOPS
32768x32768x32768	75.620838 s	   930547.003164 MFLOPS
32768x32768x32768	77.182928 s	   911713.846586 MFLOPS
32768x32768x32768	76.998990 s	   913891.781927 MFLOPS
32768x32768x32768	74.471854 s	   944903.885133 MFLOPS





