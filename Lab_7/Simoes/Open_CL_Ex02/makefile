all:
	gcc -I /usr/local/cuda-10.1/include/ host_code_file.c -lm -lOpenCL -o opencl_CHAD_example.o

run:	all
	./opencl_CHAD_example.o

clean:
	rm *.o
