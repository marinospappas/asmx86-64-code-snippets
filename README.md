
# x86-64 Assemly code samples

Sample code to work with strings and integers and read from input and write to output.

AT&T assembly is used mostly but there will also be te occasional Intel example.

Some code samples are using the C libraries and have to compiled with `gcc` 
Others use Linux system calls and have to be compiled with `as` and linked with `ld`
If the linker produces error related to Position Independent code use `-static`

Those samples that use Intel syntax can be compiled with `nasm` and then linked with `ld` as above.
