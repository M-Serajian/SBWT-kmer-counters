### Color matrix creation ###
This code is used as a preprocessing step in [MTB++](https://github.com/M-Serajian/MTB-plus-plus) which is an antimicrobial resistance detector tool for mycobacterium tuberculosis. 


Before compiling this code, you should have compiled SBWT. See instructions at the root of the repository.

Then, you can compile this code by just running `make`.

Then, to build the SBWT index and find all the non-zero counters for all k-mers, run the pipeline:

```bash
multi_genome_color_matrix.sh
```