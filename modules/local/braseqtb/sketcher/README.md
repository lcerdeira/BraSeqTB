# minmer_sketch process testing:

This process creates minmer sketches of the input FASTQs using Mash (k=21,31) and Sourmash (k=21,31,51)

## About testing this process:

Using DSL2 each module can be tested separately, using a test workflow inside the process.nf file, testing requires 3 itens:  
- the local files in `test_data` 
- params in  `test_params.yaml`
- `test` profile in `nextflow.config`

## How to test it:

$ nextflow run minmer_sketch.nf -params-file test_params.yaml -profile test,docker -entry test


if you've used `braseqtb conda activate` you can also trade `docker` by conda to test with conda. 