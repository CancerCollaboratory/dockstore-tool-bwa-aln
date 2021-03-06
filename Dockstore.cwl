#!/usr/bin/env cwl-runner

class: CommandLineTool

cwlVersion: v1.0

dct:creator:
  '@id': http://orcid.org/0000-0001-9102-5681
  foaf:name: Andrey Kartashov
  foaf:mbox: mailto:Andrey.Kartashov@cchmc.org
dct:description: 'Developed at Cincinnati Children’s Hospital Medical Center for the
  CWL consortium http://commonwl.org/ Original URL: https://github.com/common-workflow-language/workflows'
dct:contributor:
  '@id': http://orcid.org/0000-0002-6130-1021
  foaf:name: Denis Yuen
  foaf:mbox: mailto:help@cancercollaboratory.org
requirements:
- class: DockerRequirement
  dockerPull: quay.io/collaboratory/dockstore-tool-bwa-aln:1.0

inputs:
  input:
    type: File
    inputBinding:
      position: 5

  prefix:
    type: File
    inputBinding:
      position: 4
    secondaryFiles:
    - .amb
    - .ann
    - .pac
    - .rpac
    - .bwt
    - .rbwt
    - .sa
    - .rsa
  output_name:
    type: string
    inputBinding:
      position: 5
      prefix: -f
  threads:
    type: int?
    inputBinding:
      position: 1
      prefix: -t
outputs:
  output:
    type: File
    outputBinding:
      glob: $(inputs.output_name)

baseCommand: [bwa, aln]
doc: |
  Usage:   bwa aln [options] <prefix> <in.fq>

  Options: -n NUM    max #diff (int) or missing prob under 0.02 err rate (float) [0.04]
           -o INT    maximum number or fraction of gap opens [1]
           -e INT    maximum number of gap extensions, -1 for disabling long gaps [-1]
           -i INT    do not put an indel within INT bp towards the ends [5]
           -d INT    maximum occurrences for extending a long deletion [10]
           -l INT    seed length [32]
           -k INT    maximum differences in the seed [2]
           -m INT    maximum entries in the queue [2000000]
           -t INT    number of threads [1]
           -M INT    mismatch penalty [3]
           -O INT    gap open penalty [11]
           -E INT    gap extension penalty [4]
           -R INT    stop searching when there are >INT equally best hits [30]
           -q INT    quality threshold for read trimming down to 35bp [0]
           -f FILE   file to write output to instead of stdout
           -B INT    length of barcode
           -c        input sequences are in the color space
           -L        log-scaled gap penalty for long deletions
           -N        non-iterative mode: search for all n-difference hits (slooow)
           -I        the input is in the Illumina 1.3+ FASTQ-like format
           -b        the input read file is in the BAM format
           -0        use single-end reads only (effective with -b)
           -1        use the 1st read in a pair (effective with -b)
           -2        use the 2nd read in a pair (effective with -b)

